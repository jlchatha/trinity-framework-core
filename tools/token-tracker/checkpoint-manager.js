/**
 * Checkpoint Manager for Trinity Framework 2.0 Core
 * 
 * Purpose: Create, manage, and restore serialized state checkpoints
 * for context management and recovery.
 * 
 * Version: 1.0.0
 * Framework: Trinity Framework 2.0
 */

const fs = require('fs');
const path = require('path');

/**
 * CheckpointManager class for managing context checkpoints
 */
class CheckpointManager {
  /**
   * Create a new CheckpointManager instance
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    // Configuration
    this.checkpointDir = options.checkpointDir || './checkpoints';
    this.maxCheckpoints = options.maxCheckpoints || 3;
    
    // Ensure checkpoint directory exists
    this.ensureCheckpointDir();
  }
  
  /**
   * Ensure checkpoint directory exists
   */
  ensureCheckpointDir() {
    try {
      if (!fs.existsSync(this.checkpointDir)) {
        fs.mkdirSync(this.checkpointDir, { recursive: true });
      }
    } catch (error) {
      console.error(`Error creating checkpoint directory: ${error.message}`);
    }
  }
  
  /**
   * Create a checkpoint from state
   * @param {Object} state - State object to checkpoint
   * @param {string} label - Optional label for the checkpoint
   * @returns {Object} Created checkpoint
   */
  createCheckpoint(state, label = '') {
    // Generate checkpoint ID and metadata
    const timestamp = new Date().toISOString();
    const id = `ckpt_${label || state.thresholdStatus || 'manual'}_${timestamp.replace(/[^0-9]/g, '')}`;
    
    // Create checkpoint object
    const checkpoint = {
      id,
      timestamp,
      utilizationPercentage: state.utilizationPercentage,
      tokens: state.tokens,
      thresholdStatus: state.thresholdStatus,
      operations: state.operations ? state.operations.slice(-10) : [],
      isCompactCheckpoint: label === 'compact'
    };
    
    // Save checkpoint to disk
    this.saveCheckpoint(checkpoint);
    
    return checkpoint;
  }
  
  /**
   * Save checkpoint to disk
   * @param {Object} checkpoint - Checkpoint to save
   */
  saveCheckpoint(checkpoint) {
    try {
      const filePath = path.join(this.checkpointDir, `${checkpoint.id}.json`);
      fs.writeFileSync(filePath, JSON.stringify(checkpoint, null, 2), 'utf8');
      
      // Manage checkpoint files (keep only the most recent ones)
      this.pruneCheckpoints();
    } catch (error) {
      console.error(`Error saving checkpoint: ${error.message}`);
    }
  }
  
  /**
   * Keep only the most recent checkpoints
   */
  pruneCheckpoints() {
    try {
      // Get all checkpoint files
      const files = fs.readdirSync(this.checkpointDir)
        .filter(file => file.startsWith('ckpt_') && file.endsWith('.json'))
        .map(file => ({
          name: file,
          path: path.join(this.checkpointDir, file),
          time: fs.statSync(path.join(this.checkpointDir, file)).mtime.getTime()
        }))
        .sort((a, b) => b.time - a.time); // Sort by modification time (newest first)
      
      // Keep only the most recent checkpoints
      if (files.length > this.maxCheckpoints) {
        for (let i = this.maxCheckpoints; i < files.length; i++) {
          fs.unlinkSync(files[i].path);
        }
      }
    } catch (error) {
      console.error(`Error pruning checkpoints: ${error.message}`);
    }
  }
  
  /**
   * Get all available checkpoints
   * @returns {Array} Array of checkpoint objects
   */
  getCheckpoints() {
    try {
      // Get all checkpoint files
      const files = fs.readdirSync(this.checkpointDir)
        .filter(file => file.startsWith('ckpt_') && file.endsWith('.json'));
      
      // Load and parse each checkpoint
      const checkpoints = files.map(file => {
        try {
          const content = fs.readFileSync(path.join(this.checkpointDir, file), 'utf8');
          return JSON.parse(content);
        } catch (e) {
          console.error(`Error parsing checkpoint ${file}: ${e.message}`);
          return null;
        }
      }).filter(cp => cp !== null); // Remove any that failed to parse
      
      // Sort by timestamp (newest first)
      return checkpoints.sort((a, b) => {
        return new Date(b.timestamp) - new Date(a.timestamp);
      });
    } catch (error) {
      console.error(`Error getting checkpoints: ${error.message}`);
      return [];
    }
  }
  
  /**
   * Get a specific checkpoint by ID
   * @param {string} checkpointId - ID of checkpoint to retrieve
   * @returns {Object|null} Checkpoint object or null if not found
   */
  getCheckpoint(checkpointId) {
    try {
      const filePath = path.join(this.checkpointDir, `${checkpointId}.json`);
      
      if (fs.existsSync(filePath)) {
        const content = fs.readFileSync(filePath, 'utf8');
        return JSON.parse(content);
      }
      
      // If file doesn't exist, check all checkpoints
      const checkpoints = this.getCheckpoints();
      return checkpoints.find(cp => cp.id === checkpointId) || null;
    } catch (error) {
      console.error(`Error getting checkpoint ${checkpointId}: ${error.message}`);
      return null;
    }
  }
  
  /**
   * Get the latest checkpoint
   * @param {boolean} compactOnly - Whether to return only compact checkpoints
   * @returns {Object|null} Latest checkpoint or null if none exist
   */
  getLatestCheckpoint(compactOnly = false) {
    const checkpoints = this.getCheckpoints();
    
    if (compactOnly) {
      const compactCheckpoints = checkpoints.filter(cp => cp.isCompactCheckpoint);
      return compactCheckpoints.length > 0 ? compactCheckpoints[0] : null;
    }
    
    return checkpoints.length > 0 ? checkpoints[0] : null;
  }
  
  /**
   * Create a compact checkpoint from state
   * @param {Object} state - State object to checkpoint
   * @returns {Object} Created checkpoint
   */
  createCompactCheckpoint(state) {
    return this.createCheckpoint(state, 'compact');
  }
  
  /**
   * Get checkpoint data summary
   * @returns {Object} Summary of checkpoint data
   */
  getCheckpointSummary() {
    const checkpoints = this.getCheckpoints();
    const compactCheckpoints = checkpoints.filter(cp => cp.isCompactCheckpoint);
    const latestCheckpoint = checkpoints.length > 0 ? checkpoints[0] : null;
    const latestCompactCheckpoint = compactCheckpoints.length > 0 ? compactCheckpoints[0] : null;
    
    return {
      totalCheckpoints: checkpoints.length,
      compactCheckpoints: compactCheckpoints.length,
      latestCheckpoint: latestCheckpoint ? {
        id: latestCheckpoint.id,
        timestamp: latestCheckpoint.timestamp,
        utilizationPercentage: latestCheckpoint.utilizationPercentage,
        isCompactCheckpoint: !!latestCheckpoint.isCompactCheckpoint
      } : null,
      latestCompactCheckpoint: latestCompactCheckpoint ? {
        id: latestCompactCheckpoint.id,
        timestamp: latestCompactCheckpoint.timestamp,
        utilizationPercentage: latestCompactCheckpoint.utilizationPercentage
      } : null
    };
  }
}

// Export the class
if (typeof module !== 'undefined' && module.exports) {
  module.exports = CheckpointManager;
}

// Example usage (for demonstration)
if (require.main === module) {
  // Create a checkpoint manager
  const manager = new CheckpointManager({
    checkpointDir: './example-checkpoints'
  });
  
  // Create a sample checkpoint
  const checkpoint = manager.createCheckpoint({
    utilizationPercentage: 45,
    tokens: 90000,
    maxTokens: 200000,
    thresholdStatus: 'normal',
    operations: [
      { type: 'USER_MEDIUM', tokens: 2200, timestamp: new Date().toISOString() },
      { type: 'ASSISTANT_MEDIUM', tokens: 4400, timestamp: new Date().toISOString() }
    ]
  });
  
  console.log("Created checkpoint:", checkpoint.id);
  
  // List checkpoints
  const checkpoints = manager.getCheckpoints();
  console.log("Available checkpoints:", checkpoints.length);
  
  // Get checkpoint summary
  const summary = manager.getCheckpointSummary();
  console.log("Checkpoint summary:", summary);
}