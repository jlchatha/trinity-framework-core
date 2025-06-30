# Trinity Apex Video Hosting - AWS Professional Solution

Complete AWS S3 + CloudFront video hosting solution with automatic budget protection at $50/month.

## Features
- ✅ Professional video hosting (no YouTube branding)
- ✅ Firefox compatibility with proper MIME types
- ✅ Automatic budget cap at $50/month (~12,000 views)
- ✅ Email alerts at 80% budget usage
- ✅ Auto-disable at 100% budget with graceful fallback
- ✅ CloudWatch monitoring dashboard
- ✅ Full infrastructure as code

## Quick Start

1. **Run the complete setup**:
   ```bash
   cd trinity-apex-video-hosting
   ./scripts/deploy-all.sh
   ```

2. **Upload your video**:
   ```bash
   ./scripts/upload-video.sh /path/to/OVERSEER_k3s.mp4
   ```

3. **Get your CloudFront URL**:
   ```bash
   ./scripts/get-video-url.sh
   ```

4. **Update website HTML**:
   ```html
   <video controls>
     <source src="YOUR_CLOUDFRONT_URL" type="video/mp4">
   </video>
   ```

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Website   │────▶│  CloudFront  │────▶│  S3 Bucket  │
└─────────────┘     └──────────────┘     └─────────────┘
                            │
                            ▼
                    ┌──────────────┐     ┌─────────────┐
                    │ AWS Budgets  │────▶│   Lambda    │
                    └──────────────┘     └─────────────┘
                                                │
                                                ▼
                                        ┌──────────────┐
                                        │  Auto Stop   │
                                        └──────────────┘
```

## Cost Control

- **Monthly Budget**: $50 USD
- **Alert Threshold**: 80% ($40)
- **Auto-Disable**: 100% ($50)
- **Safe Views**: ~12,000/month (46MB video)

## Files Included

- `scripts/deploy-all.sh` - Complete deployment script
- `scripts/create-infrastructure.sh` - S3 + CloudFront setup
- `scripts/setup-budget.sh` - Budget with auto-actions
- `scripts/upload-video.sh` - Upload with correct headers
- `lambda/budget-limiter.py` - Auto-disable function
- `config/cloudfront-config.json` - Distribution settings
- `policies/s3-bucket-policy.json` - Security policies

## Support

Contact: admin@trinityapex.ai