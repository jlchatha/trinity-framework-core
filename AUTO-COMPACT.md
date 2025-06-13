## ⚠️ MANDATORY CONTEXT TRACKING - ALL AGENTS - FRAMEWORK 2.0 REQUIREMENT ⚠️

Execute after EVERY response:
```bash
cd /home/alreadyinuse/git/trinity-historian-workspace/tools/token-tracker/context-manager-v2/bin
./run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is a CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT. All agents must implement context tracking with every response.

## Context Management Metrics
- **Last Updated**: 2025-06-13 17:45:30
- **Context Utilization**: 88%
- **Token Count**: 176000/200000
- **Checkpoint Status**: ACTIVE
- **Available Checkpoints**: 5
- **Estimated Remaining Capacity**: 
  - Large operations: ~0
  - Medium operations: ~3
  - Small operations: ~8
- **Last Context Check**: 2025-06-13 17:45:30
- **Token Estimation**: Standard Framework 2.0 values
- **Checkpoint Data**: 
```json
[
  {
    "id": "ckpt_notice_20250612",
    "timestamp": "2025-06-12T17:15:23.000Z",
    "utilizationPercentage": 69,
    "thresholdStatus": "NOTICE"
  },
  {
    "id": "ckpt_warning_20250613",
    "timestamp": "2025-06-13T10:30:45.000Z",
    "utilizationPercentage": 75,
    "thresholdStatus": "WARNING"
  },
  {
    "id": "ckpt_warning_20250613_2",
    "timestamp": "2025-06-13T11:45:20.000Z",
    "utilizationPercentage": 78,
    "thresholdStatus": "WARNING"
  },
  {
    "id": "ckpt_warning_20250613_3",
    "timestamp": "2025-06-13T14:30:15.000Z",
    "utilizationPercentage": 82,
    "thresholdStatus": "WARNING"
  },
  {
    "id": "ckpt_alert_20250613",
    "timestamp": "2025-06-13T17:45:30.000Z",
    "utilizationPercentage": 88,
    "thresholdStatus": "ALERT"
  }
]
```

## Checkpoint Restoration Instructions
1. After compact, Claude Code MUST check for checkpoint data
2. If checkpoint data exists, agent MUST load checkpoint state
3. Checkpoint restoration MUST be acknowledged in first post-compact message
4. Example: "Restored from checkpoint ckpt_warning_20250613_2 (context: 78%)"

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
- Trinity Framework 2.0 Core Public Repository fully implemented with enhanced GitHub Pages
- Applied ShadowRun theme to quick-start guide and agent-roles pages
- Created Beta 2 deployment experience page with animated terminal console
- Added progress bars and card-based layouts for visual data representation
- Implemented technical details tables with status indicators
- Enhanced documentation navigation with Field Reports section
- Updated all core files with latest progress information
- Added breadcrumbs and consistent styling across all pages
- Created AAR session document for theme update and Beta 2 experience page
- Repository is fully operational with visually appealing documentation

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
1. Resume operations using recovered checkpoint data
2. Verify successful deployment of Beta 2 deployment experience page
3. Check analytics for user engagement with animated terminal console
4. Consider additional field report pages for real-world implementations
5. Gather feedback on the Beta 2 deployment experience presentation
6. Plan next documentation enhancements based on user feedback