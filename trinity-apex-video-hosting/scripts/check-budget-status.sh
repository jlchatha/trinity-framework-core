#!/bin/bash
# Check current budget utilization and video hosting status

set -e

# Source config
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}
BUDGET_NAME="Trinity-Apex-Video-Hosting"

echo "======================================"
echo "Trinity Apex Video Budget Status"
echo "======================================"
echo ""

# Get account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile ${PROFILE})

# Get budget details
BUDGET_INFO=$(aws budgets describe-budget \
    --account-id ${ACCOUNT_ID} \
    --budget-name ${BUDGET_NAME} \
    --profile ${PROFILE} \
    --region ${REGION} 2>/dev/null || echo "NOT_FOUND")

if [ "${BUDGET_INFO}" = "NOT_FOUND" ]; then
    echo "❌ Budget not configured yet"
    echo "   Run ./setup-budget.sh to create budget"
    exit 1
fi

# Parse budget info
LIMIT=$(echo ${BUDGET_INFO} | jq -r '.Budget.BudgetLimit.Amount')
ACTUAL=$(echo ${BUDGET_INFO} | jq -r '.Budget.CalculatedSpend.ActualSpend.Amount // "0"')
PERCENTAGE=$(echo "scale=2; ($ACTUAL / $LIMIT) * 100" | bc)

echo "Monthly Budget: \$${LIMIT}"
echo "Current Spend: \$${ACTUAL}"
echo "Utilization: ${PERCENTAGE}%"
echo ""

# Show status
if (( $(echo "$PERCENTAGE < 80" | bc -l) )); then
    echo "✅ Status: Normal operations"
elif (( $(echo "$PERCENTAGE < 90" | bc -l) )); then
    echo "⚠️  Status: Warning - Approaching limit"
elif (( $(echo "$PERCENTAGE < 100" | bc -l) )); then
    echo "🚨 Status: Critical - Near limit"
else
    echo "❌ Status: Budget exceeded - Video disabled"
fi

echo ""

# Calculate remaining views
if (( $(echo "$PERCENTAGE < 100" | bc -l) )); then
    REMAINING_BUDGET=$(echo "scale=2; $LIMIT - $ACTUAL" | bc)
    REMAINING_GB=$(echo "scale=2; $REMAINING_BUDGET / 0.085" | bc)
    REMAINING_VIEWS=$(echo "scale=0; ($REMAINING_GB * 1000) / 46" | bc)
    
    echo "Remaining this month:"
    echo "  Budget: \$${REMAINING_BUDGET}"
    echo "  Data: ${REMAINING_GB} GB"
    echo "  Views: ~${REMAINING_VIEWS} (46MB video)"
fi

# Check CloudFront status
if [ -f ../config/distribution-id.txt ]; then
    DIST_ID=$(cat ../config/distribution-id.txt)
    DIST_STATUS=$(aws cloudfront get-distribution \
        --id ${DIST_ID} \
        --profile ${PROFILE} \
        --query "Distribution.DistributionConfig.Enabled" --output text 2>/dev/null || echo "UNKNOWN")
    
    echo ""
    echo "CloudFront Distribution:"
    echo "  ID: ${DIST_ID}"
    echo "  Enabled: ${DIST_STATUS}"
fi

echo ""
echo "======================================"