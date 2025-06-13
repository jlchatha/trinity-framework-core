## ⚠️ MANDATORY CONTEXT TRACKING - ALL AGENTS - FRAMEWORK 2.0 REQUIREMENT ⚠️

Execute after EVERY response:
```bash
cd /home/alreadyinuse/git/trinity-historian-workspace/tools/token-tracker/context-manager-v2/bin
./run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is a CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT. All agents must implement context tracking with every response.

## Context Management Metrics
- **Last Updated**: 2025-06-13 13:45:00
- **Context Utilization**: 90%
- **Token Count**: 180000/200000
- **Checkpoint Status**: ALERT
- **Available Checkpoints**: 1
- **Estimated Remaining Capacity**: 
  - Large operations: ~2
  - Medium operations: ~4
  - Small operations: ~13
- **Last Context Check**: 2025-06-13 13:45:00
- **Token Estimation**: Standard Framework 2.0 values
- **Checkpoint Data**: 
```json
[
  {
    "id": "ckpt_alert_20250613_1",
    "timestamp": "2025-06-13T13:45:00.000Z",
    "utilization": 90,
    "tokenCount": 180000,
    "description": "HTML documentation structure implementation completed",
    "type": "ALERT"
  }
]
```

## Checkpoint Restoration Instructions
1. After compact, Claude Code MUST check for checkpoint data
2. If checkpoint data exists, agent MUST load checkpoint state
3. Checkpoint restoration MUST be acknowledged in first post-compact message
4. Example: "Restored from checkpoint ckpt_alert_20250613_1 (context: 90%)"

## Context Management System Documentation

### Overview
The Context Management System monitors and manages Claude Code's context utilization, creates checkpoints at important thresholds, and provides reliable recovery after auto-compact events. The system is designed specifically for Claude Code Interactive Mode to maintain operational continuity across context resets.

### Implementation Status
- **Status**: FULLY IMPLEMENTED to all agents post-compact
- **Deployment**: All Trinity Framework 2.0 agents must implement
- **Framework 2.0 Requirement**: Mandatory for compliance
- **Version**: 1.0.0
- **Maintenance Responsibility**: OVERSEER with implementation support for all agents

### Current Implementation Context
- HTML documentation deployed to GitHub Pages successfully
- Fixed all 404 errors by creating missing HTML documentation pages
- Added comprehensive principles, guides, reference, and advanced documentation
- Created interactive visualizations for token tracking documentation
- Implemented consistent styling and navigation across all pages
- Added cross-references between all documentation pages
- Updated STATUS.md with recent accomplishments
- Created AAR session documents for all implementation stages
- Next priorities: Documentation search implementation and UX improvements

### Components
1. **ContextTracker**: Monitors token usage and detects threshold crossings
2. **CheckpointManager**: Creates and manages serialized state checkpoints
3. **ProtocolUpdater**: Updates protocol files with context information
4. **RecoverySystem**: Handles post-compact recovery automatically
5. **ContextVisualization**: Provides text-based visualization of context status
6. **ClaudeCodeIntegration**: Integrates context management with Claude Code
7. **ReportGenerator**: Creates comprehensive usage reports for analysis
8. **AutoCompactDetector**: Detects auto-compact events automatically
9. **InstallationUtility**: Provides streamlined setup and dependency management

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

# Auto-compact detection
./bin/recovery/auto-compact-detector.js [--monitor] [--interval=<seconds>]

# Installation and setup
./bin/setup/install-dependencies.sh [--force] [--verbose]
```

### New Features
1. **Auto-Compact Detection**:
   - Automatically detects when Claude Code has compacted the conversation
   - Can run in one-time check mode or continuous monitoring mode
   - Detects auto-compact through time elapsed or sudden utilization drops
   - Creates backups of state files for comparison
   - Prepares recovery state for the next session

2. **Installation and Setup**:
   - Creates necessary directory structure
   - Verifies Node.js installation and version
   - Creates required configuration files
   - Sets up backup and recovery directories
   - Creates visualization module
   - Sets appropriate permissions
   - Creates symbolic links for easy access

### Post-Compact Recovery Plan
1. Implement search functionality for HTML documentation
2. Add dark/light mode toggle for improved user experience
3. Implement print-friendly styles for documentation
4. Add copy-to-clipboard buttons for code blocks
5. Enhance mobile experience with responsive improvements