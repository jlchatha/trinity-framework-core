# Context Management System

**Version**: 1.0.0  
**Framework**: Trinity Framework 2.0 Core  
**Status**: Optional Enhancement

## Overview

The Context Management System is an optional enhancement for Trinity Framework 2.0 that helps monitor token usage, manage checkpoints, and handle context resets with minimal user interaction. It provides text-based visualization of context utilization and automatic recovery after context resets.

## Installation

To add context tracking to your Trinity Framework 2.0 workspace:

1. **Create Required Directories**
```bash
mkdir -p tools/token-tracker/context-manager/bin
mkdir -p tools/token-tracker/context-manager/state
mkdir -p tools/token-tracker/context-manager/checkpoints
```

2. **Copy Implementation Files**
From the Framework 2.0 Core repository:
```bash
cp -r examples/context-tracking/token-counter.js tools/token-tracker/
cp -r examples/context-tracking/context-visualization.js tools/context-meter/
cp -r examples/context-tracking/run-context-check.sh tools/token-tracker/context-manager/bin/
```

3. **Make Scripts Executable**
```bash
chmod +x tools/token-tracker/context-manager/bin/*.sh
```

4. **Update Protocol Files**

Add to AGENT.md:
```markdown
## CONTEXT TRACKING PROTOCOL

After drafting responses, run the context tracking script:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM
```

Include the output at the end of your response:

```
[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YYY small operations
```
```

Add to AUTO-COMPACT.md:
```markdown
## Context Management Metrics
- **Last Updated**: [current timestamp]
- **Context Utilization**: [percentage]%
- **Token Count**: [current]/[maximum]
- **Checkpoint Status**: [Active/None]
- **Available Checkpoints**: [Number]
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Number]
  - Medium operations: ~[Number]
  - Small operations: ~[Number]
- **Last Context Check**: [Time]

## Context Visualization
[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

Add to STATUS.md:
```markdown
## Context Health
- **Current Utilization**: [Percentage]% ([Status])
- **Available Checkpoints**: [Count]
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Count]
  - Medium operations: ~[Count]
  - Small operations: ~[Count]

## Context Visualization
[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

## Key Features

### 1. Token Tracking
- Monitors token usage for different operation types
- Automatically estimates tokens based on operation complexity
- Tracks user messages, assistant responses, and tool operations

### 2. Threshold Monitoring
- Notice Threshold (65%): Creates checkpoint, displays notification
- Warning Threshold (75%): Creates checkpoint, alerts about limited remaining capacity
- Alert Threshold (85%): Offers auto-compact based on user preference

### 3. Checkpoint Management
- Creates checkpoints at threshold crossings
- Maintains checkpoint history
- Supports manual checkpoint creation

### 4. Auto-Compact Workflow
- User prompt-based or automatic
- Creates recovery checkpoint before compact
- Configurable user preferences

### 5. Post-Reset Recovery
- Automatic checkpoint restoration after reset
- Seamless continuation from previous state
- Clear recovery message

### 6. Context Visualization
- Text-based context meter
- Remaining capacity estimation
- Threshold status indication

## Usage Examples

### Basic Context Check
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check
```

### Specific Operation Type
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_LARGE
```

### Check for Recovery After Reset
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh recovery
```

### Handle Auto-Compact Response
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh compact yes
```

### Generate Context Report
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh report markdown
```

### Reset Context State
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh reset
```

## Integration with Framework

While context tracking is optional, it provides significant benefits for framework adopters:

1. **Context Resilience**: Better recovery from context resets
2. **Predictability**: Early warnings about context limitations
3. **Transparency**: Clear visualization of token usage
4. **Efficiency**: More effective use of context window

## Example Implementation

See the following files for a complete reference implementation:
- `examples/context-tracking/token-counter.js`: Token estimation and tracking
- `examples/context-tracking/context-visualization.js`: Text-based visualization
- `examples/context-tracking/run-context-check.sh`: Command-line interface

## Customization

The context tracking system can be customized to meet specific needs:
- Adjust thresholds in `token-counter.js`
- Modify visualization in `context-visualization.js`
- Add custom operation types with token estimates

---

*Framework 2.0 COMPLIANT*