/**
 * Auto-Compact Detector
 * Trinity Framework 2.0 Optional Context Management System
 * 
 * This module provides functionality to detect when an auto-compact has occurred
 * by comparing conversation state before and after potential resets. It works by
 * maintaining a small fingerprint of conversation state that can be compared
 * across context resets.
 * 
 * Usage:
 *   const detector = require('./auto-compact-detector');
 *   
 *   // At the beginning of a session or after known reset
 *   detector.initialize();
 *   
 *   // Periodically check if a reset has occurred
 *   if (detector.hasResetOccurred()) {
 *     console.log("Auto-compact detected! Initiating recovery...");
 *     // Run recovery procedures
 *   }
 */

// Configuration
const CONFIG = {
  // Storage location for session fingerprint
  storagePath: process.env.HOME + "/workspace/tools/context-management/storage/session-fingerprint.json",
  
  // Threshold for determining if reset has occurred (0-1.0)
  similarityThreshold: 0.3,
  
  // Maximum number of messages to keep in fingerprint
  maxStoredMessages: 5,
  
  // Debug mode toggle
  debug: false
};

// In-memory session data
let sessionData = {
  initialized: false,
  lastCheckTime: null,
  messageFingerprints: [],
  lastMessageHash: null
};

/**
 * Initialize the detector at the beginning of a session
 * or after a known reset point
 */
function initialize() {
  try {
    const fs = require('fs');
    const path = require('path');
    
    // Create directory if it doesn't exist
    const dir = path.dirname(CONFIG.storagePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    // Reset session data
    sessionData = {
      initialized: true,
      lastCheckTime: Date.now(),
      messageFingerprints: [],
      lastMessageHash: null
    };
    
    // Save initial state
    fs.writeFileSync(
      CONFIG.storagePath,
      JSON.stringify(sessionData, null, 2),
      'utf8'
    );
    
    if (CONFIG.debug) {
      console.log("Auto-compact detector initialized");
    }
    
    return true;
  } catch (error) {
    console.error("Error initializing auto-compact detector:", error);
    return false;
  }
}

/**
 * Update the conversation fingerprint with a new message
 * @param {string} message - The message to add to the fingerprint
 */
function updateFingerprint(message) {
  if (!sessionData.initialized) {
    initialize();
  }
  
  try {
    const fs = require('fs');
    
    // Create a simple hash of the message
    const hash = createSimpleHash(message);
    sessionData.lastMessageHash = hash;
    
    // Add to fingerprints, maintaining max length
    sessionData.messageFingerprints.push(hash);
    if (sessionData.messageFingerprints.length > CONFIG.maxStoredMessages) {
      sessionData.messageFingerprints.shift();
    }
    
    sessionData.lastCheckTime = Date.now();
    
    // Save updated state
    fs.writeFileSync(
      CONFIG.storagePath,
      JSON.stringify(sessionData, null, 2),
      'utf8'
    );
    
    if (CONFIG.debug) {
      console.log(`Fingerprint updated: ${hash}`);
    }
    
    return true;
  } catch (error) {
    console.error("Error updating fingerprint:", error);
    return false;
  }
}

/**
 * Check if an auto-compact reset has likely occurred
 * @returns {boolean} True if a reset is detected
 */
function hasResetOccurred() {
  try {
    const fs = require('fs');
    
    // If we can't read the file, assume this is first run after reset
    if (!fs.existsSync(CONFIG.storagePath)) {
      if (CONFIG.debug) {
        console.log("No fingerprint file found, assuming reset");
      }
      return true;
    }
    
    // Read stored fingerprint
    const storedData = JSON.parse(fs.readFileSync(CONFIG.storagePath, 'utf8'));
    
    // If stored data exists but current session isn't initialized, 
    // we've likely had a reset
    if (storedData.initialized && !sessionData.initialized) {
      if (CONFIG.debug) {
        console.log("Session not initialized but stored data exists, reset detected");
      }
      return true;
    }
    
    // Compare fingerprints
    const storedFingerprints = storedData.messageFingerprints || [];
    const currentFingerprints = sessionData.messageFingerprints || [];
    
    // If both are empty, we can't determine
    if (storedFingerprints.length === 0 && currentFingerprints.length === 0) {
      return false;
    }
    
    // Calculate similarity between stored and current fingerprints
    const similarity = calculateSimilarity(storedFingerprints, currentFingerprints);
    
    if (CONFIG.debug) {
      console.log(`Fingerprint similarity: ${similarity}`);
    }
    
    // If similarity is below threshold, reset likely occurred
    return similarity < CONFIG.similarityThreshold;
    
  } catch (error) {
    console.error("Error checking for reset:", error);
    // If we can't check properly, assume reset to be safe
    return true;
  }
}

/**
 * Create a simple hash of a string
 * @param {string} str - The string to hash
 * @returns {string} A simple hash of the string
 */
function createSimpleHash(str) {
  if (!str) return "empty";
  
  // Take the first 50 chars to avoid excessive processing
  const sample = str.slice(0, 50);
  
  // Simple hash function
  let hash = 0;
  for (let i = 0; i < sample.length; i++) {
    const char = sample.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash; // Convert to 32bit integer
  }
  
  return hash.toString(16); // Convert to hex
}

/**
 * Calculate similarity between two arrays of fingerprints
 * @param {Array} arr1 - First array of fingerprints
 * @param {Array} arr2 - Second array of fingerprints
 * @returns {number} Similarity score (0-1.0)
 */
function calculateSimilarity(arr1, arr2) {
  if (!arr1.length || !arr2.length) return 0;
  
  // Find matches
  let matches = 0;
  for (const fp1 of arr1) {
    if (arr2.includes(fp1)) {
      matches++;
    }
  }
  
  // Calculate Jaccard similarity
  const union = new Set([...arr1, ...arr2]).size;
  return union === 0 ? 0 : matches / union;
}

/**
 * Retrieve current state for diagnostics
 * @returns {Object} Current detector state
 */
function getState() {
  return {
    initialized: sessionData.initialized,
    lastCheckTime: sessionData.lastCheckTime,
    fingerprintCount: sessionData.messageFingerprints.length,
    lastMessageHash: sessionData.lastMessageHash,
    storagePath: CONFIG.storagePath
  };
}

// Export the public API
module.exports = {
  initialize,
  updateFingerprint,
  hasResetOccurred,
  getState
};