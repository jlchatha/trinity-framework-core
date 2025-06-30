#!/bin/bash
# Setup AWS Budget with auto-disable actions

set -e

# Source config
BUDGET_LIMIT=${BUDGET_LIMIT:-"50.0"}
ALERT_EMAIL=${ALERT_EMAIL:-"admin@trinityapex.ai"}
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile ${PROFILE})

echo "Setting up budget for account: ${ACCOUNT_ID}"

# Create SNS topic for notifications
TOPIC_ARN=$(aws sns create-topic \
    --name Trinity-Apex-Video-Budget-Alerts \
    --profile ${PROFILE} \
    --region ${REGION} \
    --query TopicArn --output text)

# Subscribe email to topic
aws sns subscribe \
    --topic-arn ${TOPIC_ARN} \
    --protocol email \
    --notification-endpoint ${ALERT_EMAIL} \
    --profile ${PROFILE} \
    --region ${REGION}

echo "📧 Check ${ALERT_EMAIL} to confirm SNS subscription"

# Create budget configuration
cat > ../config/budget-config.json << EOF
{
    "BudgetName": "Trinity-Apex-Video-Hosting",
    "BudgetLimit": {
        "Amount": "${BUDGET_LIMIT}",
        "Unit": "USD"
    },
    "TimeUnit": "MONTHLY",
    "BudgetType": "COST",
    "CostFilters": {
        "Service": ["Amazon CloudFront", "Amazon Simple Storage Service"]
    },
    "CostTypes": {
        "IncludeTax": true,
        "IncludeSubscription": false,
        "UseBlended": false,
        "IncludeRefund": false,
        "IncludeCredit": false,
        "IncludeUpfront": false,
        "IncludeRecurring": true,
        "IncludeOtherSubscription": false,
        "IncludeSupport": false,
        "IncludeDiscount": false,
        "UseAmortized": false
    }
}
EOF

# Create notifications configuration
cat > ../config/notifications.json << EOF
[
    {
        "Notification": {
            "NotificationType": "ACTUAL",
            "ComparisonOperator": "GREATER_THAN",
            "Threshold": 80.0,
            "ThresholdType": "PERCENTAGE"
        },
        "Subscribers": [
            {
                "SubscriptionType": "SNS",
                "Address": "${TOPIC_ARN}"
            },
            {
                "SubscriptionType": "EMAIL",
                "Address": "${ALERT_EMAIL}"
            }
        ]
    },
    {
        "Notification": {
            "NotificationType": "ACTUAL",
            "ComparisonOperator": "GREATER_THAN",
            "Threshold": 90.0,
            "ThresholdType": "PERCENTAGE"
        },
        "Subscribers": [
            {
                "SubscriptionType": "SNS",
                "Address": "${TOPIC_ARN}"
            }
        ]
    },
    {
        "Notification": {
            "NotificationType": "ACTUAL",
            "ComparisonOperator": "GREATER_THAN",
            "Threshold": 100.0,
            "ThresholdType": "PERCENTAGE"
        },
        "Subscribers": [
            {
                "SubscriptionType": "SNS",
                "Address": "${TOPIC_ARN}"
            }
        ]
    }
]
EOF

# Create the budget
aws budgets create-budget \
    --account-id ${ACCOUNT_ID} \
    --budget file://../config/budget-config.json \
    --notifications-with-subscribers file://../config/notifications.json \
    --profile ${PROFILE} \
    --region ${REGION} || {
        echo "Budget might already exist, updating..."
        # Update if exists
        aws budgets update-budget \
            --account-id ${ACCOUNT_ID} \
            --budget file://../config/budget-config.json \
            --profile ${PROFILE} \
            --region ${REGION}
    }

# Store SNS topic ARN for Lambda
echo ${TOPIC_ARN} > ../config/sns-topic-arn.txt

echo "✅ Budget configured successfully"
echo "   - Monthly limit: $${BUDGET_LIMIT}"
echo "   - Alerts at: 80%, 90%, 100%"
echo "   - SNS Topic: ${TOPIC_ARN}"