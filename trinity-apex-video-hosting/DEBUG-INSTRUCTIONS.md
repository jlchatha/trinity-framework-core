# Firefox Debug Instructions

## Step 1: Access Debug Page

The debug server is running. Access the test page:

**Local URL**: http://localhost:8080/firefox-debug.html  
**External URL**: http://YOUR_SERVER_IP:8080/firefox-debug.html

## Step 2: Open in Firefox

1. Open Firefox browser
2. Navigate to the debug URL above
3. Open Firefox Developer Tools (F12)
4. Go to Console tab to see any JavaScript errors

## Step 3: Observe the Test Results

The page will test 3 video sources:

### Test 1: CloudFront URL
- **Source**: https://d29tpqz2wgn380.cloudfront.net/OVERSEER_k3s.mp4
- **Expected**: Should work with proper headers

### Test 2: CloudFront with Codecs
- **Source**: Same URL but with explicit codec specification
- **Purpose**: Test if Firefox needs codec info

### Test 3: GitHub Fallback
- **Source**: GitHub raw URL
- **Purpose**: Compare with working/non-working source

## Step 4: Check What to Look For

### Success Indicators:
- ✅ "Metadata loaded" message
- ✅ Video duration shows (e.g., "Duration: 45s")
- ✅ "Can start playing" message
- ✅ Video controls appear and work

### Error Indicators:
- ❌ Error messages in the log
- ❌ Specific error codes:
  - **Code 1**: MEDIA_ERR_ABORTED - playback aborted
  - **Code 2**: MEDIA_ERR_NETWORK - network error
  - **Code 3**: MEDIA_ERR_DECODE - decoding error
  - **Code 4**: MEDIA_ERR_SRC_NOT_SUPPORTED - format not supported

### Browser Support Section:
- Check if MP4 support shows "probably" or "maybe"
- Look for codec support details
- Note any missing features

## Step 5: Firefox Console Errors

Watch for console errors like:
- CORS policy errors
- Network request failures
- Media format errors
- Security policy violations

## Step 6: Report Results

Tell me what you see:

1. **Which tests succeed/fail?**
2. **What error codes appear?**
3. **Any console error messages?**
4. **Browser support info results?**

## Alternative Debug Commands

If the server doesn't work, try these direct tests:

### Test CloudFront Directly:
```bash
curl -I "https://d29tpqz2wgn380.cloudfront.net/OVERSEER_k3s.mp4"
```

### Test in Firefox via About:Config:
1. Type `about:config` in Firefox
2. Search for `media.`
3. Look for any disabled codecs or strict policies

## Quick Fix Options Ready:

Based on results, we can immediately try:
- **WebM conversion** if codec issue
- **YouTube embed** if format incompatible  
- **Direct S3 URL** if CloudFront issue
- **JavaScript blob loading** if CORS issue

Ready to debug! Let me know what the Firefox test page shows.