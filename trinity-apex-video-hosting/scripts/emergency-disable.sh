#!/bin/bash
# Emergency script to manually disable CloudFront distribution

set -e

# Source config
PROFILE=${PROFILE:-"trinity-beta2"}

if [ ! -f ../config/distribution-id.txt ]; then
    echo "Error: No distribution ID found"
    exit 1
fi

DISTRIBUTION_ID=$(cat ../config/distribution-id.txt)

echo "⚠️  WARNING: This will disable video hosting immediately"
echo "Distribution ID: ${DISTRIBUTION_ID}"
echo ""
read -p "Are you sure? (yes/no): " CONFIRM

if [ "${CONFIRM}" != "yes" ]; then
    echo "Cancelled"
    exit 0
fi

echo "Disabling CloudFront distribution..."

# Get current config
ETAG=$(aws cloudfront get-distribution-config \
    --id ${DISTRIBUTION_ID} \
    --profile ${PROFILE} \
    --query ETag --output text)

# Get and modify config
aws cloudfront get-distribution-config \
    --id ${DISTRIBUTION_ID} \
    --profile ${PROFILE} \
    --query DistributionConfig > /tmp/dist-config.json

# Disable in config
jq '.Enabled = false' /tmp/dist-config.json > /tmp/dist-config-disabled.json

# Update distribution
aws cloudfront update-distribution \
    --id ${DISTRIBUTION_ID} \
    --distribution-config file:///tmp/dist-config-disabled.json \
    --if-match ${ETAG} \
    --profile ${PROFILE}

# Clean up
rm -f /tmp/dist-config*.json

echo "✅ CloudFront distribution disabled"
echo "   Video will show fallback download button"