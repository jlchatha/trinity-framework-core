#!/bin/bash

# Trinity Beta Monitor Setup Script

echo "Setting up Trinity Beta Application Monitor..."
echo "==========================================="

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is required but not installed."
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."
npm install

# Make monitor executable
chmod +x monitor-beta-applications.js

echo ""
echo "Setup complete! To start monitoring:"
echo "1. Run: npm run monitor"
echo "2. You'll be prompted to authorize Gmail access"
echo "3. Visit the URL and enter the authorization code"
echo ""
echo "The monitor will:"
echo "- Check for new Formspree submissions"
echo "- Track total applications (max 50)"
echo "- Show BYOC vs We-Manage breakdown"
echo "- Alert when approaching capacity"