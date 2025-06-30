# Quick AWS Console Steps to Complete Setup

## Option 1: Add IAM Permissions (Recommended)

### Step 1: Add IAM Policy
1. **AWS Console → IAM → Policies → Create Policy**
2. **JSON tab → Paste this policy:**

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudfront:*",
                "budgets:*",
                "sns:*",
                "lambda:*",
                "iam:CreateRole",
                "iam:GetRole",
                "iam:PutRolePolicy",
                "iam:PassRole",
                "cloudwatch:*",
                "logs:*"
            ],
            "Resource": "*"
        }
    ]
}
```

3. **Name:** `TrinityApexVideoHosting`
4. **Create Policy**

### Step 2: Attach to User
1. **IAM → Users → trinity-beta2-admin**
2. **Add permissions → Attach existing policies**
3. **Select:** `TrinityApexVideoHosting`
4. **Add permissions**

### Step 3: Run Automation
```bash
cd trinity-apex-video-hosting
./scripts/deploy-all.sh
```

---

## Option 2: Manual Console Setup (No IAM Changes)

### CloudFront Distribution

1. **AWS Console → CloudFront → Create Distribution**

**Origin Settings:**
- **Origin Domain:** `trinity-apex-videos.s3.us-east-2.amazonaws.com`
- **Name:** `S3-trinity-apex-videos`
- **Origin Access:** Origin Access Control (create new)
  - **Name:** `trinity-apex-video-oac`
  - **Origin Type:** S3
  - **Signing:** Yes

**Cache Behavior:**
- **Path Pattern:** Default (*)
- **Viewer Protocol Policy:** Redirect HTTP to HTTPS
- **Allowed HTTP Methods:** GET, HEAD
- **Cache Policy:** Managed-CachingOptimized
- **Origin Request Policy:** Managed-CORS-S3Origin

**Distribution Settings:**
- **Price Class:** Use Only US, Canada and Europe
- **Description:** Trinity Apex video hosting
- **Enable:** Yes

**Create Distribution** (takes 15-20 minutes)

### Budget Setup

1. **AWS Console → Billing → Budgets → Create Budget**

**Budget Setup:**
- **Budget Type:** Cost budget
- **Name:** Trinity-Apex-Video-Hosting
- **Period:** Monthly
- **Amount:** $50

**Scope:**
- **Service:** Amazon CloudFront, Amazon Simple Storage Service

**Alerts:**
- **Alert 1:** 80% of budget, Email: admin@trinityapex.ai
- **Alert 2:** 100% of budget, Email: admin@trinityapex.ai

**Create Budget**

### Get CloudFront URL

1. **CloudFront Console → Distributions**
2. **Find your distribution**
3. **Copy Domain Name** (e.g., `d1234567890.cloudfront.net`)

### Update Website

Replace video source in Trinity Apex website:

```html
<source src="https://YOUR-CLOUDFRONT-DOMAIN.cloudfront.net/OVERSEER_k3s.mp4" type="video/mp4">
```

---

## Time Estimates

| Method | Setup Time | Features |
|--------|------------|----------|
| **IAM + Automation** | 5 min + 10 min | Full automation, monitoring, auto-disable |
| **Manual Console** | 30 min | Basic hosting, manual monitoring |

## Current Status

✅ **S3 bucket created and configured**
✅ **Video uploaded (22MB OVERSEER_k3s.mp4)**
✅ **All automation scripts ready**

⏳ **Waiting for:** CloudFront distribution
⏳ **Waiting for:** Budget protection

Choose your preferred approach above!