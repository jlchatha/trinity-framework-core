/**
 * Token Counter for Trinity Framework 2.0 Core
 * 
 * Purpose: Track token usage for context management with standardized
 * operation types and token estimation.
 * 
 * Version: 1.0.0
 * Framework: Trinity Framework 2.0
 */

// Apply memory leak fix for Claude Code AbortSignal listeners
const events = require('events');
events.EventEmitter.defaultMaxListeners = 50;
if (events.EventTarget) {
  events.EventTarget.defaultMaxListeners = 50;
}

/**
 * TokenCounter class for tracking context utilization
 */
class TokenCounter {
  /**
   * Create a new TokenCounter instance
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    // Configuration
    this.maxTokens = options.maxTokens || 200000;
    this.baseUtilization = options.baseUtilization || 0.1; // 10%
    
    // Token estimates for different operations (standardized values)
    this.tokenEstimates = {
      // User messages
      USER_SMALL: 750,
      USER_MEDIUM: 2200,
      USER_LARGE: 4400,
      
      // Assistant responses
      ASSISTANT_SMALL: 1500,
      ASSISTANT_MEDIUM: 4400,
      ASSISTANT_LARGE: 10000,
      
      // Tool operations
      TOOL_READ_SMALL: 1500,
      TOOL_READ_MEDIUM: 4400,
      TOOL_READ_LARGE: 7500,
      TOOL_WRITE: 750,
      TOOL_EDIT: 1500,
      TOOL_TASK: 6000,
      
      // Default value if type not recognized
      DEFAULT: 2000
    };
    
    // Thresholds for notifications
    this.thresholds = {
      NOTICE: 65,  // 65%
      WARNING: 75, // 75%
      ALERT: 85    // 85%
    };
    
    // Initialize state
    this.initialize();
  }
  
  /**
   * Initialize or reset the counter state
   */
  initialize() {
    // Calculate base tokens (10% of max)
    const baseTokens = Math.floor(this.maxTokens * this.baseUtilization);
    
    // Set initial state
    this.state = {
      tokens: baseTokens,
      maxTokens: this.maxTokens,
      utilizationPercentage: Math.round(this.baseUtilization * 100),
      thresholdStatus: 'normal',
      operations: [{
        type: 'SYSTEM_INITIALIZATION',
        tokens: baseTokens,
        timestamp: new Date().toISOString()
      }],
      checkpoints: [],
      autoCompactStatus: {
        inProgress: false,
        checkpointId: null
      },
      remainingCapacity: this.calculateRemainingCapacity(baseTokens)
    };
    
    return this.state;
  }
  
  /**
   * Update context with a new operation
   * @param {string} operationType - Type of operation (e.g., 'USER_SMALL', 'ASSISTANT_MEDIUM')
   * @param {string} content - Optional content for more accurate estimation
   * @returns {Object} Updated state
   */
  updateContext(operationType, content = '') {
    // Estimate tokens
    const tokens = this.estimateTokens(operationType, content);
    
    // Update state
    this.state.tokens += tokens;
    this.state.utilizationPercentage = Math.min(100, Math.round((this.state.tokens / this.maxTokens) * 100));
    
    // Add operation to history
    this.state.operations.push({
      type: operationType,
      tokens,
      timestamp: new Date().toISOString()
    });
    
    // Calculate remaining capacity
    this.state.remainingCapacity = this.calculateRemainingCapacity(this.state.tokens);
    
    // Check thresholds
    const previousThreshold = this.state.thresholdStatus;
    this.updateThresholdStatus();
    
    // Check if threshold crossed
    if (this.state.thresholdStatus !== previousThreshold && this.state.thresholdStatus !== 'normal') {
      this.createCheckpoint();
    }
    
    return this.state;
  }
  
  /**
   * Estimate tokens for an operation
   * @param {string} operationType - Type of operation
   * @param {string} content - Optional content for estimation
   * @returns {number} Estimated tokens
   */
  estimateTokens(operationType, content) {
    // Get base token estimate from operation type
    let tokens = this.tokenEstimates[operationType] || this.tokenEstimates.DEFAULT;
    
    // If content is provided, refine estimate based on content
    if (content) {
      // For text content, estimate based on character count
      const charCount = content.length;
      const wordCount = content.split(/\s+/).length;
      
      // Approximate token count (4 chars per token or 0.75 tokens per word)
      const charBasedEstimate = Math.ceil(charCount / 4);
      const wordBasedEstimate = Math.ceil(wordCount * 0.75);
      
      // Use the average of character and word based estimates
      const contentBasedEstimate = Math.ceil((charBasedEstimate + wordBasedEstimate) / 2);
      
      // Use the larger of the type-based or content-based estimate
      tokens = Math.max(tokens, contentBasedEstimate);
    }
    
    return tokens;
  }
  
  /**
   * Calculate remaining capacity based on current token usage
   * @param {number} currentTokens - Current token count
   * @returns {Object} Remaining capacity estimates
   */
  calculateRemainingCapacity(currentTokens) {
    const remainingTokens = this.maxTokens - currentTokens;
    
    return {
      largeOperations: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_LARGE),
      mediumOperations: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_MEDIUM),
      smallOperations: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_SMALL)
    };
  }
  
  /**
   * Update threshold status based on current utilization
   */
  updateThresholdStatus() {
    if (this.state.utilizationPercentage >= this.thresholds.ALERT) {
      this.state.thresholdStatus = 'alert';
    } else if (this.state.utilizationPercentage >= this.thresholds.WARNING) {
      this.state.thresholdStatus = 'warning';
    } else if (this.state.utilizationPercentage >= this.thresholds.NOTICE) {
      this.state.thresholdStatus = 'notice';
    } else {
      this.state.thresholdStatus = 'normal';
    }
    
    return this.state.thresholdStatus;
  }
  
  /**
   * Create a checkpoint at current state
   * @param {string} label - Optional label for the checkpoint
   * @returns {Object} Created checkpoint
   */
  createCheckpoint(label = '') {
    const timestamp = new Date().toISOString();
    const id = `ckpt_${label || this.state.thresholdStatus}_${timestamp.replace(/[^0-9]/g, '')}`;
    
    const checkpoint = {
      id,
      timestamp,
      utilizationPercentage: this.state.utilizationPercentage,
      tokens: this.state.tokens,
      thresholdStatus: this.state.thresholdStatus,
      operations: this.state.operations.slice(-10) // Keep last 10 operations
    };
    
    // Add to checkpoints list
    this.state.checkpoints.push(checkpoint);
    
    // Keep only last 3 checkpoints
    if (this.state.checkpoints.length > 3) {
      this.state.checkpoints = this.state.checkpoints.slice(-3);
    }
    
    return checkpoint;
  }
  
  /**
   * Create a special checkpoint for auto-compact
   * @returns {Object} Created checkpoint
   */
  createCompactCheckpoint() {
    const timestamp = new Date().toISOString();
    const id = `ckpt_compact_${timestamp.replace(/[^0-9]/g, '')}`;
    
    const checkpoint = {
      id,
      timestamp,
      utilizationPercentage: this.state.utilizationPercentage,
      tokens: this.state.tokens,
      thresholdStatus: this.state.thresholdStatus,
      isCompactCheckpoint: true,
      operations: this.state.operations.slice(-10) // Keep last 10 operations
    };
    
    // Add to checkpoints list
    this.state.checkpoints.push(checkpoint);
    
    // Keep only last 3 checkpoints
    if (this.state.checkpoints.length > 3) {
      this.state.checkpoints = this.state.checkpoints.slice(-3);
    }
    
    return checkpoint;
  }
  
  /**
   * Handle auto-compact preparation
   * @param {boolean} proceed - Whether to proceed with auto-compact
   * @returns {Object} Updated state
   */
  handleAutoCompact(proceed) {
    if (proceed) {
      // Create compact checkpoint
      const checkpoint = this.createCompactCheckpoint();
      
      // Update auto-compact status
      this.state.autoCompactStatus = {
        inProgress: true,
        initiatedAt: new Date().toISOString(),
        checkpointId: checkpoint.id
      };
    } else {
      // Just create regular checkpoint
      this.createCheckpoint('user_declined');
    }
    
    return this.state;
  }
  
  /**
   * Check if recovery from auto-compact is needed
   * @returns {Object} Recovery result
   */
  checkRecovery() {
    // If auto-compact was not in progress, no recovery needed
    if (!this.state.autoCompactStatus || !this.state.autoCompactStatus.inProgress) {
      return {
        recovered: false,
        message: 'No recovery needed, continuing session'
      };
    }
    
    // Get compact checkpoint
    const checkpoint = this.state.checkpoints.find(
      c => c.id === this.state.autoCompactStatus.checkpointId
    );
    
    if (!checkpoint) {
      return {
        recovered: false,
        message: 'Recovery checkpoint not found, starting fresh session'
      };
    }
    
    // Store previous utilization
    const previousUtilization = checkpoint.utilizationPercentage;
    
    // Reset tokens to post-compact state (25% of max)
    this.state.tokens = Math.floor(this.maxTokens * 0.25);
    this.state.utilizationPercentage = 25;
    
    // Update remaining capacity
    this.state.remainingCapacity = this.calculateRemainingCapacity(this.state.tokens);
    
    // Mark auto-compact as completed
    this.state.autoCompactStatus.inProgress = false;
    this.state.autoCompactStatus.completedAt = new Date().toISOString();
    
    // Return recovery info
    return {
      recovered: true,
      checkpointId: checkpoint.id,
      previousUtilization,
      currentUtilization: this.state.utilizationPercentage,
      implementationState: 'Framework 2.0 Core Implementation'
    };
  }
  
  /**
   * Get current state
   * @returns {Object} Current state
   */
  getState() {
    return { ...this.state };
  }
  
  /**
   * Set state (for loading saved state)
   * @param {Object} newState - State to load
   * @returns {Object} Updated state
   */
  setState(newState) {
    if (!newState) return this.state;
    
    this.state = {
      ...this.state,
      ...newState
    };
    
    return this.state;
  }
}

// Export the class
if (typeof module !== 'undefined' && module.exports) {
  module.exports = TokenCounter;
}

// Example usage (for demonstration)
if (require.main === module) {
  const counter = new TokenCounter();
  
  // Simulate some operations
  console.log("Initial state:");
  console.log(`Context: ${counter.state.utilizationPercentage}% (${counter.state.tokens}/${counter.state.maxTokens} tokens)`);
  
  console.log("\nAfter user message:");
  counter.updateContext('USER_MEDIUM');
  console.log(`Context: ${counter.state.utilizationPercentage}% (${counter.state.tokens}/${counter.state.maxTokens} tokens)`);
  
  console.log("\nAfter assistant response:");
  counter.updateContext('ASSISTANT_MEDIUM');
  console.log(`Context: ${counter.state.utilizationPercentage}% (${counter.state.tokens}/${counter.state.maxTokens} tokens)`);
  
  console.log("\nAfter tool operation:");
  counter.updateContext('TOOL_READ_LARGE');
  console.log(`Context: ${counter.state.utilizationPercentage}% (${counter.state.tokens}/${counter.state.maxTokens} tokens)`);
  
  console.log("\nRemaining capacity:");
  console.log(`Large operations: ~${counter.state.remainingCapacity.largeOperations}`);
  console.log(`Medium operations: ~${counter.state.remainingCapacity.mediumOperations}`);
  console.log(`Small operations: ~${counter.state.remainingCapacity.smallOperations}`);
}