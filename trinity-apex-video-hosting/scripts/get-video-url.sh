#!/bin/bash
# Get the CloudFront URL for your video

set -e

# Source config
PROFILE=${PROFILE:-"trinity-beta2"}
VIDEO_NAME="OVERSEER_k3s.mp4"

# Check if distribution domain exists
if [ ! -f ../config/distribution-domain.txt ]; then
    echo "Error: CloudFront distribution not found"
    echo "Run ./create-cloudfront.sh first"
    exit 1
fi

DISTRIBUTION_DOMAIN=$(cat ../config/distribution-domain.txt)
DISTRIBUTION_ID=$(cat ../config/distribution-id.txt)

# Get distribution status
STATUS=$(aws cloudfront get-distribution \
    --id ${DISTRIBUTION_ID} \
    --profile ${PROFILE} \
    --query Distribution.Status --output text)

echo "======================================="
echo "Trinity Apex Video Hosting Information"
echo "======================================="
echo ""
echo "CloudFront Status: ${STATUS}"
echo "Distribution ID: ${DISTRIBUTION_ID}"
echo ""
echo "Video URL:"
echo "https://${DISTRIBUTION_DOMAIN}/${VIDEO_NAME}"
echo ""
echo "HTML Code for Website:"
echo "----------------------"
cat << HTML
<div class="video-container">
  <video id="overseer-video" controls preload="metadata" style="width: 100%; height: 100%;">
    <source src="https://${DISTRIBUTION_DOMAIN}/${VIDEO_NAME}" type="video/mp4">
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
HTML

if [ "${STATUS}" != "Deployed" ]; then
    echo ""
    echo "⏳ Note: CloudFront is still deploying. Wait 15-20 minutes for global availability."
fi