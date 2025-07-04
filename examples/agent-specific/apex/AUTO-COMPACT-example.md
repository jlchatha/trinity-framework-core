# ⚠️ OPTIONAL CONTEXT TRACKING - APEX AGENT ⚠️

If context tracking system is installed, execute after EVERY response:
```bash
cd ~/workspace/trinity-apex-workspace/tools/context-management/bin
./run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

## Context Management Metrics
- **Last Updated**: YYYY-MM-DDThh:mm:ss.sssZ
- **Context Utilization**: 45%
- **Token Count**: 90000/200000
- **Checkpoint Status**: Active
- **Available Checkpoints**: 2
- **Estimated Remaining Capacity**: 
  - Large operations: ~12
  - Medium operations: ~24
  - Small operations: ~85
- **Last Context Check**: hh:mm:ss
- **Token Estimation**: Standard Framework 2.0 values (v1.0.0)
- **Checkpoint Data**: 
```json
[
  {
    "id": "ckpt_notice_YYYYMMDDHHMMSS",
    "timestamp": "YYYY-MM-DDThh:mm:ss.sssZ",
    "utilizationPercentage": 45,
    "thresholdStatus": "notice"
  }
]
```

## Checkpoint Restoration Instructions
1. After compact, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-compact message
4. Example: "Restored from checkpoint ckpt_notice_YYYYMMDDHHMMSS (context: 45%)"

## Context Management System Documentation

### Overview
The Context Management System monitors and manages context utilization, creates checkpoints at important thresholds, and provides reliable recovery after auto-compact events. The system is designed specifically for maintaining operational continuity across context resets.

### Implementation Status
- **Status**: OPTIONAL - Install if context management desired
- **Installation**: Run setup script from trinity-framework-core
- **Version**: 1.0.0
- **Maintenance**: Follow standard update procedures

### Components
1. **ContextTracker**: Monitors token usage and detects threshold crossings
2. **CheckpointManager**: Creates and manages serialized state checkpoints
3. **ProtocolUpdater**: Updates protocol files with context information
4. **RecoverySystem**: Handles post-compact recovery automatically
5. **ContextVisualization**: Provides text-based visualization of context status

### Operation Types
1. **User Messages**:
   - USER_SMALL: Brief messages (~750 tokens)
   - USER_MEDIUM: Standard messages (~2200 tokens)
   - USER_LARGE: Detailed messages (~4400 tokens)

2. **Assistant Responses**:
   - ASSISTANT_SMALL: Brief responses (~1500 tokens)
   - ASSISTANT_MEDIUM: Standard responses (~4400 tokens)
   - ASSISTANT_LARGE: Detailed responses (~10000 tokens)

3. **Tool Operations**:
   - TOOL_READ_SMALL: Small file reads (~1500 tokens)
   - TOOL_READ_MEDIUM: Medium file reads (~4400 tokens)
   - TOOL_READ_LARGE: Large file reads (~7500 tokens)
   - TOOL_WRITE: File writing operations (~750 tokens)
   - TOOL_EDIT: File editing operations (~1500 tokens)
   - TOOL_TASK: Task tool executions (~6000 tokens)

### Standard Command Reference
```bash
# Check context status
./run-context-check.sh check [type]

# Check for recovery after compact
./run-context-check.sh recovery

# Handle auto-compact response
./run-context-check.sh compact [yes|no]

# Generate report
./run-context-check.sh report [format]

# Reset tracking state
./run-context-check.sh reset
```

## User Experience Notes
- Users will be informed at 85% context utilization
- Auto-compact will only proceed with user confirmation
- After auto-compact, normal operation resumes with minimal disruption
- Regular checkpoint creation ensures optimal recovery

## Context Visualization
[Context: 45% ▓▓▓▓▓▓▓▓▓░░░░░░░░░░░] Remaining: ~85 small operations

---

*Framework 2.0 COMPLIANT*