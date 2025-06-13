# Context Management System

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft - Optional Component  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Introduction

The Context Management System is an optional enhancement to Trinity Framework 2.0 Core that provides token tracking, visualization, and auto-compact management capabilities. This system helps improve operational continuity across context resets and provides standardized context monitoring for agents that choose to implement it.

## Installation

For information on installing and enabling the optional Context Management System, see the README file in the tools/context-meter directory.

## System Purpose

The Context Management System addresses several fundamental challenges in large language model agent development:

1. **Context Window Limitations**: LLMs have finite context windows that can fill up during operation
2. **Unexpected Resets**: Context resets can occur without warning, causing operational disruption
3. **Inconsistent Recovery**: Without standardized recovery, agents recover inconsistently
4. **Context Blindness**: Agents typically can't "see" their own context utilization
5. **Recovery Complexity**: Manual recovery processes are error-prone and inconsistent

## Core Components

### 1. Token Tracking

The token tracking component monitors context utilization by estimating token usage for different operation types:

#### Operation Types

**User Messages**:
- USER_SMALL: Brief messages (~750 tokens)
- USER_MEDIUM: Standard messages (~2200 tokens)
- USER_LARGE: Detailed messages (~4400 tokens)

**Assistant Responses**:
- ASSISTANT_SMALL: Brief responses (~1500 tokens)
- ASSISTANT_MEDIUM: Standard responses (~4400 tokens)
- ASSISTANT_LARGE: Detailed responses (~10000 tokens)

**Tool Operations**:
- TOOL_READ_SMALL: Small file reads (~1500 tokens)
- TOOL_READ_MEDIUM: Medium file reads (~4400 tokens)
- TOOL_READ_LARGE: Large file reads (~7500 tokens)
- TOOL_WRITE: File writing operations (~750 tokens)
- TOOL_EDIT: File editing operations (~1500 tokens)
- TOOL_TASK: Task tool executions (~6000 tokens)

#### Token Estimation

Token estimation is based on standardized values for different operation types, with adjustments based on content length when available.

```javascript
// Example token estimation function
function estimateTokens(operationType, content) {
  // Get base token estimate from operation type
  let tokens = TOKEN_ESTIMATES[operationType] || TOKEN_ESTIMATES.ASSISTANT_MEDIUM;
  
  // If content is provided, refine estimate based on content
  if (content) {
    // For text content, estimate based on character count
    const charCount = content.length;
    const wordCount = content.split(/\s+/).length;
    
    // Approximate token count (4 chars per token or 0.75 tokens per word)
    const charBasedEstimate = Math.ceil(charCount / 4);
    const wordBasedEstimate = Math.ceil(wordCount * 0.75);
    
    // Use the average of character and word based estimates
    tokens = Math.ceil((charBasedEstimate + wordBasedEstimate) / 2);
  }
  
  return tokens;
}
```

### 2. Checkpoint Management

The checkpoint system creates serialized state snapshots at key thresholds:

#### Checkpoint Creation

Checkpoints are automatically created:
- At the Notice threshold (65%)
- At the Warning threshold (75%)
- At the Alert threshold (85%)
- When explicitly requested by the user or system

#### Checkpoint Content

Each checkpoint contains:
- Unique identifier
- Timestamp
- Utilization percentage
- Threshold status
- Recent operations list

### 3. Context Visualization

The visualization system provides a text-based representation of context utilization:

```
[Context: XX% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

This visualization shows:
1. Current utilization percentage
2. Visual progress bar (20 segments)
3. Estimated remaining capacity in small operations

#### Threshold Notifications

The system implements three key thresholds with corresponding notifications:

1. **Notice (65%)**:
   - Creates checkpoint automatically
   - Displays: "NOTICE: Checkpoint created automatically"
   - Normal operations continue

2. **Warning (75%)**:
   - Creates checkpoint automatically
   - Displays: "WARNING: High context utilization detected"
   - Recommends completing current task before starting complex operations

3. **Alert (85%)**:
   - Creates special compact checkpoint
   - Displays: "ALERT: Critical context utilization reached"
   - Prompts user for auto-compact decision

### 4. Recovery System

The recovery system handles post-reset context restoration:

#### Auto-Compact Flow

1. System creates checkpoint at 85% threshold
2. User is prompted for auto-compact decision
3. If confirmed, system prepares for recovery
4. After reset, system detects reset state
5. System restores from last checkpoint
6. Context utilization resets to 25%
7. Recovery notification displays previous state

#### Recovery Display

```
[RECOVERY COMPLETE]
Restored from checkpoint: ckpt_warning_20250612234452287
Previous context: 78% → Current context: 25%
Implementation state: [Current implementation state]

[Context: 25% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~150 small operations
```

## Implementation Requirements

### Command Line Interface

The context management system should implement a standardized command-line interface:

```bash
# Check context status and update with operation type
./run-context-check.sh check [type]

# Check for recovery after auto-compact
./run-context-check.sh recovery

# Handle auto-compact response
./run-context-check.sh compact [yes|no]

# Generate context tracking report
./run-context-check.sh report [format]

# Reset tracking state
./run-context-check.sh reset
```

### Directory Structure

Standard implementation should follow this directory structure:

```
/tools/token-tracker/context-manager/
├── bin/
│   ├── run-context-check.sh
│   ├── update-and-display.js
│   ├── check-recovery.js
│   ├── handle-auto-compact.js
│   └── generate-report.js
├── context-visualization.js
├── state/
│   └── context-state.json
└── checkpoints/
    └── ckpt_*.json
```

### Protocol File Integration

If you implement the Context Management System, the following protocol file integrations are recommended:

1. **AGENT.md**: Add an Optional Context Tracking Protocol section
2. **AUTO-COMPACT.md**: Add a Context Management Metrics section
3. **STATUS.md**: Add a Context Health section with visualization

#### Example Protocol File Content

**AGENT.md Context Tracking Section:**
```markdown
## OPTIONAL CONTEXT TRACKING PROTOCOL

**ENHANCEMENT: For improved context management, consider implementing context tracking**

If you've installed the optional context tracking system, after drafting responses you can run:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Or appropriate operation type
```

You can then include the output at the end of your response in this format:

```
[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YYY small operations
```

Context tracking is an optional enhancement to Framework 2.0 that helps monitor token usage and manage context windows more effectively.
```

**AUTO-COMPACT.md Context Metrics Section:**
```markdown
## Context Management Metrics (Optional)
- **Last Updated**: [Timestamp]
- **Context Utilization**: [Percentage]%
- **Token Count**: [Current]/[Maximum]
- **Checkpoint Status**: [Active/None]
- **Available Checkpoints**: [Number]
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Number]
  - Medium operations: ~[Number]
  - Small operations: ~[Number]
- **Last Context Check**: [Time]
```

**STATUS.md Context Health Section:**
```markdown
## Context Health (Optional)
<!-- This section is only needed if you're using the optional context tracking system -->
- **Current Utilization**: [Percentage]% ([Status])
- **Available Checkpoints**: [Count]
- **Last Checkpoint**: [ID] ([Type])
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Count]
  - Medium operations: ~[Count]
  - Small operations: ~[Count]

## Context Visualization (Optional)
<!-- Include this section only if context tracking is implemented -->
[Context: XX% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

## Implementation Example

### Basic Usage

```javascript
// Load the context tracking module
const ContextTracker = require('./context-tracker');

// Initialize the context tracker
const tracker = new ContextTracker();

// Update context with an operation
tracker.updateContext('ASSISTANT_MEDIUM');

// Get current context status
const status = tracker.getStatus();
console.log(`Context: ${status.utilizationPercentage}%`);
console.log(`Tokens: ${status.tokens}/${status.maxTokens}`);
console.log(`Threshold: ${status.thresholdStatus}`);

// Display context visualization
console.log(tracker.getVisualization());
```

### Checkpoint Creation

```javascript
// Create a checkpoint at current state
const checkpoint = tracker.createCheckpoint('manual');
console.log(`Created checkpoint: ${checkpoint.id}`);

// List available checkpoints
const checkpoints = tracker.getCheckpoints();
checkpoints.forEach(cp => {
  console.log(`${cp.id}: ${cp.utilizationPercentage}% (${cp.timestamp})`);
});
```

### Recovery Process

```javascript
// Check for recovery after reset
const recoveryResult = tracker.checkRecovery();

if (recoveryResult.recovered) {
  console.log(`Recovered from checkpoint: ${recoveryResult.checkpointId}`);
  console.log(`Previous utilization: ${recoveryResult.previousUtilization}%`);
  console.log(`Current utilization: ${recoveryResult.currentUtilization}%`);
} else {
  console.log('No recovery needed, continuing session.');
}
```

## Benefits

Implementing the Context Management System provides several key benefits:

1. **Enhanced Recovery**: Automatic checkpoint creation and restoration
2. **Context Awareness**: Real-time visibility of context utilization
3. **Standardized Monitoring**: Consistent token tracking across all agents
4. **Self-Management**: Proactive threshold notifications
5. **Performance Optimization**: Calibrated token estimates for different operations
6. **Operational Continuity**: Minimal disruption from context resets

## Implementation Guidelines

When implementing the Context Management System, follow these guidelines:

1. **Consistent Usage**: Execute context tracking after every response
2. **Appropriate Types**: Use the most accurate operation type for each action
3. **Regular Verification**: Check context visualization for accuracy
4. **Threshold Awareness**: Respond appropriately to threshold notifications
5. **Checkpoint Verification**: Regularly verify checkpoint creation and restoration
6. **Customization Limits**: Maintain core functionality when customizing

## Conclusion

The Context Management System is an optional enhancement to Trinity Framework 2.0 Core, providing valuable functionality for context resilience and operational continuity. By implementing this system according to the guidelines in this document, developers can create more robust agent applications that maintain effectiveness across context limitations. While not required, context tracking offers significant benefits for agents working in scenarios where context management is important.

---

*Framework 2.0 COMPLIANT*