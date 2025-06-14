# Trinity Apex Beta Management Proposal

## Overview
This document outlines the proposed system for managing the Trinity Apex beta program, including application processing, status tracking, and tester communication.

## Trinity Apex Beta Provisioning Flow

### Process Flow

```
1. HISTORIAN handles beta@trinity-apex.com (via Gmail API)
   ↓
2. HISTORIAN + Human review applicants together
   ↓
3. Human selects who gets approved
   ↓
4. Human → OVERSEER: "provision workspace for [email]"
   ↓
5. OVERSEER provisions the workspace
   ↓
6. OVERSEER → Human: "provisioning complete"
   ↓
7. Human → HISTORIAN: "[email] is ready"
   ↓
8. HISTORIAN sends welcome email and handles all further communication
```

### Agent Responsibilities

#### HISTORIAN
- **Monitors** beta@trinity-apex.com via Gmail API
- **Tracks** all applications in spreadsheet
- **Presents** candidates for review
- **Sends** all beta communications (welcome, updates, etc.)
- **Maintains** beta documentation and guides
- **Handles** ongoing tester support

#### OVERSEER
- **Receives** provisioning requests from Human
- **Creates** K8s workspaces
- **Reports** completion
- **Returns** to system monitoring

#### Human Operator
- **Reviews** applications with HISTORIAN
- **Decides** who to approve
- **Tells** OVERSEER to provision
- **Notifies** HISTORIAN when ready

### Example Interaction

#### Step 1-2: HISTORIAN presents applications
```
HISTORIAN: "We have 3 new beta applications today:
- sarah@designstudio.com (design agency, wants AI for proposals)
- john@startup.io (SaaS founder, needs customer support bot)
- test@tempmail.com (no clear use case provided)"
```

#### Step 3-4: Human approves and requests
```
Human → OVERSEER: "provision workspace for sarah@designstudio.com"
Human → OVERSEER: "provision workspace for john@startup.io"
```

#### Step 5-6: OVERSEER provisions and reports
```
OVERSEER: "Provisioning complete:
- beta-tester-004: sarah@designstudio.com (password: Xk9m2Tr1n)
- beta-tester-005: john@startup.io (password: Qw3rt9Yz2)"
```

#### Step 7-8: Human notifies HISTORIAN
```
Human → HISTORIAN: "sarah@designstudio.com and john@startup.io are ready"

HISTORIAN: "Acknowledged. Sending welcome emails and updating tracking."
```

### Benefits of This Flow

1. **Clear separation of concerns** - Each agent has specific responsibilities
2. **Human control** - All approval decisions made by human
3. **API efficiency** - HISTORIAN handles all external communications
4. **OVERSEER focus** - Stays focused on infrastructure, not email
5. **Simple handoffs** - Clear communication points between participants

## Status Page Implementation

### Key Features

#### 1. Application Status Lookup
- Secure email-based lookup system
- Shows current status in the beta process
- Maintains privacy by requiring email verification

#### 2. Beta Program Status
- Current beta phase information
- Recent updates and changes
- Upcoming features and improvements

### Implementation Options

#### Option 1: Static Status Page with Email Verification
```
1. User enters email on status page
   ↓
2. System sends verification code to that email (via HISTORIAN)
   ↓ 
3. User enters verification code
   ↓
4. If valid, status is displayed for that specific beta tester
```

##### Technical Implementation:
- Static HTML/CSS/JS on GitHub Pages
- Simple API endpoint (AWS Lambda) for email verification
- HISTORIAN handles the actual email sending

#### Option 2: Token-Based Status URLs
```
1. HISTORIAN includes unique status URL in welcome email
   ↓
2. URL contains encrypted token specific to that tester
   ↓
3. Status page decrypts token client-side
   ↓
4. Shows personalized status information
```

##### Technical Implementation:
- Static HTML/CSS/JS on GitHub Pages
- Client-side token validation (no server needed)
- HISTORIAN generates tokens when creating welcome emails

### Status Information Display

#### Individual Status Section
```
Your Status: [Approved]
Beta Access: [Beta 2]
Next Phase Eligibility: [Beta 3]
Estimated Beta 3 Access: [July 2025]
```

#### Program Status Section
```
Current Active Phase: Beta 2
Beta 3 ETA: July 2025
Beta 4 ETA: September 2025
Public Release ETA: Q4 2025
```

### Full Status States

1. **Under Review**
   - "Your application is currently being reviewed by our team"
   - "Expected decision: Within 5 business days"
   - "Current active phase: Beta 2"

2. **Approved - Waiting for Next Phase**
   - "You've been approved for Beta 3 access"
   - "Beta 3 is expected to begin: July 2025"
   - "We'll notify you when your workspace is ready"

3. **Approved - Active**
   - "You're an active Beta 2 tester"
   - "Your workspace was provisioned on: [Date]"
   - "You'll automatically be migrated to Beta 3 in July 2025"

4. **Declined**
   - "We're unable to include you in the current beta phases"
   - "You can reapply for future phases if your use case changes"
   - "Current active phase: Beta 2"

## Google Workspace Implementation

### Required Google Workspace Components

#### Google Sheets (Core Tracking)
- **Beta Tester Tracking Sheet** with columns:
  - Email
  - Applied Date
  - Status (Under Review/Approved/Declined)
  - Beta Phase (Beta 2/Beta 3/etc.)
  - Next Phase
  - Next Phase ETA
  - Status URL Token
  - Last Activity Date

#### Gmail (Communication)
- **Dedicated beta email address**: beta@trinity-apex.com
- **Email templates** for:
  - Application received
  - Status update notifications
  - Welcome emails with status URL
  - Phase transition announcements

#### Google Apps Script (Automation)
- **Token Generation Script**: Creates unique tokens for each approved tester
- **Email Automation Script**: Triggers emails based on status changes
- **Verification Code Script**: Generates and validates email verification codes

### API Implementation

#### 1. Set Up Project in Google Cloud Console
1. Create a new project in Google Cloud Console
2. Enable required APIs:
   - Google Sheets API
   - Gmail API
   - Google Drive API
   - Apps Script API

#### 2. Create Service Account
1. Generate a service account in Google Cloud Console
2. Download service account credentials (JSON key file)
3. Share necessary Google Sheets with the service account email

#### 3. API Authentication
```javascript
const { google } = require('googleapis');
const sheets = google.sheets('v4');

async function authenticateWithServiceAccount() {
  const auth = new google.auth.GoogleAuth({
    keyFile: 'path/to/service-account-key.json',
    scopes: ['https://www.googleapis.com/auth/spreadsheets'],
  });
  
  const authClient = await auth.getClient();
  return authClient;
}

async function readBetaStatus(email) {
  const authClient = await authenticateWithServiceAccount();
  
  // Use sheets API to query data
  const response = await sheets.spreadsheets.values.get({
    auth: authClient,
    spreadsheetId: 'YOUR_SPREADSHEET_ID',
    range: 'Sheet1!A:F',
  });
  
  // Find user by email and return status
  const rows = response.data.values;
  const userRow = rows.find(row => row[0] === email);
  
  if (userRow) {
    return {
      status: userRow[2],
      betaPhase: userRow[3],
      nextPhase: userRow[4],
      nextPhaseETA: userRow[5],
    };
  }
  
  return null;
}
```

## Email Monitoring Options

### Option 1: Scheduled Polling Script

#### Implementation
- **Google Apps Script** with time-based trigger
- Runs every 5-15 minutes
- Checks for new messages
- Updates spreadsheet with new applications

```javascript
function checkBetaInbox() {
  // Get threads newer than last check time
  const lastCheckTime = PropertiesService.getScriptProperties().getProperty('lastCheckTime');
  const query = lastCheckTime ? `after:${lastCheckTime}` : '';
  
  const threads = GmailApp.search(`in:inbox to:beta@trinity-apex.com ${query}`);
  
  if (threads.length > 0) {
    // Process new messages
    for (const thread of threads) {
      const messages = thread.getMessages();
      for (const message of messages) {
        processBetaApplication(message);
      }
    }
    
    // Update last check time
    PropertiesService.getScriptProperties().setProperty(
      'lastCheckTime', 
      new Date().toISOString()
    );
  }
}

function processBetaApplication(message) {
  // Extract application info
  const sender = message.getFrom();
  const subject = message.getSubject();
  const body = message.getPlainBody();
  
  // Add to spreadsheet
  addApplicationToSheet(sender, subject, body);
  
  // Send acknowledgment
  sendAcknowledgment(sender);
}
```

#### Pros and Cons
- **Pros**: Simple, works within Google ecosystem, no external dependencies
- **Cons**: Polling introduces delays, limited to minimum 1 minute intervals

### Option 2: Gmail Push Notifications (Recommended)

#### Implementation
- Set up Pub/Sub topic in Google Cloud
- Create push notification subscription for Gmail inbox
- Create webhook endpoint (AWS Lambda or similar)
- Process messages in real-time when they arrive

```javascript
// In Google Cloud Functions or AWS Lambda
exports.handleGmailPush = async (event, context) => {
  // Verify push notification
  const message = JSON.parse(
    Buffer.from(event.data, 'base64').toString()
  );
  
  // Get email details using Gmail API
  const auth = await getAuthClient();
  const gmail = google.gmail({ version: 'v1', auth });
  
  const email = await gmail.users.messages.get({
    userId: 'me',
    id: message.emailId
  });
  
  // Process the application
  await processApplication(email);
  
  return { status: 'success' };
};
```

#### Pros and Cons
- **Pros**: Real-time processing, reliable, scales well, event-driven
- **Cons**: More complex setup, requires webhook endpoint, additional costs

### Option 3: Non-Interactive Claude Code via Script

#### Implementation
- Scheduled script polls Gmail API for new messages
- Extracts email content to process
- Invokes Claude Code non-interactively with structured prompt
- Claude analyzes application and makes initial assessment
- Updates tracking sheet with application details and Claude's assessment

```javascript
// Scheduled Cloud Function or Lambda
exports.processBetaApplications = async (event) => {
  // Get new emails
  const messages = await getNewBetaEmails();
  
  for (const message of messages) {
    // Extract content
    const from = message.headers.find(h => h.name === 'From').value;
    const subject = message.headers.find(h => h.name === 'Subject').value;
    const body = message.payload.body.data
      ? Buffer.from(message.payload.body.data, 'base64').toString()
      : '';
    
    // Create prompt for Claude
    const prompt = `
      As HISTORIAN, analyze this beta application email:
      
      From: ${from}
      Subject: ${subject}
      Body:
      ${body}
      
      Extract the following information:
      1. Applicant name
      2. Company name
      3. Use case summary
      4. Technical experience level
      5. Initial assessment (score 1-5)
      6. Suggested beta phase (Beta 2, Beta 3)
      
      Format your response as JSON.
    `;
    
    // Call Claude API
    const claudeResponse = await callClaudeAPI(prompt);
    
    // Parse response and update sheet
    const assessment = JSON.parse(claudeResponse);
    await updateApplicationSheet(assessment);
    
    // Send acknowledgment email
    await sendAcknowledgmentEmail(from);
  }
};
```

#### Pros and Cons
- **Pros**: Demonstrates Trinity Framework capabilities, automates screening, consistent analysis
- **Cons**: API costs, more complex, requires careful prompt engineering

## Recommended Approach

### Gmail Push Notifications + Claude Code
This hybrid approach provides:

1. **Real-time responsiveness** (Gmail Push)
2. **Trinity Framework showcase** (Claude Code)
3. **High reliability** (event-driven architecture)
4. **Scalable solution** (cloud functions)

### Implementation Steps
1. Set up Gmail API push notifications to trigger cloud function
2. Cloud function invokes Claude with structured prompt
3. Claude processes application and outputs structured assessment
4. Update tracking sheet with application details and assessment
5. HISTORIAN reviews Claude's assessment before presenting to human operator

This approach would be a compelling demonstration of Trinity Framework's capabilities, showing how AI can be integrated into real business workflows.

## Next Steps

1. Set up Google Cloud project and enable APIs
2. Create service account for API access
3. Build beta tester tracking spreadsheet
4. Implement email monitoring system (push notifications recommended)
5. Create GitHub Pages status site
6. Connect monitoring system to spreadsheet and status site
7. Test end-to-end with sample applications
8. Launch beta management system

## Conclusion

This proposed beta management system leverages the Trinity Framework architecture while providing an efficient, secure process for managing beta applications. It demonstrates the framework's capabilities in a real-world scenario while ensuring a positive experience for beta testers.