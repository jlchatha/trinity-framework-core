/**
 * TokenCounter - Token tracking implementation for Trinity Framework 2.0
 * 
 * Provides token usage estimation and context utilization tracking
 * for framework-compliant agent systems.
 * 
 * VERSION: 1.0.0
 * FRAMEWORK: Trinity Framework 2.0 Core
 */

class TokenCounter {
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
      TOOL_TASK: 6000
    };
    
    // Thresholds for notifications
    this.thresholds = {
      notice: options.noticeThreshold || 0.65, // 65%
      warning: options.warningThreshold || 0.75, // 75%
      alert: options.alertThreshold || 0.85 // 85%
    };
    
    // Initial state
    this.reset();
  }
  
  /**
   * Reset token counter to initial state
   * @param {Object} options - Reset options
   * @param {number} options.utilization - Initial utilization percentage (0-1)
   */
  reset(options = {}) {
    this.currentTokens = Math.round(this.maxTokens * (options.utilization || this.baseUtilization));
    this.operations = [];
    this.thresholdStatus = this.getThresholdStatus();
    this.checkpoints = [];
    
    return {
      currentTokens: this.currentTokens,
      maxTokens: this.maxTokens,
      utilizationPercentage: this.getUtilizationPercentage(),
      thresholdStatus: this.thresholdStatus
    };
  }
  
  /**
   * Track an operation and update token count
   * @param {string} operationType - Type of operation from this.tokenEstimates
   * @returns {Object} Updated token status
   */
  trackOperation(operationType) {
    if (!this.tokenEstimates[operationType]) {
      throw new Error(`Unknown operation type: ${operationType}`);
    }
    
    const previousThresholdStatus = this.thresholdStatus;
    const tokenCount = this.tokenEstimates[operationType];
    
    this.currentTokens += tokenCount;
    this.operations.push({
      type: operationType,
      tokens: tokenCount,
      timestamp: new Date().toISOString()
    });
    
    const newThresholdStatus = this.getThresholdStatus();
    const thresholdCrossed = previousThresholdStatus !== newThresholdStatus;
    
    // Create checkpoint if threshold crossed
    if (thresholdCrossed) {
      this.createCheckpoint(newThresholdStatus);
    }
    
    return {
      currentTokens: this.currentTokens,
      maxTokens: this.maxTokens,
      utilizationPercentage: this.getUtilizationPercentage(),
      thresholdStatus: newThresholdStatus,
      thresholdCrossed,
      checkpointCreated: thresholdCrossed,
      operationType,
      tokenCount
    };
  }
  
  /**
   * Get current utilization percentage
   * @returns {number} Percentage as decimal (0-1)
   */
  getUtilizationPercentage() {
    return this.currentTokens / this.maxTokens;
  }
  
  /**
   * Get threshold status based on current utilization
   * @returns {string} Threshold status: 'normal', 'notice', 'warning', or 'alert'
   */
  getThresholdStatus() {
    const utilization = this.getUtilizationPercentage();
    
    if (utilization >= this.thresholds.alert) {
      return 'alert';
    } else if (utilization >= this.thresholds.warning) {
      return 'warning';
    } else if (utilization >= this.thresholds.notice) {
      return 'notice';
    } else {
      return 'normal';
    }
  }
  
  /**
   * Create a checkpoint at current state
   * @param {string} thresholdStatus - Current threshold status
   * @returns {Object} Created checkpoint
   */
  createCheckpoint(thresholdStatus) {
    const timestamp = new Date();
    const id = `ckpt_${thresholdStatus}_${timestamp.getTime()}`;
    
    const checkpoint = {
      id,
      timestamp: timestamp.toISOString(),
      currentTokens: this.currentTokens,
      maxTokens: this.maxTokens,
      utilizationPercentage: this.getUtilizationPercentage(),
      thresholdStatus,
      operations: [...this.operations]
    };
    
    this.checkpoints.push(checkpoint);
    
    return checkpoint;
  }
  
  /**
   * Get the most recent checkpoint
   * @returns {Object|null} Latest checkpoint or null if none exists
   */
  getLatestCheckpoint() {
    if (this.checkpoints.length === 0) {
      return null;
    }
    
    return this.checkpoints[this.checkpoints.length - 1];
  }
  
  /**
   * Estimate remaining capacity for different operation types
   * @returns {Object} Estimated remaining operations by type
   */
  estimateRemainingCapacity() {
    const remainingTokens = this.maxTokens - this.currentTokens;
    
    return {
      small: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_SMALL),
      medium: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_MEDIUM),
      large: Math.floor(remainingTokens / this.tokenEstimates.ASSISTANT_LARGE)
    };
  }
  
  /**
   * Generate a complete status report
   * @returns {Object} Complete token tracking status
   */
  getStatus() {
    return {
      currentTokens: this.currentTokens,
      maxTokens: this.maxTokens,
      utilizationPercentage: this.getUtilizationPercentage(),
      thresholdStatus: this.getThresholdStatus(),
      operationCount: this.operations.length,
      lastOperationTimestamp: this.operations.length > 0 
        ? this.operations[this.operations.length - 1].timestamp 
        : null,
      checkpoints: this.checkpoints.map(c => ({
        id: c.id,
        timestamp: c.timestamp,
        utilizationPercentage: c.utilizationPercentage,
        thresholdStatus: c.thresholdStatus
      })),
      remainingCapacity: this.estimateRemainingCapacity()
    };
  }
}

module.exports = TokenCounter;