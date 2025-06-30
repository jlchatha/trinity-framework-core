# Required IAM Permissions for Trinity Apex Video Hosting

## Current Permission Errors

Based on the deployment attempt, the `trinity-beta2-admin` user needs these additional permissions:

### 1. SNS (Simple Notification Service)
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:CreateTopic",
                "sns:Subscribe",
                "sns:Publish",
                "sns:ListTopics",
                "sns:GetTopicAttributes",
                "sns:SetTopicAttributes"
            ],
            "Resource": "*"
        }
    ]
}
```

### 2. AWS Budgets
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "budgets:CreateBudget",
                "budgets:UpdateBudget",
                "budgets:ModifyBudget",
                "budgets:DescribeBudget",
                "budgets:DescribeBudgets"
            ],
            "Resource": "*"
        }
    ]
}
```

### 3. CloudFront
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateDistribution",
                "cloudfront:UpdateDistribution",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions",
                "cloudfront:CreateOriginAccessControl",
                "cloudfront:ListOriginAccessControls",
                "cloudfront:GetOriginAccessControl"
            ],
            "Resource": "*"
        }
    ]
}
```

### 4. IAM (for Lambda roles)
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:GetRole",
                "iam:PutRolePolicy",
                "iam:AttachRolePolicy",
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::644177601378:role/trinity-apex-video-budget-limiter-role"
            ]
        }
    ]
}
```

### 5. Lambda
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:GetFunction",
                "lambda:InvokeFunction"
            ],
            "Resource": "*"
        }
    ]
}
```

### 6. CloudWatch (for monitoring)
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutDashboard",
                "cloudwatch:GetDashboard",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DescribeAlarms",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
```

## Complete IAM Policy (Combined)

Create a new policy called `TrinityApexVideoHostingPolicy`:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SNSPermissions",
            "Effect": "Allow",
            "Action": [
                "sns:CreateTopic",
                "sns:Subscribe",
                "sns:Publish",
                "sns:ListTopics",
                "sns:GetTopicAttributes",
                "sns:SetTopicAttributes"
            ],
            "Resource": "*"
        },
        {
            "Sid": "BudgetsPermissions",
            "Effect": "Allow",
            "Action": [
                "budgets:CreateBudget",
                "budgets:UpdateBudget",
                "budgets:ModifyBudget",
                "budgets:DescribeBudget",
                "budgets:DescribeBudgets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudFrontPermissions",
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateDistribution",
                "cloudfront:UpdateDistribution",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions",
                "cloudfront:CreateOriginAccessControl",
                "cloudfront:ListOriginAccessControls",
                "cloudfront:GetOriginAccessControl"
            ],
            "Resource": "*"
        },
        {
            "Sid": "IAMPermissions",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:GetRole",
                "iam:PutRolePolicy",
                "iam:AttachRolePolicy",
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::644177601378:role/trinity-apex-video-*"
            ]
        },
        {
            "Sid": "LambdaPermissions",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:GetFunction",
                "lambda:InvokeFunction"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudWatchPermissions",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutDashboard",
                "cloudwatch:GetDashboard",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DescribeAlarms",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
```

## Steps to Apply

1. **AWS Console → IAM → Policies → Create Policy**
2. **Paste the JSON above**
3. **Name: `TrinityApexVideoHostingPolicy`**
4. **Description: `Permissions for Trinity Apex video hosting automation`**
5. **Create Policy**

6. **AWS Console → IAM → Users → trinity-beta2-admin**
7. **Permissions tab → Add permissions → Attach existing policies**
8. **Search for `TrinityApexVideoHostingPolicy`**
9. **Attach policy**

## Alternative: Minimal Permissions

If full automation isn't needed, you only need CloudFront permissions for manual setup:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateDistribution",
                "cloudfront:UpdateDistribution",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions"
            ],
            "Resource": "*"
        }
    ]
}
```

## After Adding Permissions

Run the complete deployment:
```bash
cd trinity-apex-video-hosting
./scripts/deploy-all.sh
```

This will automatically:
- ✅ Create CloudFront distribution
- ✅ Setup $50/month budget with auto-disable
- ✅ Deploy Lambda function for cost protection
- ✅ Create monitoring dashboard
- ✅ Provide final CloudFront URL for website