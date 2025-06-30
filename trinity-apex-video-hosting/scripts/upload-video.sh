#!/bin/bash
# Upload video to S3 with proper headers for video streaming

set -e

# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <video-file-path>"
    echo "Example: $0 /path/to/OVERSEER_k3s.mp4"
    exit 1
fi

VIDEO_PATH="$1"
BUCKET_NAME=${BUCKET_NAME:-"trinity-apex-videos"}
PROFILE=${PROFILE:-"trinity-beta2"}

# Check if file exists
if [ ! -f "${VIDEO_PATH}" ]; then
    echo "Error: Video file not found: ${VIDEO_PATH}"
    exit 1
fi

# Get file info
VIDEO_NAME=$(basename "${VIDEO_PATH}")
VIDEO_SIZE=$(ls -lh "${VIDEO_PATH}" | awk '{print $5}')

echo "Uploading video to S3..."
echo "  File: ${VIDEO_NAME}"
echo "  Size: ${VIDEO_SIZE}"
echo "  Bucket: ${BUCKET_NAME}"

# Upload with proper headers
aws s3 cp "${VIDEO_PATH}" "s3://${BUCKET_NAME}/${VIDEO_NAME}" \
    --content-type "video/mp4" \
    --cache-control "public, max-age=31536000, immutable" \
    --content-disposition "inline; filename=\"${VIDEO_NAME}\"" \
    --metadata "uploaded-by=trinity-apex-video-hosting,upload-date=$(date -u +%Y-%m-%d)" \
    --profile ${PROFILE} \
    --no-progress

# Get CloudFront URL if distribution exists
if [ -f ../config/distribution-domain.txt ]; then
    DISTRIBUTION_DOMAIN=$(cat ../config/distribution-domain.txt)
    VIDEO_URL="https://${DISTRIBUTION_DOMAIN}/${VIDEO_NAME}"
    
    echo ""
    echo "✅ Video uploaded successfully!"
    echo ""
    echo "CloudFront URL:"
    echo "${VIDEO_URL}"
    echo ""
    echo "Add to your website:"
    echo "<video controls>"
    echo "  <source src=\"${VIDEO_URL}\" type=\"video/mp4\">"
    echo "</video>"
    
    # Save URL
    echo ${VIDEO_URL} > ../config/video-url.txt
else
    echo ""
    echo "✅ Video uploaded to S3"
    echo "   Run ./get-video-url.sh after CloudFront is created"
fi