#!/bin/bash

echo "Testing direct Formspree submission..."
echo "======================================="

# Submit a test form directly to Formspree
response=$(curl -s -X POST https://formspree.io/f/xdkzyrqo \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: application/json" \
  -d "name=Direct Test&email=test@example.com&plan=byoc&project=Testing monitor")

echo "Response from Formspree:"
echo "$response" | jq '.' 2>/dev/null || echo "$response"

echo ""
echo "If successful, check Gmail in a minute for the notification email."