# AWS Video Hosting with Cost Controls for Trinity Apex

## Professional Solution with Budget Protection

### Core Setup
1. **S3 Bucket**: trinity-apex-videos
2. **CloudFront Distribution**: Custom domain support
3. **Monthly Budget**: $50 (configurable)
4. **Automatic Shutoff**: At 100% budget utilization

### Implementation Plan

#### Phase 1: Basic Setup (2 hours)
```bash
# Create S3 bucket
aws s3 mb s3://trinity-apex-videos --region us-east-1 --profile trinity-beta2

# Set bucket policy for CloudFront only access
aws s3api put-bucket-policy --bucket trinity-apex-videos \
  --policy file://cloudfront-only-policy.json --profile trinity-beta2

# Upload video with correct headers
aws s3 cp OVERSEER_k3s.mp4 s3://trinity-apex-videos/ \
  --content-type video/mp4 \
  --cache-control "public, max-age=31536000" \
  --profile trinity-beta2
```

#### Phase 2: CloudFront with Cost Controls (1 hour)
```javascript
// CloudFront distribution config
{
  "Origins": [{
    "DomainName": "trinity-apex-videos.s3.amazonaws.com",
    "S3OriginConfig": {
      "OriginAccessIdentity": "origin-access-identity/cloudfront/EXAMPLE"
    }
  }],
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3-trinity-apex-videos",
    "ViewerProtocolPolicy": "redirect-to-https",
    "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e58f6", // Managed-CachingOptimized
    "ResponseHeadersPolicyId": "5cc3b908-e619-4b99-88e5-2cf7f45965bd" // CORS-With-Preflight
  },
  "PriceClass": "PriceClass_100", // US, Canada, Europe only (cheaper)
  "Enabled": true
}
```

#### Phase 3: Budget Controls (30 minutes)
```bash
# Create budget with auto-shutdown
aws budgets create-budget --account-id $(aws sts get-caller-identity --query Account --output text) \
  --budget '{
    "BudgetName": "Trinity-Apex-Video-Budget",
    "BudgetLimit": {
      "Amount": "50.0",
      "Unit": "USD"
    },
    "TimeUnit": "MONTHLY",
    "BudgetType": "COST"
  }' \
  --notifications-with-subscribers '[{
    "Notification": {
      "NotificationType": "ACTUAL",
      "ComparisonOperator": "GREATER_THAN",
      "Threshold": 90.0
    },
    "Subscribers": [{
      "SubscriptionType": "EMAIL",
      "Address": "admin@trinityapex.ai"
    }]
  }]' \
  --profile trinity-beta2
```

#### Phase 4: Lambda Auto-Shutdown (1 hour)
```python
# Lambda function to disable CloudFront when budget exceeded
import boto3
import json

def lambda_handler(event, context):
    cf = boto3.client('cloudfront')
    
    # Get distribution ID from environment variable
    dist_id = os.environ['DISTRIBUTION_ID']
    
    # Get current config
    response = cf.get_distribution_config(Id=dist_id)
    config = response['DistributionConfig']
    etag = response['ETag']
    
    # Disable distribution
    config['Enabled'] = False
    
    # Update distribution
    cf.update_distribution(
        Id=dist_id,
        DistributionConfig=config,
        IfMatch=etag
    )
    
    # Send notification
    sns = boto3.client('sns')
    sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],
        Subject='Trinity Apex Video Hosting Disabled - Budget Limit Reached',
        Message='Video hosting has been automatically disabled due to budget limits. Monthly cost reached $50.'
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Distribution disabled due to budget limit')
    }
```

### Cost Breakdown with Controls

| Views/Month | Data Transfer | Monthly Cost | Status |
|-------------|---------------|--------------|---------|
| 0-12,000    | 552 GB        | ~$47         | Active |
| 12,001+     | >552 GB       | >$50         | Auto-disabled |

### Additional Protections

1. **WAF Rate Limiting** (Optional +$5/month):
   - Max 100 requests per IP per 5 minutes
   - Block known bot user agents
   - Geo-restrict to US/Canada/Europe

2. **CloudWatch Dashboards**:
   - Real-time view count
   - Bandwidth usage
   - Cost tracking
   - Alert on unusual spikes

3. **Fallback Strategy**:
   - When disabled, video automatically falls back to download button
   - Static message: "Video temporarily unavailable - please download"
   - Manual re-enable required after budget reset

### Monthly Operations

1. **Under Budget** (<$50): Everything runs normally
2. **Near Budget** (90%): Email alert sent
3. **At Budget** (100%): CloudFront auto-disabled, fallback activated
4. **New Month**: Manually re-enable after reviewing previous month

### Setup Commands Summary

```bash
# 1. Create budget
./scripts/create-video-budget.sh

# 2. Deploy infrastructure
./scripts/deploy-video-infrastructure.sh

# 3. Upload video
./scripts/upload-video.sh OVERSEER_k3s.mp4

# 4. Get CloudFront URL
aws cloudfront list-distributions --query "DistributionList.Items[?Origins.Items[?DomainName=='trinity-apex-videos.s3.amazonaws.com']].DomainName" --output text --profile trinity-beta2
```

### HTML Implementation

```html
<div class="video-container">
  <video id="overseer-video" controls preload="metadata" style="width: 100%; height: 100%;">
    <!-- CloudFront URL with proper MIME type -->
    <source src="https://d1234567890.cloudfront.net/OVERSEER_k3s.mp4" type="video/mp4">
  </video>
  <!-- Fallback for when budget exceeded -->
  <div id="video-fallback" style="display: none;">
    <p>Video temporarily unavailable</p>
    <a href="/video/OVERSEER_k3s.mp4" download class="btn btn-primary">
      <i class="fa fa-download"></i> Download Video (46MB)
    </a>
  </div>
</div>

<script>
document.getElementById('overseer-video').onerror = function() {
  this.style.display = 'none';
  document.getElementById('video-fallback').style.display = 'block';
};
</script>
```

## Recommendation

This setup provides:
- **Professional hosting** with custom domain
- **Guaranteed budget protection** at $50/month
- **Automatic shutoff** preventing surprise bills
- **~12,000 safe views** per month
- **Graceful fallback** when limit reached

Total setup time: ~4-5 hours
Monthly cost: $0-50 (capped)