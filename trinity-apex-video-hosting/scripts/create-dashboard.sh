#!/bin/bash
# Create CloudWatch dashboard for monitoring video costs and usage

set -e

# Source config
PROFILE=${PROFILE:-"trinity-beta2"}
REGION=${REGION:-"us-east-1"}
BUCKET_NAME=${BUCKET_NAME:-"trinity-apex-videos"}
DISTRIBUTION_ID=$(cat ../config/distribution-id.txt 2>/dev/null || echo "PENDING")

echo "Creating CloudWatch dashboard..."

# Create dashboard config
cat > ../config/dashboard-config.json << EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/CloudFront", "BytesDownloaded", { "stat": "Sum", "period": 300 } ],
                    [ ".", "Requests", { "stat": "Sum", "period": 300 } ]
                ],
                "period": 300,
                "stat": "Average",
                "region": "${REGION}",
                "title": "CloudFront Traffic",
                "annotations": {
                    "horizontal": [
                        {
                            "label": "Budget Limit (~552GB)",
                            "value": 552000000000
                        }
                    ]
                }
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/S3", "BucketSizeBytes", "BucketName", "${BUCKET_NAME}", "StorageType", "StandardStorage", { "period": 86400 } ]
                ],
                "period": 86400,
                "stat": "Average",
                "region": "${REGION}",
                "title": "S3 Storage Size"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 24,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/CloudFront", "BytesDownloaded", { "stat": "Sum", "period": 3600 } ]
                ],
                "period": 3600,
                "stat": "Sum",
                "region": "${REGION}",
                "title": "Hourly Data Transfer",
                "yAxis": {
                    "left": {
                        "label": "Bytes",
                        "showUnits": true
                    }
                }
            }
        },
        {
            "type": "text",
            "x": 0,
            "y": 12,
            "width": 24,
            "height": 3,
            "properties": {
                "markdown": "# Trinity Apex Video Hosting Dashboard\\n\\n**Budget Protection Active**\\n- Monthly Limit: \$50\\n- Safe Views: ~12,000 (46MB video)\\n- Auto-disable at 100% budget\\n\\n**CloudFront Distribution**: ${DISTRIBUTION_ID}\\n\\n**Cost Calculation**: Data Transfer × \$0.085/GB"
            }
        }
    ]
}
EOF

# Create the dashboard
aws cloudwatch put-dashboard \
    --dashboard-name "Trinity-Apex-Video-Hosting" \
    --dashboard-body file://../config/dashboard-config.json \
    --profile ${PROFILE} \
    --region ${REGION}

# Create budget utilization metric alarm
if [ -f ../config/sns-topic-arn.txt ]; then
    SNS_TOPIC_ARN=$(cat ../config/sns-topic-arn.txt)
    
    # Create data transfer alarm (80% of monthly safe limit)
    aws cloudwatch put-metric-alarm \
        --alarm-name "Trinity-Apex-Video-DataTransfer-Warning" \
        --alarm-description "Warns when approaching 80% of safe monthly data transfer" \
        --metric-name BytesDownloaded \
        --namespace AWS/CloudFront \
        --statistic Sum \
        --period 86400 \
        --threshold 441600000000 \
        --comparison-operator GreaterThanThreshold \
        --datapoints-to-alarm 1 \
        --evaluation-periods 1 \
        --alarm-actions ${SNS_TOPIC_ARN} \
        --profile ${PROFILE} \
        --region ${REGION}
fi

echo "✅ CloudWatch dashboard created successfully"
echo "   - Name: Trinity-Apex-Video-Hosting"
echo "   - URL: https://console.aws.amazon.com/cloudwatch/home?region=${REGION}#dashboards:name=Trinity-Apex-Video-Hosting"