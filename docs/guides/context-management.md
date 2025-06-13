# Context Management System

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

The Context Management System is an optional enhancement for Trinity Framework 2.0 Core that helps monitor token usage, manage context utilization, and handle recovery from context resets. This guide explains the system's components, implementation, and best practices.

## Why Context Management?

AI agents operating in text interfaces face context window limitations that can disrupt work when limits are reached. The Context Management System addresses these challenges by:

1. **Monitoring**: Tracking context utilization in real-time
2. **Visualization**: Providing clear visual indicators of context status
3. **Checkpointing**: Creating state snapshots at key thresholds
4. **Recovery**: Enabling smooth recovery after context resets

While optional, these capabilities significantly enhance agent resilience and operational continuity.

## System Components

The Context Management System consists of several integrated components:

### 1. Token Counter

Tracks token usage for different operations:

- User messages (small, medium, large)
- Assistant responses (small, medium, large)
- Tool operations (read, write, edit, task)

### 2. Context Meter

Visualizes context utilization with a text-based meter:

```
[Context: 25% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~100 small operations
```

### 3. Checkpoint Manager

Creates and manages state snapshots at threshold crossings:

- Notice threshold (65%): Early awareness
- Warning threshold (75%): Preparation point
- Alert threshold (85%): Critical threshold

### 4. Recovery System

Handles post-reset recovery:

- Detects when context has been reset
- Locates available checkpoints
- Restores state from checkpoint
- Updates protocol files

## Installation

The Context Management System is available as an optional enhancement for Trinity Framework 2.0 Core workspaces.

### Basic Installation

1. **Create Required Directories**:
   ```bash
   mkdir -p tools/token-tracker/context-manager/bin
   mkdir -p tools/token-tracker/context-manager/state
   mkdir -p tools/token-tracker/context-manager/checkpoints
   ```

2. **Create Basic Script**:
   Create `tools/token-tracker/context-manager/bin/run-context-check.sh`:

   ```bash
   #!/bin/bash
   
   # Run Context Check Script
   # 
   # Purpose: Convenience wrapper for context tracking scripts
   # 
   # Usage:
   #   ./run-context-check.sh [command] [args]
   #
   # Commands:
   #   check       Check context status and update (default)
   #   recovery    Check for recovery after reset
   #   compact     Handle auto-compact response
   #   report      Generate context tracking report
   #   reset       Reset context tracking state
   #
   # Version: 1.0.0
   # Framework: Trinity Framework 2.0
   
   echo "[Context: 10% ▓▓░░░░░░░░░░░░░░░░░░] Remaining: ~120 small operations"
   ```

3. **Make the Script Executable**:
   ```bash
   chmod +x tools/token-tracker/context-manager/bin/run-context-check.sh
   ```

### Advanced Installation

For a more sophisticated implementation:

1. **Copy Example Files**:
   ```bash
   # From the Trinity Framework 2.0 Core repository
   cp -r examples/context-tracking/* tools/token-tracker/
   ```

2. **Install Node.js Dependencies** (if using JavaScript implementation):
   ```bash
   cd tools/token-tracker
   npm install
   ```

3. **Configure Token Estimates**:
   Edit `tools/token-tracker/token-counter.js` to adjust token estimates for your use case.

### Protocol File Integration

Update your protocol files to include context management:

1. **AGENT.md**: Add the context tracking protocol section:
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

2. **AUTO-COMPACT.md**: Add context metrics section:
   ```markdown
   ## Context Management Metrics
   - **Last Updated**: [timestamp]
   - **Context Utilization**: [percentage]%
   - **Token Count**: [current]/[maximum]
   - **Checkpoint Status**: [status]
   - **Available Checkpoints**: [count]
   - **Estimated Remaining Capacity**: 
     - Large operations: ~[count]
     - Medium operations: ~[count]
     - Small operations: ~[count]
   - **Last Context Check**: [time]
   ```

3. **STATUS.md**: Add context health section:
   ```markdown
   ## Context Health (Optional)
   - **Current Utilization**: [percentage]% ([status])
   - **Available Checkpoints**: [count]
   - **Estimated Remaining Capacity**: 
     - Large operations: ~[count]
     - Medium operations: ~[count]
     - Small operations: ~[count]
   ```

## System Operation

### Standard Commands

The Context Management System provides several commands:

```bash
# Check context status
./tools/token-tracker/context-manager/bin/run-context-check.sh check [operation-type]

# Check for recovery after reset
./tools/token-tracker/context-manager/bin/run-context-check.sh recovery

# Handle auto-compact decision
./tools/token-tracker/context-manager/bin/run-context-check.sh compact [yes|no]

# Generate context report
./tools/token-tracker/context-manager/bin/run-context-check.sh report

# Reset tracking state
./tools/token-tracker/context-manager/bin/run-context-check.sh reset
```

### Operation Types

When checking context, specify the operation type for accurate tracking:

| Operation | Description | Token Estimate |
|-----------|-------------|----------------|
| USER_SMALL | Small user message | ~750 tokens |
| USER_MEDIUM | Medium user message | ~2200 tokens |
| USER_LARGE | Large user message | ~4400 tokens |
| ASSISTANT_SMALL | Small response | ~1500 tokens |
| ASSISTANT_MEDIUM | Medium response | ~4400 tokens |
| ASSISTANT_LARGE | Large response | ~10000 tokens |
| TOOL_READ_SMALL | Small file read | ~1500 tokens |
| TOOL_READ_MEDIUM | Medium file read | ~4400 tokens |
| TOOL_READ_LARGE | Large file read | ~7500 tokens |
| TOOL_WRITE | File writing | ~750 tokens |
| TOOL_EDIT | File editing | ~1500 tokens |
| TOOL_TASK | Task execution | ~6000 tokens |

Example usage:
```bash
# After a medium-sized response
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM

# After a large file read
./tools/token-tracker/context-manager/bin/run-context-check.sh check TOOL_READ_LARGE
```

### Threshold Behavior

The system responds differently at each threshold:

#### Notice Threshold (65%)
```
[Context: 65% ▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░] NOTICE Remaining: ~47 small operations
NOTICE: Checkpoint created automatically
```

#### Warning Threshold (75%)
```
[Context: 75% ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░] WARNING Remaining: ~33 small operations
WARNING: High context utilization. Consider completing current task before starting new complex operations.
```

#### Alert Threshold (85%)
```
[Context: 85% ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░] ALERT Remaining: ~20 small operations
ALERT: Critical context utilization. Creating checkpoint for recovery.
Would you like to perform auto-compact now? (yes/no)
```

## Checkpoint Management

### Automatic Checkpoint Creation

The system automatically creates checkpoints at threshold crossings:

1. **Notice Checkpoint** (65%): Early awareness point
2. **Warning Checkpoint** (75%): Preparation for potential reset
3. **Alert Checkpoint** (85%): Critical point before reset
4. **Compact Checkpoint**: Created immediately before auto-compact

### Manual Checkpoint Creation

Create checkpoints manually when needed:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh checkpoint [label]
```

### Checkpoint Storage

Checkpoints are stored in the `/tools/token-tracker/context-manager/checkpoints/` directory with JSON format:

```json
{
  "id": "ckpt_notice_20250612164500000",
  "timestamp": "2025-06-12T16:45:00.000Z",
  "utilizationPercentage": 65,
  "type": "notice",
  "label": null,
  "state": {
    "contextManagement": {
      "tokenCounter": {
        "totalTokens": 130000,
        "maxTokens": 200000,
        "operations": [...],
        "lastCheck": "2025-06-12T16:45:00.000Z"
      }
    }
  }
}
```

## Recovery Process

### Automatic Recovery

After a context reset:

1. The recovery system detects the reset
2. The system locates the most recent checkpoint
3. State is restored from the checkpoint
4. A recovery message is displayed:

```
Restored from checkpoint ckpt_warning_20250612 (context: 75%).
Currently implementing [current task].
```

### Manual Recovery

To manually trigger recovery:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh recovery
```

## Protocol File Updates

### Automatic Updates

The system automatically updates protocol files:

1. **STATUS.md**: Updated with current context health information
2. **AUTO-COMPACT.md**: Updated with context metrics and checkpoint data

### Manual Updates

To manually update protocol files:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh update
```

## Best Practices

### Effective Context Management

1. **Regular Tracking**: Check context after every significant operation
2. **Proactive Checkpointing**: Create manual checkpoints before risky operations
3. **Threshold Awareness**: Pay attention to threshold notifications
4. **Operation Sizing**: Prefer smaller operations as context fills
5. **Context Visualization**: Include context meter in responses

### Token Usage Optimization

1. **Minimize Large Operations**: Split large operations when context is high
2. **Response Size Control**: Adjust response verbosity based on context
3. **Tool Efficiency**: Use efficient tool calls to reduce token usage
4. **Token-Heavy Task Timing**: Schedule token-heavy tasks after resets
5. **Checkpoint Management**: Create checkpoints before token-intensive operations

### Recovery Enhancement

1. **Detailed Protocol Files**: Keep protocol files detailed and current
2. **Project State Documentation**: Document current projects clearly in STATUS.md
3. **Task Continuity**: Break work into resumable chunks
4. **Explicit Next Steps**: Always document specific next steps
5. **AAR Documentation**: Create session AARs to aid recovery

## Customization

### Token Estimation Adjustment

Adjust token estimates in `token-counter.js` to match your actual usage patterns:

```javascript
const TOKEN_ESTIMATES = {
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
```

### Threshold Adjustment

Modify thresholds in `context-tracker.js` to match your risk tolerance:

```javascript
this.thresholds = {
  notice: options.noticeThreshold || 0.65, // 65%
  warning: options.warningThreshold || 0.75, // 75%
  alert: options.alertThreshold || 0.85 // 85%
};
```

### Visualization Customization

Customize visualization in `context-visualization.js`:

```javascript
createContextMeter(utilizationPercentage, remainingCapacity) {
  // Customization code here
}
```

## Advanced Topics

### Auto-Compact Response Handling

When context reaches the alert threshold (85%), the system prompts for auto-compact:

```
ALERT: Critical context utilization. Creating checkpoint for recovery.
Would you like to perform auto-compact now? (yes/no)
```

To respond:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh compact yes
# or
./tools/token-tracker/context-manager/bin/run-context-check.sh compact no
```

### Context Reporting

Generate comprehensive reports on context usage:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh report
```

Reports include:
- Token usage over time
- Operation distribution
- Checkpoint history
- Threshold crossings
- Recovery events

### Multiple Agent Integration

When using multiple agents with context management:

1. Implement context tracking in all agents
2. Use consistent token estimates across agents
3. Standardize context visualization formats
4. Share checkpoint naming conventions

## Troubleshooting

### Common Issues

#### Context Tracking Not Working

**Symptoms**:
- No context meter displayed
- No checkpoints being created
- No threshold notifications

**Solutions**:
- Ensure scripts are executable (`chmod +x *.sh`)
- Verify directory structure is correct
- Check for Node.js installation if using JavaScript implementation

#### Checkpoint Loading Failures

**Symptoms**:
- "Checkpoint not found" errors
- Incomplete state restoration
- Missing checkpoint files

**Solutions**:
- Check checkpoint directory permissions
- Verify checkpoint file format
- Ensure checkpoint IDs match between references

#### Protocol File Update Issues

**Symptoms**:
- Protocol files not updating with context information
- Inconsistent metrics between files
- Format errors in protocol files

**Solutions**:
- Check file permissions
- Verify protocol updater functionality
- Restore from templates if files become corrupted

## Implementation Examples

### Basic Context Check

After every response, check context:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM
```

Include the output in your response:

```
[Context: 45% ▓▓▓▓▓▓▓▓▓░░░░░░░░░░░] Remaining: ~73 small operations
```

### Manual Checkpoint Creation

Before a complex operation:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh checkpoint "before-complex-analysis"
```

### Post-Compact Recovery

After a context reset:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh recovery
```

Include the recovery message:

```
Restored from checkpoint ckpt_warning_20250612 (context: 75%).
```

## Conclusion

The Context Management System provides significant benefits for Trinity Framework 2.0 Core implementations:

- **Enhanced Resilience**: Better handling of context limitations
- **Improved Awareness**: Clear visualization of context utilization
- **Smoother Recovery**: Reduced disruption from context resets
- **Operational Continuity**: Maintained productivity across resets

While optional, implementing context management is highly recommended for all production environments where context reset resilience is important.

For detailed implementation instructions, see the [Auto-Compact Recovery Guide](./auto-compact-recovery.md).

---

*Framework 2.0 COMPLIANT*