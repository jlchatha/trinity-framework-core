#!/bin/bash
# Setup AWS Budget with email alerts (simplified version)

set -e

# Source config
BUDGET_LIMIT=${BUDGET_LIMIT:-"50.0"}
ALERT_EMAIL=${ALERT_EMAIL:-"admin@trinityapex.ai"}
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile ${PROFILE})

echo "Setting up simplified budget for account: ${ACCOUNT_ID}"

# Create budget configuration
mkdir -p ../config
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

# Create notifications configuration (email only)
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
                "SubscriptionType": "EMAIL",
                "Address": "${ALERT_EMAIL}"
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
                "SubscriptionType": "EMAIL",
                "Address": "${ALERT_EMAIL}"
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
        aws budgets update-budget \
            --account-id ${ACCOUNT_ID} \
            --budget file://../config/budget-config.json \
            --profile ${PROFILE} \
            --region ${REGION}
    }

echo "✅ Budget configured successfully"
echo "   - Monthly limit: $${BUDGET_LIMIT}"
echo "   - Email alerts at: 80%, 90%, 100%"
echo "   - Alert email: ${ALERT_EMAIL}"