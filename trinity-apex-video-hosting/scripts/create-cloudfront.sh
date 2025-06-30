#!/bin/bash
# Create CloudFront distribution for video delivery

set -e

# Source config
BUCKET_NAME=${BUCKET_NAME:-"trinity-apex-videos"}
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}

echo "Creating CloudFront distribution for ${BUCKET_NAME}"

# Create Origin Access Control (OAC) for S3
OAC_ID=$(aws cloudfront create-origin-access-control \
    --origin-access-control-config '{
        "Name": "trinity-apex-video-oac",
        "Description": "OAC for Trinity Apex video hosting",
        "SigningProtocol": "sigv4",
        "SigningBehavior": "always",
        "OriginAccessControlOriginType": "s3"
    }' \
    --profile ${PROFILE} \
    --query OriginAccessControl.Id --output text 2>/dev/null || \
    aws cloudfront list-origin-access-controls --profile ${PROFILE} \
        --query "OriginAccessControlList.Items[?Name=='trinity-apex-video-oac'].Id | [0]" --output text)

# Create CloudFront distribution config
cat > ../config/cloudfront-config.json << EOF
{
    "CallerReference": "trinity-apex-video-$(date +%s)",
    "Comment": "Trinity Apex video hosting with budget protection",
    "DefaultRootObject": "",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-${BUCKET_NAME}",
                "DomainName": "${BUCKET_NAME}.s3.${REGION}.amazonaws.com",
                "S3OriginConfig": {
                    "OriginAccessIdentity": ""
                },
                "OriginAccessControlId": "${OAC_ID}"
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-${BUCKET_NAME}",
        "ViewerProtocolPolicy": "redirect-to-https",
        "AllowedMethods": {
            "Quantity": 2,
            "Items": ["GET", "HEAD"],
            "CachedMethods": {
                "Quantity": 2,
                "Items": ["GET", "HEAD"]
            }
        },
        "Compress": true,
        "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e58f6",
        "ResponseHeadersPolicyId": "5cc3b908-e619-4b99-88e5-2cf7f45965bd"
    },
    "Enabled": true,
    "PriceClass": "PriceClass_100",
    "ViewerCertificate": {
        "CloudFrontDefaultCertificate": true
    },
    "CustomErrorResponses": {
        "Quantity": 0,
        "Items": []
    }
}
EOF

# Create the distribution
DISTRIBUTION_ID=$(aws cloudfront create-distribution \
    --distribution-config file://../config/cloudfront-config.json \
    --profile ${PROFILE} \
    --query Distribution.Id --output text)

# Get distribution domain name
DISTRIBUTION_DOMAIN=$(aws cloudfront get-distribution \
    --id ${DISTRIBUTION_ID} \
    --profile ${PROFILE} \
    --query Distribution.DomainName --output text)

# Store distribution info
echo ${DISTRIBUTION_ID} > ../config/distribution-id.txt
echo ${DISTRIBUTION_DOMAIN} > ../config/distribution-domain.txt

# Update Lambda environment with distribution ID
if [ -f ../config/lambda-arn.txt ]; then
    LAMBDA_ARN=$(cat ../config/lambda-arn.txt)
    SNS_TOPIC_ARN=$(cat ../config/sns-topic-arn.txt 2>/dev/null || echo "")
    
    aws lambda update-function-configuration \
        --function-name trinity-apex-video-budget-limiter \
        --environment Variables="{DISTRIBUTION_ID='${DISTRIBUTION_ID}',SNS_TOPIC_ARN='${SNS_TOPIC_ARN}',BUDGET_LIMIT='${BUDGET_LIMIT:-50.0}'}" \
        --profile ${PROFILE} \
        --region ${REGION}
fi

echo "✅ CloudFront distribution created successfully"
echo "   - Distribution ID: ${DISTRIBUTION_ID}"
echo "   - Domain: ${DISTRIBUTION_DOMAIN}"
echo "   - Status: Deploying (15-20 minutes)"
echo ""
echo "⏳ CloudFront is deploying globally. This takes 15-20 minutes."