#!/usr/bin/env node

/**
 * Trinity Beta Application Monitor
 * Monitors apex@trinity-apex.com for Formspree submissions
 */

const fs = require('fs').promises;
const path = require('path');
const { google } = require('googleapis');
const readline = require('readline');

// Configuration
const SCOPES = ['https://www.googleapis.com/auth/gmail.readonly'];
const TOKEN_PATH = path.join(__dirname, 'token.json');
const CREDENTIALS_PATH = path.join(__dirname, 'credentials.json');
const STATE_PATH = path.join(__dirname, 'monitor-state.json');

// Load or initialize state
async function loadState() {
    try {
        const data = await fs.readFile(STATE_PATH, 'utf8');
        return JSON.parse(data);
    } catch (err) {
        return {
            lastCheck: null,
            totalApplications: 0,
            processedMessageIds: [],
            applications: []
        };
    }
}

// Save state
async function saveState(state) {
    await fs.writeFile(STATE_PATH, JSON.stringify(state, null, 2));
}

// Authorize with OAuth2
async function authorize() {
    try {
        const credentials = JSON.parse(await fs.readFile(CREDENTIALS_PATH));
        const { client_secret, client_id, redirect_uris } = credentials.installed;
        const oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);

        try {
            const token = JSON.parse(await fs.readFile(TOKEN_PATH));
            oAuth2Client.setCredentials(token);
            return oAuth2Client;
        } catch (err) {
            return await getNewToken(oAuth2Client);
        }
    } catch (err) {
        console.error('Error loading credentials:', err);
        process.exit(1);
    }
}

// Get new token
async function getNewToken(oAuth2Client) {
    const authUrl = oAuth2Client.generateAuthUrl({
        access_type: 'offline',
        scope: SCOPES,
    });
    
    console.log('Authorize this app by visiting this url:', authUrl);
    
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    
    return new Promise((resolve, reject) => {
        rl.question('Enter the code from that page here: ', async (code) => {
            rl.close();
            try {
                const { tokens } = await oAuth2Client.getToken(code);
                oAuth2Client.setCredentials(tokens);
                await fs.writeFile(TOKEN_PATH, JSON.stringify(tokens));
                console.log('Token stored successfully.');
                resolve(oAuth2Client);
            } catch (err) {
                reject(err);
            }
        });
    });
}

// Parse Formspree email content
function parseFormspreeEmail(emailBody) {
    const application = {};
    
    // Debug: log the email body structure
    console.log('\nParsing email body...');
    
    // Extract fields using regex - try multiple patterns
    const nameMatch = emailBody.match(/name[:\s]+(.+)/i) || emailBody.match(/Name:\s*(.+)/);
    const emailMatch = emailBody.match(/email[:\s]+(.+)/i) || emailBody.match(/Email:\s*(.+)/);
    const planMatch = emailBody.match(/plan[:\s]+(.+)/i) || emailBody.match(/Preferred Plan:\s*(.+)/);
    const projectMatch = emailBody.match(/project[:\s]+([\s\S]+?)(?=\n\w+:|$)/i) || emailBody.match(/What are you hoping to build\?[:\s]*([\s\S]+?)(?=\n\n|$)/);
    
    if (nameMatch) application.name = nameMatch[1].trim();
    if (emailMatch) application.email = emailMatch[1].trim();
    if (planMatch) {
        const plan = planMatch[1].trim().toLowerCase();
        if (plan.includes('byoc')) {
            application.planType = 'BYOC';
        } else if (plan.includes('we-manage') || plan.includes('manage')) {
            application.planType = 'We-Manage';
        } else {
            application.planType = plan;
        }
    }
    if (projectMatch) application.project = projectMatch[1].trim();
    
    return application;
}

// Monitor for new applications
async function monitorApplications(auth) {
    const gmail = google.gmail({ version: 'v1', auth });
    const state = await loadState();
    
    // Search for Formspree emails - trying multiple patterns
    const queries = [
        'from:noreply@formspree.io subject:"New Trinity Beta Application"',
        'from:noreply@formspree.io subject:"New submission"',
        'from:formspree subject:"Trinity"',
        'from:noreply@formspree.io newer_than:1d'
    ];
    
    let allMessages = [];
    
    for (const query of queries) {
        console.log(`Searching with: ${query}`);
        
        try {
            const res = await gmail.users.messages.list({
                userId: 'me',
                q: query,
            });
            
            const messages = res.data.messages || [];
            if (messages.length > 0) {
                console.log(`  Found ${messages.length} messages`);
                allMessages = allMessages.concat(messages);
            }
        } catch (err) {
            console.error(`  Error with query: ${err.message}`);
        }
    }
    
    // Remove duplicates
    const uniqueMessages = Array.from(new Map(allMessages.map(m => [m.id, m])).values());
    console.log(`\nTotal unique messages found: ${uniqueMessages.length}`);
    
    try {
        for (const message of uniqueMessages) {
            // Skip if already processed
            if (state.processedMessageIds.includes(message.id)) {
                continue;
            }
            
            // Get full message
            const msg = await gmail.users.messages.get({
                userId: 'me',
                id: message.id,
            });
            
            // Extract email body
            let emailBody = '';
            const payload = msg.data.payload;
            
            if (payload.parts) {
                for (const part of payload.parts) {
                    if (part.mimeType === 'text/plain') {
                        emailBody = Buffer.from(part.body.data, 'base64').toString();
                        break;
                    }
                }
            } else if (payload.body && payload.body.data) {
                emailBody = Buffer.from(payload.body.data, 'base64').toString();
            }
            
            // Parse application
            const application = parseFormspreeEmail(emailBody);
            application.id = message.id;
            application.timestamp = new Date().toISOString();
            
            // Add to state
            state.applications.push(application);
            state.processedMessageIds.push(message.id);
            state.totalApplications++;
            
            console.log(`New application from: ${application.name} (${application.email})`);
            console.log(`Plan: ${application.planType}`);
            console.log(`Total applications: ${state.totalApplications}/50`);
            
            // Note: Skipping label modification due to permissions
        }
        
        state.lastCheck = new Date().toISOString();
        await saveState(state);
        
        // Generate summary
        console.log('\n=== Beta Application Summary ===');
        console.log(`Total Applications: ${state.totalApplications}/50`);
        console.log(`Spots Remaining: ${50 - state.totalApplications}`);
        
        const byocCount = state.applications.filter(a => a.planType === 'BYOC').length;
        const weManagedCount = state.applications.filter(a => a.planType === 'We-Manage').length;
        
        console.log(`BYOC Applications: ${byocCount}`);
        console.log(`We-Manage Applications: ${weManagedCount}`);
        console.log(`Last Check: ${state.lastCheck}`);
        
        // Alert if approaching capacity
        if (state.totalApplications >= 45) {
            console.log('\n⚠️  WARNING: Approaching capacity! Only ${50 - state.totalApplications} spots left!');
        }
        
    } catch (err) {
        console.error('Error checking emails:', err);
    }
}

// Main function
async function main() {
    console.log('Trinity Beta Application Monitor');
    console.log('================================\n');
    
    const auth = await authorize();
    await monitorApplications(auth);
}

// Run
if (require.main === module) {
    main().catch(console.error);
}

module.exports = { monitorApplications };