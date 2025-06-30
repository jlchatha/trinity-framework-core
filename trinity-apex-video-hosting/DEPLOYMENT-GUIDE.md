# Trinity Apex Video Hosting - Deployment Guide

## Prerequisites

1. AWS CLI v2 installed and configured
2. AWS profile `trinity-beta2` with appropriate permissions
3. The OVERSEER_k3s.mp4 video file

## Step-by-Step Deployment

### 1. Clone and Navigate
```bash
cd /home/alreadyinuse/git/trinity-historian-workspace/trinity-apex-video-hosting
```

### 2. Run Complete Deployment
```bash
./scripts/deploy-all.sh
```

This will:
- Create S3 bucket with proper policies
- Set up $50/month budget with alerts
- Deploy Lambda function for auto-shutoff
- Create CloudFront distribution
- Upload video (if found)
- Create monitoring dashboard

### 3. Wait for CloudFront (15-20 minutes)
CloudFront needs time to deploy globally. Check status:
```bash
./scripts/get-video-url.sh
```

### 4. Update Trinity Apex Website

Replace the current video code in `_includes/why-trinity.html`:

```html
<div class="video-container">
  <video id="overseer-video" controls preload="metadata" style="width: 100%; height: 100%;">
    <source src="https://YOUR-CLOUDFRONT-DOMAIN/OVERSEER_k3s.mp4" type="video/mp4">
    Your browser does not support the video tag.
  </video>
  <!-- Fallback for budget limit reached -->
  <div id="video-fallback" style="display: none;">
    <p>Video temporarily unavailable</p>
    <a href="https://github.com/jlchatha/trinity-apex-website/raw/main/video/OVERSEER_k3s.mp4" 
       download class="btn btn-primary">
      <i class="fa fa-download"></i> Download Video (46MB)
    </a>
  </div>
</div>

<script>
// Show fallback if video fails to load
document.getElementById('overseer-video').onerror = function() {
  this.style.display = 'none';
  document.getElementById('video-fallback').style.display = 'block';
};
</script>
```

### 5. Test Firefox Compatibility
1. Open Firefox
2. Navigate to https://trinityapex.ai
3. Scroll to video section
4. Confirm video plays properly

## Monitoring

### Check Budget Status
```bash
./scripts/check-budget-status.sh
```

### View CloudWatch Dashboard
https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards:name=Trinity-Apex-Video-Hosting

### Emergency Disable
If needed, manually disable distribution:
```bash
./scripts/emergency-disable.sh
```

## Cost Breakdown

| Views/Month | Data Transfer | Cost    |
|-------------|---------------|---------|
| 1,000       | 46 GB         | $3.91   |
| 5,000       | 230 GB        | $19.55  |
| 10,000      | 460 GB        | $39.10  |
| 12,000      | 552 GB        | $46.92  |
| 12,001+     | Auto-disabled | $50 max |

## Troubleshooting

### Video Not Playing
1. Check CloudFront status is "Deployed"
2. Verify S3 bucket has the video
3. Check browser console for errors
4. Try clearing browser cache

### Budget Alerts Not Working
1. Confirm SNS email subscription
2. Check spam folder
3. Verify budget exists in AWS Console

### Lambda Not Triggering
1. Check Lambda logs in CloudWatch
2. Verify IAM permissions
3. Ensure environment variables set

## Support

- Email: admin@trinityapex.ai
- Dashboard: AWS CloudWatch
- Logs: CloudWatch Logs