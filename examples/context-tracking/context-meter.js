/**
 * ContextMeter - Context visualization for Trinity Framework 2.0
 * 
 * Provides text-based visualization of context utilization
 * and threshold status indicators.
 * 
 * VERSION: 1.0.0
 * FRAMEWORK: Trinity Framework 2.0 Core
 */

class ContextMeter {
  constructor(options = {}) {
    // Configuration
    this.meterSegments = options.meterSegments || 20;
    this.colorSupport = options.colorSupport || false;
    this.thresholds = {
      notice: options.noticeThreshold || 0.65, // 65%
      warning: options.warningThreshold || 0.75, // 75%
      alert: options.alertThreshold || 0.85 // 85%
    };
    
    // Characters for visualization
    this.chars = {
      filled: '▓',
      empty: '░'
    };
    
    // Terminal colors (when supported)
    this.colors = {
      normal: '\x1b[0m',
      notice: '\x1b[33m', // Yellow
      warning: '\x1b[33;1m', // Bright yellow
      alert: '\x1b[31;1m', // Bright red
      reset: '\x1b[0m'
    };
  }
  
  /**
   * Generate a text-based meter visualization
   * @param {number} percentage - Utilization percentage (0-1)
   * @returns {string} Text-based meter visualization
   */
  generateMeter(percentage) {
    // Calculate filled segments
    const filledSegments = Math.round(percentage * this.meterSegments);
    const emptySegments = this.meterSegments - filledSegments;
    
    // Create meter string
    const meter = this.chars.filled.repeat(filledSegments) + 
                  this.chars.empty.repeat(emptySegments);
    
    // Determine threshold status
    const status = this.getThresholdStatus(percentage);
    
    // Format with color if supported
    if (this.colorSupport) {
      const color = this.colors[status] || this.colors.normal;
      return `${color}${meter}${this.colors.reset}`;
    }
    
    return meter;
  }
  
  /**
   * Get threshold status based on percentage
   * @param {number} percentage - Utilization percentage (0-1)
   * @returns {string} Threshold status
   */
  getThresholdStatus(percentage) {
    if (percentage >= this.thresholds.alert) {
      return 'alert';
    } else if (percentage >= this.thresholds.warning) {
      return 'warning';
    } else if (percentage >= this.thresholds.notice) {
      return 'notice';
    } else {
      return 'normal';
    }
  }
  
  /**
   * Get formatted notification based on threshold status
   * @param {number} percentage - Utilization percentage (0-1)
   * @returns {string} Notification text
   */
  getNotification(percentage) {
    const status = this.getThresholdStatus(percentage);
    
    switch (status) {
      case 'alert':
        return 'ALERT: Context nearing capacity. Compact recommended.';
      case 'warning':
        return 'WARNING: Context usage high. Consider compact soon.';
      case 'notice':
        return 'NOTICE: Context usage increasing.';
      default:
        return '';
    }
  }
  
  /**
   * Generate the complete visualization with meter and remaining capacity
   * @param {Object} tokenStatus - Token tracking status object
   * @returns {Object} Visualization components
   */
  generateVisualization(tokenStatus) {
    const percentage = tokenStatus.utilizationPercentage;
    const percentFormatted = Math.round(percentage * 100);
    const meter = this.generateMeter(percentage);
    const notification = this.getNotification(percentage);
    const status = this.getThresholdStatus(percentage);
    
    // Format remaining capacity
    const remaining = tokenStatus.remainingCapacity 
      ? `Remaining: ~${tokenStatus.remainingCapacity.small} small operations`
      : '';
      
    // Create standard visualization string
    const visualization = `[Context: ${percentFormatted}% ${meter}] ${remaining}`;
    
    return {
      visualization,
      notification,
      percentage: percentFormatted,
      meter,
      remaining,
      status
    };
  }
}

module.exports = ContextMeter;