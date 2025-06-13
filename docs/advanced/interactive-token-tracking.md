# Interactive Token Tracking in Trinity Framework 2.0

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Introduction

Interactive token tracking is an advanced capability of the Trinity Framework 2.0 that enables real-time monitoring and management of context window utilization. This document provides detailed guidance on implementing, customizing, and optimizing token tracking in interactive Claude Code environments, with a focus on advanced techniques and integrations.

## Core Concepts

### Token Economy

Claude Code operates with a finite context window measured in tokens. Understanding how these tokens are consumed is essential for context management:

1. **Input Tokens**: Consumed by user messages, tool results, and system messages
2. **Output Tokens**: Consumed by assistant responses and tool usage
3. **Cumulative Utilization**: Combined total that fills the context window
4. **Token Decay**: Older tokens eventually "expire" from the context window through FIFO
5. **Operation Costs**: Different operations consume different amounts of tokens

### Token Budget Management

Managing a token budget involves understanding:

- **Maximum Capacity**: Typically 200,000 tokens for Claude 3.5 Sonnet
- **Current Utilization**: Percentage of tokens consumed
- **Remaining Capacity**: Estimated by operation type
- **Thresholds**: Key percentages that trigger actions
- **Checkpoints**: Serialized states at important utilization levels

## Advanced Token Tracking Implementation

### Interactive CLI Integration

The Context Management System provides a command-line interface that can be integrated into agent workflows:

```bash
# Basic context check with medium response
./run-context-check.sh check ASSISTANT_MEDIUM

# Check with custom operation types
./run-context-check.sh check USER_LARGE
./run-context-check.sh check TOOL_READ_SMALL

# Recovery check after context reset
./run-context-check.sh recovery

# Handle auto-compact confirmation
./run-context-check.sh compact yes  # or "no"

# Generate detailed report
./run-context-check.sh report json  # or "text"

# Reset tracking state
./run-context-check.sh reset
```

### Dynamic Operation Type Selection

Advanced implementation involves selecting appropriate operation types based on actual content:

```javascript
/**
 * Dynamically determine operation type based on content
 * @param {string} content - The message or response content
 * @param {string} category - 'user', 'assistant', or 'tool'
 * @returns {string} - Appropriate operation type
 */
function determineOperationType(content, category) {
  const length = content.length;
  const words = content.split(/\s+/).length;
  
  // Determine size based on word and character count
  let size;
  if (words < 100 || length < 500) {
    size = 'SMALL';
  } else if (words < 500 || length < 2500) {
    size = 'MEDIUM';
  } else {
    size = 'LARGE';
  }
  
  // Combine category and size
  if (category === 'tool' && size !== 'LARGE') {
    // For tool operations, check for specific types
    if (content.includes('file written') || content.includes('created successfully')) {
      return 'TOOL_WRITE';
    } else if (content.includes('edited successfully')) {
      return 'TOOL_EDIT';
    } else if (content.includes('Task complete')) {
      return 'TOOL_TASK';
    } else {
      return `TOOL_READ_${size}`;
    }
  } else {
    return `${category.toUpperCase()}_${size}`;
  }
}
```

### Custom Threshold Management

Advanced implementations can customize thresholds for different operational needs:

```javascript
// Conservative thresholds for critical applications
const conservativeThresholds = {
  notice: 0.55,    // 55%
  warning: 0.65,   // 65%
  alert: 0.75      // 75%
};

// Standard thresholds
const standardThresholds = {
  notice: 0.65,    // 65%
  warning: 0.75,   // 75%
  alert: 0.85      // 85%
};

// Aggressive thresholds for maximum utilization
const aggressiveThresholds = {
  notice: 0.75,    // 75%
  warning: 0.85,   // 85%
  alert: 0.92      // 92%
};

// Initialize context tracker with custom thresholds
const tracker = new ContextTracker({
  thresholds: process.env.RISK_TOLERANCE === 'low' ? 
    conservativeThresholds : 
    (process.env.RISK_TOLERANCE === 'high' ? 
      aggressiveThresholds : 
      standardThresholds)
});
```

### Advanced Visualization Customization

The visualization system can be customized for different environments and preferences:

```javascript
// Custom visualization with color support
const visualizer = new ContextVisualization({
  meterSegments: 30,                // More granular meter
  colorSupport: true,               // Enable color (for terminals)
  characters: {                     // Custom characters
    filled: '█',                    // Solid block
    empty: '▒'                      // Lighter block
  },
  thresholds: {                     // Custom thresholds
    notice: 0.60,
    warning: 0.70,
    alert: 0.80
  }
});

// Generate color-coded meter
function createColorMeter(percentage) {
  // Determine color based on percentage
  let color;
  if (percentage >= 80) {
    color = '\x1b[31m'; // Red
  } else if (percentage >= 70) {
    color = '\x1b[33m'; // Yellow
  } else if (percentage >= 60) {
    color = '\x1b[36m'; // Cyan
  } else {
    color = '\x1b[32m'; // Green
  }
  
  // Calculate filled segments
  const filledSegments = Math.round((percentage / 100) * 30);
  const emptySegments = 30 - filledSegments;
  
  // Create meter bar with color
  const filledPart = color + '█'.repeat(filledSegments);
  const emptyPart = '▒'.repeat(emptySegments) + '\x1b[0m';
  const meterBar = filledPart + emptyPart;
  
  return `[Context: ${percentage}% ${meterBar}]`;
}
```

## Advanced Integration Patterns

### 1. Automated Checkpoint Management

Implement automatic checkpoint creation based on custom criteria:

```javascript
// Checkpoint creation for significant content
function createContentBasedCheckpoint(content, tracker) {
  // Define keywords that indicate significant content
  const significantKeywords = [
    'completed', 'implemented', 'resolved', 'fixed', 'deployed',
    'designed', 'created', 'analyzed', 'optimized'
  ];
  
  // Check if content contains significant keywords
  const hasSignificantContent = significantKeywords.some(keyword => 
    content.toLowerCase().includes(keyword)
  );
  
  // Create checkpoint if content is significant
  if (hasSignificantContent) {
    const checkpoint = tracker.createCheckpoint('content');
    console.log(`Created content-based checkpoint: ${checkpoint.id}`);
  }
}
```

### 2. Predictive Token Management

Implement predictive token management to optimize context usage:

```javascript
// Predictive token management
function predictContextUtilization(tracker, plannedOperations) {
  let predictedUtilization = tracker.getCurrentUtilization();
  
  // Calculate predicted utilization after planned operations
  for (const operation of plannedOperations) {
    const tokenEstimate = tracker.getOperationTokens(operation.type);
    predictedUtilization += tokenEstimate / tracker.maxTokens * 100;
  }
  
  // Return recommendation based on prediction
  if (predictedUtilization > 85) {
    return {
      recommendation: 'COMPACT',
      message: 'Predicted utilization will exceed alert threshold. Recommend compact now.',
      predictedUtilization
    };
  } else if (predictedUtilization > 75) {
    return {
      recommendation: 'OPTIMIZE',
      message: 'Predicted utilization will reach warning threshold. Recommend optimizing operations.',
      predictedUtilization
    };
  } else {
    return {
      recommendation: 'PROCEED',
      message: 'Predicted utilization within acceptable range.',
      predictedUtilization
    };
  }
}
```

### 3. Token Usage Analytics

Implement analytics to understand token usage patterns:

```javascript
// Token usage analytics
function generateTokenAnalytics(tracker) {
  const operations = tracker.getOperationHistory();
  
  // Count operations by type
  const typeCounts = {};
  operations.forEach(op => {
    typeCounts[op.type] = (typeCounts[op.type] || 0) + 1;
  });
  
  // Calculate token usage by type
  const typeTokens = {};
  Object.keys(typeCounts).forEach(type => {
    typeTokens[type] = typeCounts[type] * tracker.getOperationTokens(type);
  });
  
  // Calculate percentages
  const totalTokens = Object.values(typeTokens).reduce((sum, val) => sum + val, 0);
  const typePercentages = {};
  Object.keys(typeTokens).forEach(type => {
    typePercentages[type] = (typeTokens[type] / totalTokens * 100).toFixed(1) + '%';
  });
  
  return {
    operationCounts: typeCounts,
    tokenUsage: typeTokens,
    percentages: typePercentages,
    totalTokens
  };
}
```

### 4. Adaptive Thresholds

Implement adaptive thresholds based on operational patterns:

```javascript
// Adaptive threshold management
function adaptThresholds(tracker) {
  const history = tracker.getOperationHistory();
  const recentOperations = history.slice(-20); // Last 20 operations
  
  // Calculate average token consumption per operation
  const totalTokens = recentOperations.reduce((sum, op) => 
    sum + tracker.getOperationTokens(op.type), 0);
  const averageTokens = totalTokens / recentOperations.length;
  
  // Calculate standard deviation
  const variance = recentOperations.reduce((sum, op) => {
    const diff = tracker.getOperationTokens(op.type) - averageTokens;
    return sum + diff * diff;
  }, 0) / recentOperations.length;
  const stdDev = Math.sqrt(variance);
  
  // Adjust thresholds based on operation patterns
  let alertThreshold = 0.85; // Default
  
  // If operations have high variance, use more conservative thresholds
  if (stdDev > averageTokens * 0.5) {
    alertThreshold = 0.80;
  }
  // If operations have low variance, can use more aggressive thresholds
  else if (stdDev < averageTokens * 0.2) {
    alertThreshold = 0.88;
  }
  
  // Calculate derived thresholds
  const warningThreshold = alertThreshold - 0.10;
  const noticeThreshold = warningThreshold - 0.10;
  
  return {
    notice: noticeThreshold,
    warning: warningThreshold,
    alert: alertThreshold
  };
}
```

## Integration with Agent Workflows

### 1. Automated Response Enhancement

Automatically include context tracking at the end of responses:

```javascript
/**
 * Enhance response with context tracking information
 * @param {string} response - Original response text
 * @param {string} operationType - Operation type for context update
 * @returns {string} - Enhanced response with context information
 */
async function enhanceResponseWithContext(response, operationType) {
  // Update context with operation
  const contextStatus = await updateContext(operationType);
  
  // Get context visualization
  const contextVisualization = getContextVisualization(contextStatus);
  
  // Add to response
  return `${response}\n\n${contextVisualization}`;
}
```

### 2. Proactive Compact Planning

Implement proactive context management to avoid unexpected resets:

```javascript
/**
 * Suggest proactive compact based on planned operations
 * @param {Array} plannedOperations - List of planned operations
 * @returns {boolean} - Whether compact is recommended
 */
function suggestProactiveCompact(plannedOperations) {
  // Get current utilization
  const currentUtilization = tracker.getCurrentUtilization();
  
  // Calculate total tokens for planned operations
  const totalPlannedTokens = plannedOperations.reduce(
    (sum, op) => sum + tracker.getOperationTokens(op.type), 0
  );
  
  // Calculate predicted utilization
  const predictedUtilization = currentUtilization + 
    (totalPlannedTokens / tracker.maxTokens * 100);
  
  // Recommend compact if approaching alert threshold
  if (predictedUtilization > 80) {
    console.log(`Current: ${currentUtilization}%, Predicted: ${predictedUtilization}%`);
    console.log('Proactive compact recommended before proceeding with planned operations');
    return true;
  }
  
  return false;
}
```

### 3. Content-Aware Operation Type Selection

Select operation types based on content analysis:

```javascript
/**
 * Select appropriate operation type based on content analysis
 * @param {string} content - Content to analyze
 * @param {string} category - Base category (USER, ASSISTANT, TOOL)
 * @returns {string} - Selected operation type
 */
function selectOperationType(content, category) {
  // Analyze content complexity
  const complexity = analyzeComplexity(content);
  
  // Select size based on complexity
  let size;
  switch (complexity) {
    case 'high':
      size = 'LARGE';
      break;
    case 'medium':
      size = 'MEDIUM';
      break;
    default:
      size = 'SMALL';
  }
  
  // Combine category and size
  return `${category}_${size}`;
}

/**
 * Analyze content complexity
 * @param {string} content - Content to analyze
 * @returns {string} - Complexity level: 'low', 'medium', or 'high'
 */
function analyzeComplexity(content) {
  // Character count
  const charCount = content.length;
  
  // Word count
  const wordCount = content.split(/\s+/).length;
  
  // Code block detection
  const codeBlockCount = (content.match(/```/g) || []).length / 2;
  
  // Calculate complexity score
  let complexityScore = 0;
  
  // Character count factor
  if (charCount > 5000) complexityScore += 3;
  else if (charCount > 1500) complexityScore += 2;
  else if (charCount > 500) complexityScore += 1;
  
  // Word count factor
  if (wordCount > 800) complexityScore += 3;
  else if (wordCount > 250) complexityScore += 2;
  else if (wordCount > 80) complexityScore += 1;
  
  // Code block factor
  complexityScore += codeBlockCount;
  
  // Determine complexity level
  if (complexityScore >= 5) return 'high';
  if (complexityScore >= 2) return 'medium';
  return 'low';
}
```

## Advanced Checkpoint Management

### 1. Categorized Checkpoints

Implement categorized checkpoints for better organization:

```javascript
/**
 * Create categorized checkpoint
 * @param {string} category - Checkpoint category
 * @param {string} description - Checkpoint description
 * @returns {Object} - Created checkpoint info
 */
function createCategorizedCheckpoint(category, description) {
  // Generate timestamp
  const timestamp = new Date().toISOString();
  
  // Generate ID with category
  const id = `ckpt_${category}_${timestamp.replace(/[:.]/g, '')}`;
  
  // Get current utilization
  const utilizationPercentage = tracker.getCurrentUtilization();
  
  // Determine threshold status
  let thresholdStatus = 'NORMAL';
  if (utilizationPercentage >= 85) thresholdStatus = 'ALERT';
  else if (utilizationPercentage >= 75) thresholdStatus = 'WARNING';
  else if (utilizationPercentage >= 65) thresholdStatus = 'NOTICE';
  
  // Create checkpoint object
  const checkpoint = {
    id,
    timestamp,
    utilizationPercentage,
    thresholdStatus,
    category,
    description
  };
  
  // Save checkpoint to file
  saveCheckpoint(checkpoint);
  
  return checkpoint;
}
```

### 2. Checkpoint Tagging System

Implement tags for better checkpoint organization:

```javascript
/**
 * Create tagged checkpoint
 * @param {string} primaryTag - Primary tag for the checkpoint
 * @param {Array<string>} additionalTags - Additional tags
 * @param {string} description - Checkpoint description
 * @returns {Object} - Created checkpoint
 */
function createTaggedCheckpoint(primaryTag, additionalTags, description) {
  const timestamp = new Date().toISOString();
  const utilizationPercentage = tracker.getCurrentUtilization();
  
  // Create tag string
  const tagString = [primaryTag, ...additionalTags].join('_');
  
  // Create ID with tags
  const id = `ckpt_${tagString}_${timestamp.replace(/[:.]/g, '')}`;
  
  // Determine threshold status
  let thresholdStatus = 'NORMAL';
  if (utilizationPercentage >= 85) thresholdStatus = 'ALERT';
  else if (utilizationPercentage >= 75) thresholdStatus = 'WARNING';
  else if (utilizationPercentage >= 65) thresholdStatus = 'NOTICE';
  
  // Create checkpoint with tags
  const checkpoint = {
    id,
    timestamp,
    utilizationPercentage,
    thresholdStatus,
    tags: [primaryTag, ...additionalTags],
    description
  };
  
  // Save checkpoint
  saveCheckpoint(checkpoint);
  
  return checkpoint;
}
```

### 3. Checkpoint Selection Strategy

Implement strategies for selecting optimal checkpoints for recovery:

```javascript
/**
 * Select optimal checkpoint for recovery
 * @param {Array} availableCheckpoints - Available checkpoints
 * @param {Object} criteria - Selection criteria
 * @returns {Object} - Selected checkpoint
 */
function selectOptimalCheckpoint(availableCheckpoints, criteria = {}) {
  // Default to most recent if no criteria
  if (!criteria || Object.keys(criteria).length === 0) {
    return availableCheckpoints.sort((a, b) => 
      new Date(b.timestamp) - new Date(a.timestamp)
    )[0];
  }
  
  // Filter by category if specified
  let candidates = availableCheckpoints;
  if (criteria.category) {
    candidates = candidates.filter(cp => cp.category === criteria.category);
  }
  
  // Filter by tags if specified
  if (criteria.tags && criteria.tags.length > 0) {
    candidates = candidates.filter(cp => 
      criteria.tags.some(tag => cp.tags && cp.tags.includes(tag))
    );
  }
  
  // Filter by maximum utilization if specified
  if (criteria.maxUtilization) {
    candidates = candidates.filter(cp => 
      cp.utilizationPercentage <= criteria.maxUtilization
    );
  }
  
  // Sort by recency if no specific sorting criteria
  if (!criteria.sortBy) {
    return candidates.sort((a, b) => 
      new Date(b.timestamp) - new Date(a.timestamp)
    )[0];
  }
  
  // Sort by specified criteria
  switch (criteria.sortBy) {
    case 'utilization':
      // Sort by utilization (lowest first)
      return candidates.sort((a, b) => 
        a.utilizationPercentage - b.utilizationPercentage
      )[0];
    case 'threshold':
      // Sort by threshold status (preference order: NORMAL, NOTICE, WARNING, ALERT)
      const thresholdOrder = { 'NORMAL': 0, 'NOTICE': 1, 'WARNING': 2, 'ALERT': 3 };
      return candidates.sort((a, b) => 
        thresholdOrder[a.thresholdStatus] - thresholdOrder[b.thresholdStatus]
      )[0];
    default:
      // Default to recency
      return candidates.sort((a, b) => 
        new Date(b.timestamp) - new Date(a.timestamp)
      )[0];
  }
}
```

## Integration with Project Workflows

### 1. Status File Integration

Integrate token tracking into STATUS.md with enhanced information:

```markdown
## Context Health
- **Current Utilization**: 68% (NOTICE)
- **Available Checkpoints**: 5
- **Last Checkpoint**: ckpt_milestone_completion_20250612171523 (NOTICE)
- **Checkpoint Categories**: project_start (1), milestone_completion (3), alert_auto (1)
- **Recent Operations**: 15 ASSISTANT, 12 USER, 8 TOOL
- **Estimated Remaining Capacity**: 
  - Large operations: ~5
  - Medium operations: ~14
  - Small operations: ~41
- **Last Context Check**: 2025-06-12 17:15:23
- **Recovery Status**: READY with 5 viable checkpoints

## Context Visualization
[Context: 68% ▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░] Remaining: ~41 small operations
```

### 2. Milestone-Based Checkpointing

Integrate checkpoints with project milestones:

```javascript
/**
 * Create milestone checkpoint
 * @param {string} milestoneName - Name of the completed milestone
 * @param {string} phaseId - ID of the current phase
 * @returns {Object} - Created checkpoint
 */
function createMilestoneCheckpoint(milestoneName, phaseId) {
  return createCategorizedCheckpoint(
    'milestone',
    `Completed milestone: ${milestoneName} (Phase: ${phaseId})`
  );
}
```

### 3. Context-Aware Workflow Planning

Plan workflows based on context utilization:

```javascript
/**
 * Generate context-aware workflow recommendations
 * @returns {Object} - Workflow recommendations
 */
function generateWorkflowRecommendations() {
  const utilization = tracker.getCurrentUtilization();
  
  // Define operation bundles with token costs
  const operationBundles = {
    'Documentation Update': {
      cost: 25000, // ~12.5% of context
      operations: [
        { type: 'ASSISTANT_MEDIUM', count: 2 },
        { type: 'TOOL_READ_MEDIUM', count: 3 },
        { type: 'TOOL_WRITE', count: 2 }
      ]
    },
    'Feature Development': {
      cost: 50000, // ~25% of context
      operations: [
        { type: 'ASSISTANT_MEDIUM', count: 4 },
        { type: 'TOOL_READ_LARGE', count: 2 },
        { type: 'TOOL_READ_MEDIUM', count: 5 },
        { type: 'TOOL_WRITE', count: 3 },
        { type: 'TOOL_EDIT', count: 4 }
      ]
    },
    'Code Review': {
      cost: 30000, // ~15% of context
      operations: [
        { type: 'ASSISTANT_LARGE', count: 1 },
        { type: 'TOOL_READ_MEDIUM', count: 4 },
        { type: 'TOOL_EDIT', count: 2 }
      ]
    },
    'Bug Fix': {
      cost: 20000, // ~10% of context
      operations: [
        { type: 'ASSISTANT_MEDIUM', count: 2 },
        { type: 'TOOL_READ_MEDIUM', count: 3 },
        { type: 'TOOL_EDIT', count: 2 }
      ]
    }
  };
  
  // Available tokens (with safety margin)
  const availableTokens = (0.95 - (utilization / 100)) * 200000;
  
  // Determine which bundles fit in available context
  const viableBundles = {};
  Object.entries(operationBundles).forEach(([name, bundle]) => {
    if (bundle.cost <= availableTokens) {
      viableBundles[name] = {
        ...bundle,
        viability: 'FULL',
        contextAfter: utilization + (bundle.cost / 2000)
      };
    } else if (bundle.cost <= availableTokens * 1.2) {
      viableBundles[name] = {
        ...bundle,
        viability: 'PARTIAL',
        contextAfter: utilization + (bundle.cost / 2000),
        note: 'May require compact during execution'
      };
    } else {
      viableBundles[name] = {
        ...bundle,
        viability: 'NOT_RECOMMENDED',
        contextAfter: 'EXCEEDS CAPACITY',
        note: 'Requires compact before starting'
      };
    }
  });
  
  return {
    currentUtilization: utilization,
    availableTokens,
    recommendations: viableBundles
  };
}
```

## Conclusion

Interactive token tracking provides powerful capabilities for managing context windows in Trinity Framework 2.0 implementations. By implementing the advanced techniques outlined in this document, developers can create sophisticated context management systems that optimize token usage, provide insightful visualizations, and enable smooth recovery from context limitations.

The optional Context Management System included in the Trinity Framework 2.0 Core serves as a reference implementation of these concepts, providing a foundation that can be customized and extended to meet specific project requirements.

---

*Framework 2.0 COMPLIANT*