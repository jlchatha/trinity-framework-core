/**
 * Context Visualization for Trinity Framework 2.0 Core
 * 
 * Purpose: Provide text-based visualization components for context management
 * system, including context meter, threshold notifications, and recovery display.
 * 
 * Version: 1.0.0
 * Framework: Trinity Framework 2.0
 */

/**
 * ContextMeter class for text-based context visualization
 */
class ContextMeter {
  /**
   * Create a new ContextMeter instance
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    // Configuration
    this.meterSegments = options.meterSegments || 20;
    this.colorSupport = options.colorSupport || false;
    this.thresholds = {
      notice: options.noticeThreshold || 0.65, // 65%
      warning: options.warningThreshold || 0.75, // 75%
      alert: options.alertThreshold || 0.85 // 85%
    };
    
    // Unicode characters for meter
    this.characters = {
      filled: '▓',
      empty: '░'
    };
  }
  
  /**
   * Generate a text-based context meter
   * @param {number} percentage - Utilization percentage (0-100)
   * @param {Object} remainingCapacity - Estimated remaining capacity
   * @returns {string} - Formatted context meter
   */
  createContextMeter(percentage, remainingCapacity) {
    // Calculate filled segments
    const filledSegments = Math.round((percentage / 100) * this.meterSegments);
    const emptySegments = this.meterSegments - filledSegments;
    
    // Create meter bar
    const filledPart = this.characters.filled.repeat(filledSegments);
    const emptyPart = this.characters.empty.repeat(emptySegments);
    const meterBar = filledPart + emptyPart;
    
    // Select appropriate remaining capacity metric
    let remainingText = '';
    if (remainingCapacity) {
      remainingText = `Remaining: ~${remainingCapacity.smallOperations} small operations`;
    }
    
    // Determine status label based on percentage
    let statusLabel = '';
    if (percentage >= this.thresholds.alert * 100) {
      statusLabel = 'ALERT';
    } else if (percentage >= this.thresholds.warning * 100) {
      statusLabel = 'WARNING';
    } else if (percentage >= this.thresholds.notice * 100) {
      statusLabel = 'NOTICE';
    }
    
    // Create formatted meter
    return `[Context: ${percentage}% ${meterBar}]${statusLabel ? ' ' + statusLabel : ''} ${remainingText}`;
  }
  
  /**
   * Generate threshold notification message
   * @param {string} threshold - Threshold name (notice, warning, alert)
   * @param {number} percentage - Utilization percentage (0-100)
   * @returns {string} - Formatted notification message
   */
  createThresholdNotification(threshold, percentage) {
    // Create base context meter
    const meter = this.createContextMeter(percentage, null);
    
    // Add threshold-specific message
    let message = '';
    
    switch (threshold) {
      case 'notice':
        message = `${meter}\nNOTICE: Checkpoint created automatically`;
        break;
      case 'warning':
        message = `${meter}\nWARNING: High context utilization detected\nConsider completing current task before starting new complex operations`;
        break;
      case 'alert':
        message = `${meter}\nALERT: Critical context utilization reached\n\nCreating checkpoint for recovery...\n\nWould you like to perform auto-compact now?`;
        break;
      default:
        message = meter;
    }
    
    return message;
  }
  
  /**
   * Generate auto-compact user prompt
   * @returns {string} - Formatted user prompt
   */
  createAutoCompactPrompt() {
    return `Type [Yes] to perform auto-compact now\nType [No] to continue without auto-compact`;
  }
  
  /**
   * Parse user response for auto-compact decision
   * @param {string} userInput - User's text response
   * @returns {boolean|null} - true for yes, false for no, null for invalid input
   */
  parseAutoCompactResponse(userInput) {
    if (!userInput) return null;
    
    const input = userInput.trim().toLowerCase();
    
    if (input === 'yes' || input === 'y' || input === '[yes]') {
      return true;
    } else if (input === 'no' || input === 'n' || input === '[no]') {
      return false;
    } else {
      return null;
    }
  }
  
  /**
   * Generate recovery display message
   * @param {Object} recoveryInfo - Recovery information
   * @param {string} recoveryInfo.checkpointId - ID of restored checkpoint
   * @param {number} recoveryInfo.previousUtilization - Previous utilization percentage
   * @param {number} recoveryInfo.currentUtilization - Current utilization percentage
   * @param {string} recoveryInfo.implementationState - Current implementation state
   * @param {Object} remainingCapacity - Estimated remaining capacity
   * @returns {string} - Formatted recovery message
   */
  createRecoveryDisplay(recoveryInfo, remainingCapacity) {
    const meter = this.createContextMeter(recoveryInfo.currentUtilization, remainingCapacity);
    
    return `[RECOVERY COMPLETE]
Restored from checkpoint: ${recoveryInfo.checkpointId}
Previous context: ${recoveryInfo.previousUtilization}% → Current context: ${recoveryInfo.currentUtilization}%
Implementation state: ${recoveryInfo.implementationState}

${meter}`;
  }
  
  /**
   * Generate example context meter for demonstration
   * @param {number} percentage - Utilization percentage (0-100)
   * @returns {string} - Formatted example meter
   */
  createExampleMeter(percentage = 35) {
    const remainingCapacity = {
      largeOperations: Math.floor((100 - percentage) / 5),
      mediumOperations: Math.floor((100 - percentage) / 2.5),
      smallOperations: Math.floor((100 - percentage) / 0.5)
    };
    
    return this.createContextMeter(percentage, remainingCapacity);
  }
}

// Export the class
if (typeof module !== 'undefined' && module.exports) {
  module.exports = ContextMeter;
}

// Example usage (for demonstration)
if (require.main === module) {
  const meter = new ContextMeter();
  
  // Examples at different thresholds
  console.log("Normal context (35%):");
  console.log(meter.createExampleMeter(35));
  console.log("\nNotice threshold (65%):");
  console.log(meter.createThresholdNotification('notice', 65));
  console.log("\nWarning threshold (75%):");
  console.log(meter.createThresholdNotification('warning', 75));
  console.log("\nAlert threshold (85%):");
  console.log(meter.createThresholdNotification('alert', 85));
  console.log("\nAuto-compact prompt:");
  console.log(meter.createAutoCompactPrompt());
  console.log("\nRecovery display:");
  console.log(meter.createRecoveryDisplay(
    {
      checkpointId: 'ckpt_warning_20250612164500000',
      previousUtilization: 75,
      currentUtilization: 25,
      implementationState: 'Context Management Implementation'
    },
    {
      largeOperations: 17,
      mediumOperations: 40,
      smallOperations: 120
    }
  ));
}