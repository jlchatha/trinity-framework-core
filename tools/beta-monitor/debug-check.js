#!/usr/bin/env node

const fs = require('fs').promises;
const path = require('path');
const { google } = require('googleapis');

const TOKEN_PATH = path.join(__dirname, 'token.json');
const CREDENTIALS_PATH = path.join(__dirname, 'credentials.json');

async function debugCheck() {
    try {
        const credentials = JSON.parse(await fs.readFile(CREDENTIALS_PATH));
        const { client_secret, client_id, redirect_uris } = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);
        
        const token = JSON.parse(await fs.readFile(TOKEN_PATH));
        oAuth2Client.setCredentials(token);
        
        const gmail = google.gmail({ version: 'v1', auth: oAuth2Client });
        
        // Try different queries
        const queries = [
            'from:noreply@formspree.io',
            'subject:"New submission"',
            'newer_than:1d',
            'from:formspree',
            'in:inbox newer_than:1h'
        ];
        
        for (const query of queries) {
            console.log(`\nChecking with query: "${query}"`);
            
            try {
                const res = await gmail.users.messages.list({
                    userId: 'me',
                    q: query,
                    maxResults: 5
                });
                
                const count = res.data.messages ? res.data.messages.length : 0;
                console.log(`Found ${count} messages`);
                
                if (res.data.messages && res.data.messages.length > 0) {
                    // Get first message details
                    const msg = await gmail.users.messages.get({
                        userId: 'me',
                        id: res.data.messages[0].id,
                    });
                    
                    console.log('First message:');
                    console.log('- Subject:', msg.data.payload.headers.find(h => h.name === 'Subject')?.value);
                    console.log('- From:', msg.data.payload.headers.find(h => h.name === 'From')?.value);
                    console.log('- Date:', msg.data.payload.headers.find(h => h.name === 'Date')?.value);
                }
            } catch (err) {
                console.error(`Error with query: ${err.message}`);
            }
        }
        
    } catch (err) {
        console.error('Error:', err);
    }
}

debugCheck();