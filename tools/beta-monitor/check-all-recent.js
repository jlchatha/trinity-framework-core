#!/usr/bin/env node

const fs = require('fs').promises;
const path = require('path');
const { google } = require('googleapis');

const TOKEN_PATH = path.join(__dirname, 'token.json');
const CREDENTIALS_PATH = path.join(__dirname, 'credentials.json');

async function checkAllRecent() {
    try {
        const credentials = JSON.parse(await fs.readFile(CREDENTIALS_PATH));
        const { client_secret, client_id, redirect_uris } = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);
        
        const token = JSON.parse(await fs.readFile(TOKEN_PATH));
        oAuth2Client.setCredentials(token);
        
        const gmail = google.gmail({ version: 'v1', auth: oAuth2Client });
        
        // Check multiple locations
        const locations = [
            { query: 'newer_than:5m', label: 'Last 5 minutes' },
            { query: 'from:noreply@formspree.io newer_than:1h', label: 'Formspree noreply (last hour)' },
            { query: 'from:team@formspree.io newer_than:1h', label: 'Formspree team (last hour)' },
            { query: 'subject:"New submission" newer_than:1h', label: 'New submission subject' },
            { query: 'in:spam newer_than:1h', label: 'Spam folder (last hour)' }
        ];
        
        for (const location of locations) {
            console.log(`\nChecking: ${location.label}`);
            console.log(`Query: ${location.query}\n`);
            
            const res = await gmail.users.messages.list({
                userId: 'me',
                q: location.query,
                maxResults: 10
            });
        
            const messages = res.data.messages || [];
            console.log(`Found ${messages.length} messages`);
            
            if (messages.length === 0) continue;
            
            for (const message of messages) {
            const msg = await gmail.users.messages.get({
                userId: 'me',
                id: message.id,
            });
            
            const headers = msg.data.payload.headers;
            const subject = headers.find(h => h.name === 'Subject')?.value || 'No subject';
            const from = headers.find(h => h.name === 'From')?.value || 'Unknown';
            const date = headers.find(h => h.name === 'Date')?.value || 'Unknown';
            
            console.log('---');
            console.log('Subject:', subject);
            console.log('From:', from);
            console.log('Date:', date);
            
                // If it looks like it might be form-related
                if (from.toLowerCase().includes('form') || 
                    subject.toLowerCase().includes('submission') ||
                    subject.toLowerCase().includes('trinity')) {
                    console.log('*** POTENTIAL FORM EMAIL ***');
                }
            }
        }
        
    } catch (err) {
        console.error('Error:', err);
    }
}

checkAllRecent();