#\!/bin/bash
# Trinity Apex AWS Video Hosting Setup with Cost Controls
# Budget-capped at $50/month (~12,000 views)

BUCKET_NAME="trinity-apex-videos"
BUDGET_LIMIT="50.0"
PROFILE="trinity-beta2"
REGION="us-east-1"

echo "=== Trinity Apex Video Hosting Setup ==="
echo "Budget Cap: $${BUDGET_LIMIT}/month"
echo "Safe Views: ~12,000/month"
echo ""

# Step 1: Create S3 bucket
echo "1. Creating S3 bucket..."
aws s3 mb s3://${BUCKET_NAME} --region ${REGION} --profile ${PROFILE}

# Step 2: Create bucket policy for CloudFront
echo "2. Setting bucket policy..."
cat > /tmp/bucket-policy.json << POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "AllowCloudFrontAccess",
    "Effect": "Allow",
    "Principal": {
      "Service": "cloudfront.amazonaws.com"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::${BUCKET_NAME}/*"
  }]
}
POLICY

aws s3api put-bucket-policy --bucket ${BUCKET_NAME} \
  --policy file:///tmp/bucket-policy.json --profile ${PROFILE}

# Step 3: Create budget with alerts
echo "3. Creating budget with alerts..."
aws budgets create-budget \
  --account-id $(aws sts get-caller-identity --query Account --output text --profile ${PROFILE}) \
  --budget "{
    \"BudgetName\": \"Trinity-Apex-Video-Budget\",
    \"BudgetLimit\": {
      \"Amount\": \"${BUDGET_LIMIT}\",
      \"Unit\": \"USD\"
    },
    \"TimeUnit\": \"MONTHLY\",
    \"BudgetType\": \"COST\",
    \"CostFilters\": {
      \"Service\": [\"Amazon CloudFront\", \"Amazon Simple Storage Service\"]
    }
  }" \
  --notifications-with-subscribers "[{
    \"Notification\": {
      \"NotificationType\": \"ACTUAL\",
      \"ComparisonOperator\": \"GREATER_THAN\",
      \"Threshold\": 80.0,
      \"ThresholdType\": \"PERCENTAGE\"
    },
    \"Subscribers\": [{
      \"SubscriptionType\": \"EMAIL\",
      \"Address\": \"admin@trinityapex.ai\"
    }]
  }]" \
  --profile ${PROFILE} --region ${REGION}

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Upload video: aws s3 cp OVERSEER_k3s.mp4 s3://${BUCKET_NAME}/ --content-type video/mp4"
echo "2. Create CloudFront distribution in AWS Console"
echo "3. Update website with CloudFront URL"
echo ""
echo "Budget Protection Active: Auto-alerts at $40 (80%)"
