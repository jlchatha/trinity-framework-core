#!/bin/bash
# Trinity Apex Video Hosting - Complete Deployment Script
# Deploys AWS infrastructure with $50/month budget protection

set -e

# Configuration
export BUCKET_NAME="trinity-apex-videos"
export PROFILE="trinity-beta2"
export REGION="us-east-1"
export BUDGET_LIMIT="50.0"
export ALERT_EMAIL="admin@trinityapex.ai"
export VIDEO_PATH="../../../trinity-apex-website/video/OVERSEER_k3s.mp4"

echo "==================================="
echo "Trinity Apex Video Hosting Setup"
echo "==================================="
echo "Budget Cap: $${BUDGET_LIMIT}/month"
echo "Alert Email: ${ALERT_EMAIL}"
echo "AWS Profile: ${PROFILE}"
echo "Region: ${REGION}"
echo ""

# Check AWS CLI
if ! command -v aws &> /dev/null; then
    echo "ERROR: AWS CLI not found. Please install AWS CLI v2."
    exit 1
fi

# Verify credentials
echo "Verifying AWS credentials..."
aws sts get-caller-identity --profile ${PROFILE} > /dev/null || {
    echo "ERROR: Unable to authenticate with AWS. Check your profile: ${PROFILE}"
    exit 1
}

# Step 1: Create S3 infrastructure
echo ""
echo "Step 1: Creating S3 infrastructure..."
./create-infrastructure.sh

# Step 2: Setup budget and alerts
echo ""
echo "Step 2: Setting up budget controls..."
./setup-budget.sh

# Step 3: Deploy Lambda function
echo ""
echo "Step 3: Deploying Lambda auto-shutoff..."
./deploy-lambda.sh

# Step 4: Create CloudFront distribution
echo ""
echo "Step 4: Creating CloudFront distribution..."
./create-cloudfront.sh

# Step 5: Upload video if exists
if [ -f "${VIDEO_PATH}" ]; then
    echo ""
    echo "Step 5: Uploading video..."
    ./upload-video.sh "${VIDEO_PATH}"
else
    echo ""
    echo "Step 5: Video not found at ${VIDEO_PATH}"
    echo "Run './upload-video.sh /path/to/video.mp4' when ready"
fi

# Step 6: Create monitoring dashboard
echo ""
echo "Step 6: Creating CloudWatch dashboard..."
./create-dashboard.sh

# Final summary
echo ""
echo "==================================="
echo "✅ Deployment Complete!"
echo "==================================="
echo ""
echo "Next Steps:"
echo "1. Wait 15-20 minutes for CloudFront to deploy globally"
echo "2. Get your video URL: ./get-video-url.sh"
echo "3. Update your website HTML with the CloudFront URL"
echo "4. Test in Firefox to confirm compatibility"
echo ""
echo "Budget Protection Active:"
echo "- Alert at: $$(echo "${BUDGET_LIMIT} * 0.8" | bc) (80%)"
echo "- Auto-disable at: $${BUDGET_LIMIT} (100%)"
echo ""
echo "Support: ${ALERT_EMAIL}"