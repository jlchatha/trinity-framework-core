# Manual AWS CloudFront Setup

Due to IAM permission limitations, here's the manual setup process:

## ✅ Completed Automatically
- S3 bucket `trinity-apex-videos` created
- Video `OVERSEER_k3s.mp4` uploaded (22MB)
- CORS configured for trinityapex.ai
- Proper video headers set

## 🔧 Manual Steps Required

### 1. Create CloudFront Distribution

Go to AWS Console → CloudFront → Create Distribution

**Basic Settings:**
- Origin Domain: `trinity-apex-videos.s3.us-east-1.amazonaws.com`
- Origin Path: (leave empty)
- Origin Access: Origin Access Control (recommended)

**Default Cache Behavior:**
- Viewer Protocol Policy: Redirect HTTP to HTTPS
- Allowed HTTP Methods: GET, HEAD
- Cache Policy: Managed-CachingOptimized
- Origin Request Policy: Managed-CORS-S3Origin

**Additional Settings:**
- Price Class: Use Only US, Canada and Europe
- Enable: Yes
- Comment: Trinity Apex Video Hosting

### 2. Create Budget (Recommended)

Go to AWS Console → Billing → Budgets → Create Budget

**Budget Details:**
- Name: Trinity-Apex-Video-Hosting
- Budget Type: Cost Budget
- Amount: $50
- Period: Monthly

**Filters:**
- Service: Amazon CloudFront, Amazon S3

**Alerts:**
- 80% threshold → Email alert
- 100% threshold → Email alert

### 3. Update Website

Once CloudFront deploys (15-20 minutes), get the distribution domain name and update the website:

```html
<div class="video-container">
  <video id="overseer-video" controls preload="metadata" style="width: 100%; height: 100%;">
    <source src="https://YOUR-CLOUDFRONT-DOMAIN.cloudfront.net/OVERSEER_k3s.mp4" type="video/mp4">
    Your browser does not support the video tag.
  </video>
  <!-- Fallback for issues -->
  <div id="video-fallback" style="display: none;">
    <p>Video temporarily unavailable</p>
    <a href="https://github.com/jlchatha/trinity-apex-website/raw/main/video/OVERSEER_k3s.mp4" 
       download class="btn btn-primary">
      <i class="fa fa-download"></i> Download Video (22MB)
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

### 4. Test Firefox Compatibility

1. Open Firefox
2. Navigate to https://trinityapex.ai
3. Scroll to video section
4. Confirm video plays without "unsupported format" error

## Quick Alternative: Direct S3 Access

If you want immediate Firefox compatibility, you can serve directly from S3:

```html
<source src="https://trinity-apex-videos.s3.us-east-1.amazonaws.com/OVERSEER_k3s.mp4" type="video/mp4">
```

This will work but without CDN benefits and may have higher costs for many views.

## Cost Monitoring

Without automated budget actions, monitor costs manually:
- AWS Console → Billing → Cost Explorer
- Set up billing alerts for $40 (80% of $50)
- Check usage weekly during initial traffic

## Support

For questions about this setup:
- Email: admin@trinityapex.ai
- AWS Documentation: CloudFront Getting Started