# Immediate Firefox Fix - Alternative Approach

Since CloudFront setup requires manual configuration, here's an immediate solution:

## Option 1: Use Presigned S3 URL (1 hour validity)

Generate a temporary signed URL for immediate testing:

```bash
aws s3 presign s3://trinity-apex-videos/OVERSEER_k3s.mp4 --expires-in 3600 --profile trinity-beta2
```

## Option 2: YouTube Unlisted (Recommended for Immediate Fix)

1. Upload OVERSEER_k3s.mp4 to YouTube as unlisted
2. Get the video ID from the URL
3. Update Trinity Apex website:

```html
<div class="video-container">
  <iframe width="100%" height="100%" 
          src="https://www.youtube.com/embed/VIDEO_ID?rel=0&modestbranding=1&showinfo=0" 
          frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
  </iframe>
</div>
```

## Option 3: Convert to WebM Format

Firefox prefers WebM format. Convert the video:

```bash
ffmpeg -i OVERSEER_k3s.mp4 -c:v libvpx-vp9 -crf 30 -b:v 0 OVERSEER_k3s.webm
```

Then add both formats:

```html
<video controls>
  <source src="/video/OVERSEER_k3s.webm" type="video/webm">
  <source src="/video/OVERSEER_k3s.mp4" type="video/mp4">
</video>
```

## Current Status

✅ S3 Infrastructure Ready
- Bucket: trinity-apex-videos  
- Video uploaded with proper headers
- CORS configured for trinityapex.ai

⏳ Manual CloudFront Setup Required
- AWS Console access needed for CloudFront distribution
- Budget setup needs AWS Console
- 15-20 minutes deployment time

## Recommendation

For immediate Firefox fix: **YouTube unlisted** (5 minutes)
For professional solution: **Manual CloudFront setup** (30 minutes)