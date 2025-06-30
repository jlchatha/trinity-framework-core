"""
Trinity Apex Video Budget Limiter
Automatically disables CloudFront distribution when budget exceeded
"""
import json
import os
import boto3
from datetime import datetime

def lambda_handler(event, context):
    """
    Triggered by AWS Budgets when threshold reached
    Disables CloudFront distribution to prevent overage
    """
    
    # Initialize clients
    cf = boto3.client('cloudfront')
    sns = boto3.client('sns')
    
    # Get environment variables
    distribution_id = os.environ.get('DISTRIBUTION_ID')
    sns_topic_arn = os.environ.get('SNS_TOPIC_ARN')
    budget_limit = os.environ.get('BUDGET_LIMIT', '50.0')
    
    if not distribution_id:
        return {
            'statusCode': 400,
            'body': json.dumps('DISTRIBUTION_ID not configured')
        }
    
    try:
        # Get current distribution config
        response = cf.get_distribution_config(Id=distribution_id)
        config = response['DistributionConfig']
        etag = response['ETag']
        
        # Check if already disabled
        if not config['Enabled']:
            return {
                'statusCode': 200,
                'body': json.dumps('Distribution already disabled')
            }
        
        # Disable the distribution
        config['Enabled'] = False
        config['Comment'] = f"Auto-disabled by budget limiter at {datetime.utcnow().isoformat()}"
        
        # Update distribution
        update_response = cf.update_distribution(
            Id=distribution_id,
            DistributionConfig=config,
            IfMatch=etag
        )
        
        # Send notification
        message = f"""
Trinity Apex Video Hosting Auto-Disabled

The CloudFront distribution has been automatically disabled because the monthly budget limit of ${budget_limit} has been reached.

Distribution ID: {distribution_id}
Timestamp: {datetime.utcnow().isoformat()}
Action Taken: CloudFront distribution disabled

To re-enable:
1. Review usage and costs in AWS Console
2. Wait for new billing period or increase budget
3. Manually re-enable the distribution

The video on trinityapex.ai will now show a download fallback.

Support: admin@trinityapex.ai
        """
        
        if sns_topic_arn:
            sns.publish(
                TopicArn=sns_topic_arn,
                Subject='⚠️ Trinity Apex Video Hosting Disabled - Budget Limit Reached',
                Message=message
            )
        
        # Log to CloudWatch
        print(json.dumps({
            'action': 'distribution_disabled',
            'distribution_id': distribution_id,
            'budget_limit': budget_limit,
            'timestamp': datetime.utcnow().isoformat()
        }))
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Distribution disabled successfully',
                'distribution_id': distribution_id,
                'timestamp': datetime.utcnow().isoformat()
            })
        }
        
    except Exception as e:
        error_message = f"Error disabling distribution: {str(e)}"
        print(error_message)
        
        # Try to send error notification
        if sns_topic_arn:
            try:
                sns.publish(
                    TopicArn=sns_topic_arn,
                    Subject='❌ Trinity Apex Video Budget Limiter Error',
                    Message=f"Failed to disable CloudFront distribution:\n\n{error_message}"
                )
            except:
                pass
        
        return {
            'statusCode': 500,
            'body': json.dumps({'error': error_message})
        }


def check_budget_status(event, context):
    """
    Optional: Check current budget utilization
    Can be triggered periodically to monitor status
    """
    budgets = boto3.client('budgets')
    
    account_id = boto3.client('sts').get_caller_identity()['Account']
    budget_name = 'Trinity-Apex-Video-Hosting'
    
    try:
        response = budgets.describe_budget(
            AccountId=account_id,
            BudgetName=budget_name
        )
        
        budget = response['Budget']
        
        # Get actual vs budgeted
        if 'CalculatedSpend' in budget:
            actual = float(budget['CalculatedSpend']['ActualSpend']['Amount'])
            limit = float(budget['BudgetLimit']['Amount'])
            percentage = (actual / limit) * 100
            
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'budget_name': budget_name,
                    'limit': limit,
                    'actual': actual,
                    'percentage': round(percentage, 2),
                    'currency': budget['BudgetLimit']['Unit']
                })
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }