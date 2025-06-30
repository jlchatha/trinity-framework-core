# Firefox Alternative Solutions

Since Firefox is still having issues, here are immediate alternative approaches:

## Option 1: YouTube Unlisted (Fastest Fix)

Upload OVERSEER_k3s.mp4 to YouTube as unlisted video:

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

**Pros:** Universal compatibility, works immediately  
**Cons:** YouTube branding, less professional appearance  

## Option 2: Convert to WebM Format

Firefox strongly prefers WebM format. Convert the video:

```bash
# Install ffmpeg if not available
sudo yum install ffmpeg

# Convert to WebM
ffmpeg -i OVERSEER_k3s.mp4 -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus OVERSEER_k3s.webm
```

Then upload WebM to S3 and use both formats:

```html
<video controls>
  <source src="https://d29tpqz2wgn380.cloudfront.net/OVERSEER_k3s.webm" type="video/webm">
  <source src="https://d29tpqz2wgn380.cloudfront.net/OVERSEER_k3s.mp4" type="video/mp4">
</video>
```

## Option 3: Use Blob URL Approach

Download and serve via JavaScript to bypass Firefox's strict MIME checking:

```javascript
async function loadVideo() {
  try {
    const response = await fetch('https://d29tpqz2wgn380.cloudfront.net/OVERSEER_k3s.mp4');
    const blob = await response.blob();
    const videoUrl = URL.createObjectURL(blob);
    
    const video = document.getElementById('overseer-video');
    video.src = videoUrl;
  } catch (error) {
    console.error('Video loading failed:', error);
    // Show fallback
  }
}
```

## Option 4: Simple S3 Public Access

Make the S3 object public and bypass CloudFront for now:

```bash
aws s3api put-object-acl --bucket trinity-apex-videos --key OVERSEER_k3s.mp4 --acl public-read --profile trinity-beta2
```

Then use direct S3 URL:
```html
<source src="https://trinity-apex-videos.s3.us-east-2.amazonaws.com/OVERSEER_k3s.mp4" type="video/mp4">
```

## Option 5: Debug First (Recommended)

Test the debug page to understand the exact Firefox error:

1. Save `firefox-debug.html` to a web server
2. Open in Firefox
3. Check console for specific error messages
4. Test which source works (CloudFront vs GitHub vs S3 direct)

## Immediate Recommendation

For quickest resolution:
1. **Test debug page** to identify exact error
2. **YouTube unlisted** for immediate professional fix
3. **WebM conversion** for long-term solution

Which approach would you like to try first?