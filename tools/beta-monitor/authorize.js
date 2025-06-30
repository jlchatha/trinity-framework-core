#!/usr/bin/env node

/**
 * Standalone authorization script for Trinity Beta Monitor
 */

const fs = require('fs').promises;
const path = require('path');
const { google } = require('googleapis');

const SCOPES = ['https://www.googleapis.com/auth/gmail.readonly'];
const TOKEN_PATH = path.join(__dirname, 'token.json');
const CREDENTIALS_PATH = path.join(__dirname, 'credentials.json');

// The authorization code from the URL
const AUTH_CODE = '4/0AVMBsJi4u4yDcsP6Zcmic_Nclcx70WmJEt1KaoWWZkkyg_0mRl0qJqW4OgK9AgWbO-2rwg';

async function authorize() {
    try {
        const credentials = JSON.parse(await fs.readFile(CREDENTIALS_PATH));
        const { client_secret, client_id, redirect_uris } = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);

        console.log('Getting token with authorization code...');
        
        try {
            const { tokens } = await oAuth2Client.getToken(AUTH_CODE);
            oAuth2Client.setCredentials(tokens);
            await fs.writeFile(TOKEN_PATH, JSON.stringify(tokens));
            console.log('✅ Token stored successfully!');
            console.log('You can now run: npm run monitor');
            return oAuth2Client;
        } catch (err) {
            console.error('Error getting token:', err.message);
            if (err.message.includes('invalid_grant')) {
                console.log('\nThe authorization code may have expired. Please:');
                console.log('1. Visit the URL again');
                console.log('2. Get a new code');
                console.log('3. Update AUTH_CODE in this file');
            }
        }
    } catch (err) {
        console.error('Error loading credentials:', err);
    }
}

// Run
authorize().catch(console.error);