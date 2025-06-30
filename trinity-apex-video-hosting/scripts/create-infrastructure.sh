#!/bin/bash
# Create S3 bucket and configure for video hosting

set -e

# Source config from parent script or use defaults
BUCKET_NAME=${BUCKET_NAME:-"trinity-apex-videos"}
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}

echo "Creating S3 bucket: ${BUCKET_NAME}"

# Create bucket
aws s3 mb s3://${BUCKET_NAME} --region ${REGION} --profile ${PROFILE} 2>/dev/null || {
    echo "Bucket already exists or error occurred"
}

# Enable versioning for safety
aws s3api put-bucket-versioning \
    --bucket ${BUCKET_NAME} \
    --versioning-configuration Status=Enabled \
    --profile ${PROFILE}

# Create bucket policy for CloudFront
cat > ../policies/s3-bucket-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipalReadOnly",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${BUCKET_NAME}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::*:distribution/*"
                }
            }
        }
    ]
}
EOF

# Apply bucket policy
aws s3api put-bucket-policy \
    --bucket ${BUCKET_NAME} \
    --policy file://../policies/s3-bucket-policy.json \
    --profile ${PROFILE}

# Configure CORS for video playback
cat > ../policies/cors-config.json << EOF
{
    "CORSRules": [
        {
            "AllowedHeaders": ["*"],
            "AllowedMethods": ["GET", "HEAD"],
            "AllowedOrigins": ["https://trinityapex.ai", "https://www.trinityapex.ai"],
            "ExposeHeaders": ["Content-Length", "Content-Type"],
            "MaxAgeSeconds": 3600
        }
    ]
}
EOF

aws s3api put-bucket-cors \
    --bucket ${BUCKET_NAME} \
    --cors-configuration file://../policies/cors-config.json \
    --profile ${PROFILE}

# Create lifecycle policy to save costs
cat > ../policies/lifecycle-policy.json << EOF
{
    "Rules": [
        {
            "ID": "TransitionOldVideos",
            "Status": "Enabled",
            "Filter": {
                "Prefix": ""
            },
            "Transitions": [
                {
                    "Days": 30,
                    "StorageClass": "STANDARD_IA"
                },
                {
                    "Days": 90,
                    "StorageClass": "GLACIER_IR"
                }
            ]
        }
    ]
}
EOF

aws s3api put-bucket-lifecycle-configuration \
    --bucket ${BUCKET_NAME} \
    --lifecycle-configuration file://../policies/lifecycle-policy.json \
    --profile ${PROFILE}

echo "✅ S3 bucket configured successfully"
echo "   - Versioning: Enabled"
echo "   - CORS: Configured for trinityapex.ai"
echo "   - Lifecycle: Auto-transition to cheaper storage"