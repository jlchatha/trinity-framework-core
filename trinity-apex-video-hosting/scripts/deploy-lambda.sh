#!/bin/bash
# Deploy Lambda function for budget auto-shutoff

set -e

# Source config
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}
FUNCTION_NAME="trinity-apex-video-budget-limiter"

echo "Deploying Lambda function: ${FUNCTION_NAME}"

# Create IAM role for Lambda
cat > ../policies/lambda-trust-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

# Create IAM role
ROLE_ARN=$(aws iam create-role \
    --role-name ${FUNCTION_NAME}-role \
    --assume-role-policy-document file://../policies/lambda-trust-policy.json \
    --profile ${PROFILE} \
    --query Role.Arn --output text 2>/dev/null || \
    aws iam get-role --role-name ${FUNCTION_NAME}-role --profile ${PROFILE} --query Role.Arn --output text)

# Create Lambda execution policy
cat > ../policies/lambda-execution-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:${REGION}:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:UpdateDistribution"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "budgets:DescribeBudget"
            ],
            "Resource": "*"
        }
    ]
}
EOF

# Attach policy to role
aws iam put-role-policy \
    --role-name ${FUNCTION_NAME}-role \
    --policy-name ${FUNCTION_NAME}-policy \
    --policy-document file://../policies/lambda-execution-policy.json \
    --profile ${PROFILE}

# Wait for role to propagate
echo "Waiting for IAM role to propagate..."
sleep 10

# Package Lambda function
cd ../lambda
zip -r ../lambda-package.zip budget-limiter.py

# Create or update Lambda function
aws lambda create-function \
    --function-name ${FUNCTION_NAME} \
    --runtime python3.9 \
    --role ${ROLE_ARN} \
    --handler budget-limiter.lambda_handler \
    --zip-file fileb://../lambda-package.zip \
    --timeout 60 \
    --memory-size 128 \
    --environment Variables="{BUDGET_LIMIT='${BUDGET_LIMIT:-50.0}'}" \
    --profile ${PROFILE} \
    --region ${REGION} 2>/dev/null || {
        echo "Function exists, updating code..."
        aws lambda update-function-code \
            --function-name ${FUNCTION_NAME} \
            --zip-file fileb://../lambda-package.zip \
            --profile ${PROFILE} \
            --region ${REGION}
    }

# Clean up
cd ../scripts
rm -f ../lambda-package.zip

# Get Lambda ARN
LAMBDA_ARN=$(aws lambda get-function \
    --function-name ${FUNCTION_NAME} \
    --profile ${PROFILE} \
    --region ${REGION} \
    --query Configuration.FunctionArn --output text)

# Store Lambda ARN for budget action
echo ${LAMBDA_ARN} > ../config/lambda-arn.txt

echo "✅ Lambda function deployed successfully"
echo "   - Function: ${FUNCTION_NAME}"
echo "   - ARN: ${LAMBDA_ARN}"