# Trinity Beta Application Monitor

Monitors apex@trinity-apex.com Gmail for Formspree beta applications.

## Setup

1. Run the setup script:
   ```bash
   ./setup.sh
   ```

2. First run will prompt for Gmail authorization:
   ```bash
   npm run monitor
   ```

3. Visit the URL shown and authorize access
4. Enter the code back in terminal

## Usage

Check for new applications:
```bash
npm run monitor
```

## Features

- Tracks total applications (50 max)
- Shows BYOC vs We-Manage breakdown
- Alerts when approaching capacity
- Saves state between runs
- Parses Formspree email format

## Output Example

```
Trinity Beta Application Monitor
================================

Found 2 new messages
New application from: John Doe (john@example.com)
Plan: BYOC
Total applications: 12/50

=== Beta Application Summary ===
Total Applications: 12/50
Spots Remaining: 38
BYOC Applications: 8
We-Manage Applications: 4
Last Check: 2025-06-30T12:00:00Z
```

## Files

- `credentials.json` - OAuth2 credentials (DO NOT COMMIT)
- `token.json` - Auth token (created on first run, DO NOT COMMIT)
- `monitor-state.json` - Tracking state
- `monitor-beta-applications.js` - Main script

## Security

Never commit credentials.json or token.json to git!