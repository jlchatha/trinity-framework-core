#!/usr/bin/env node

/**
 * Memory Leak Fix for Claude Code AbortSignal Listeners
 * 
 * Purpose: Apply setMaxListeners fix to prevent MaxListenersExceededWarning
 * in Claude Code environment when using context tracking system.
 * 
 * Usage: Run this before starting Claude Code session or include in startup
 * 
 * Date: June 24, 2025
 * Framework: Trinity Framework 2.0
 */

const events = require('events');

// Increase default max listeners to handle Claude Code's abort signal usage
// Default is 10, increasing to 50 to accommodate multiple concurrent operations
events.EventTarget.defaultMaxListeners = 50;

// Also set it on the global EventTarget if available
if (global.EventTarget) {
  global.EventTarget.defaultMaxListeners = 50;
}

// For Node.js EventEmitter instances (fallback)
events.EventEmitter.defaultMaxListeners = 50;

console.log('Memory leak fix applied: EventTarget max listeners set to 50');
console.log('This should resolve MaxListenersExceededWarning for AbortSignal listeners');

// Log current settings
console.log(`EventEmitter.defaultMaxListeners: ${events.EventEmitter.defaultMaxListeners}`);
if (events.EventTarget) {
  console.log(`EventTarget.defaultMaxListeners: ${events.EventTarget.defaultMaxListeners}`);
}