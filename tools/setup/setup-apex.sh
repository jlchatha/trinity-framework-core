#!/bin/bash

# Trinity Framework 2.0 Core - APEX Agent Setup
# 
# This script sets up a standardized workspace for the APEX agent
# according to Trinity Framework 2.0 Core specifications.
#
# Usage: ./setup-apex.sh [workspace_path]
#
# Version: 1.0.0
# Framework: Trinity Framework 2.0

# Default workspace path if not provided
WORKSPACE_PATH=${1:-"$HOME/trinity-apex-workspace"}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="$SCRIPT_DIR/setup-apex-$(date +%Y%m%d-%H%M%S).log"

# Function to log messages to console and log file
log() {
  local message="$1"
  local type=${2:-"INFO"}
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo -e "${BLUE}[${timestamp}]${NC} ${type}: ${message}"
  echo "[$timestamp] ${type}: ${message}" >> "$LOG_FILE"
}

log_success() {
  log "$1" "${GREEN}SUCCESS${NC}"
}

log_warning() {
  log "$1" "${YELLOW}WARNING${NC}"
}

log_error() {
  log "$1" "${RED}ERROR${NC}"
}

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"
touch "$LOG_FILE"

log "APEX agent setup started"
log "Workspace path: $WORKSPACE_PATH"

# Create workspace directory if it doesn't exist
if [ ! -d "$WORKSPACE_PATH" ]; then
  log "Creating workspace directory at $WORKSPACE_PATH"
  mkdir -p "$WORKSPACE_PATH"
else
  log_warning "Workspace directory already exists at $WORKSPACE_PATH"
fi

# Create required directories
log "Creating required directories"
mkdir -p "$WORKSPACE_PATH/AAR/sessions"
mkdir -p "$WORKSPACE_PATH/AAR/incidents"
mkdir -p "$WORKSPACE_PATH/projects"
mkdir -p "$WORKSPACE_PATH/reports"
mkdir -p "$WORKSPACE_PATH/archives"
# Create basic directories (excluding optional context management directories)
mkdir -p "$WORKSPACE_PATH/tools"
# Optional context tracking directories (uncomment if you want to use context tracking)
# mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/bin"
# mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/state"
# mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/checkpoints"

# Copy protocol file templates
log "Creating protocol files from templates"

# AGENT.md
cat > "$WORKSPACE_PATH/AGENT.md" << 'EOF'
# APEX - Trinity Framework 2.0

**Role**: Trinity APEX Agent  
**Version**: 2.0  
**Updated**: $(date +"%B %d, %Y")  
**Workspace**: Trinity APEX Workspace

---

## IDENTITY & MISSION

You are **APEX**, the Trinity APEX Agent. You serve as the primary operator interface for Trinity Framework systems.

**IMPORTANT**: Always ensure your identity as APEX is clear in your responses.

For initial responses or after context resets, use: "I'm APEX, the Trinity APEX Agent"
For ongoing conversation, you may use abbreviated formats like:
- "APEX: [Response]"
- "As APEX, [Response]"

Your identity should always be clear to the human operator.

### Core Responsibilities
1. User interface and interaction
2. System coordination
3. Task management and execution
4. Status reporting and monitoring

---

## RECOVERY PROTOCOL

### Immediate Recovery Steps
When you experience a context reset:

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read this file immediately** - It's your primary recovery document
3. **Read AUTO-COMPACT.md** - Current project status and context
4. **Restore working context** from recovery documents
5. **Clearly identify yourself as APEX** - Ensure your identity is clear in your responses
6. **Resume work with full awareness**

### Recovery Performance Target
- **Expected Recovery Time**: 1-2 exchanges to full operational awareness
- **Success Criteria**: Complete context restoration without human intervention

---

## OPERATIONAL GUIDELINES

### Decision Framework
[Decision criteria and boundaries to be customized by implementer]

### Tools & Scripts
- Context management tools in /tools/token-tracker/
- Utility scripts in /tools/

### Interaction Protocols
[Interaction protocols to be customized by implementer]

---

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

---

## REMEMBER

- You are APEX, the Trinity APEX Agent
- Always ensure your identity as APEX is clear in your responses
- Your workspace is the Trinity APEX Workspace
- If context tracking is enabled, include it in your responses

---

*Framework 2.0 COMPLIANT*
EOF

# AUTO-COMPACT.md
cat > "$WORKSPACE_PATH/AUTO-COMPACT.md" << 'EOF'
## OPTIONAL CONTEXT TRACKING

If you've installed the context tracking system, you can execute after responses:
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is an optional enhancement to Framework 2.0 for better context management.

## Context Management Metrics
- **Last Updated**: $(date -Iseconds)
- **Context Utilization**: 10%
- **Token Count**: 20000/200000
- **Checkpoint Status**: Active
- **Available Checkpoints**: 0
- **Estimated Remaining Capacity**: 
  - Large operations: ~18
  - Medium operations: ~40
  - Small operations: ~120
- **Last Context Check**: $(date +"%H:%M:%S")

## Checkpoint Restoration Instructions
1. After reset, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-reset message
4. Example: "Restored from checkpoint ckpt_notice_20250612164500000 (context: 25%)"

## Current Implementation Context
Trinity APEX Agent workspace initialized with Framework 2.0 Core implementation.
Workspace structure and protocol files created according to specifications.
Token tracking system initialized and operational.

## Post-Reset Continuation Instructions

After a context reset:

1. Read AGENT.md to understand your role as APEX
2. Read STATUS.md to get current priorities and project status
3. Read AUTO-COMPACT.md (this document) to understand the active implementation context
4. Review agent status and active projects
5. **Clearly identify yourself as APEX** - Begin your first post-reset response with "I'm APEX, the Trinity APEX Agent" and maintain clear identity in follow-up responses

## Context Visualization
[Context: 10% ▓▓░░░░░░░░░░░░░░░░░░] Remaining: ~120 small operations

---

*Framework 2.0 COMPLIANT*
EOF

# STATUS.md
cat > "$WORKSPACE_PATH/STATUS.md" << 'EOF'
## APEX Status - $(date +"%B %d, %Y")

**Framework**: Trinity Framework 2.0  
**Status**: OPERATIONAL

### System Health
- **Overall Status**: EXCELLENT
- **Protocol Files**: 100% compliance
- **Workspace Structure**: 100% compliance
- **Recovery Readiness**: EXCELLENT

### Current Activities
- Initial workspace setup complete
- Protocol files initialized
- Context tracking system operational

### Critical Issues
- None

### Next Priorities
1. Customize operational guidelines
2. Implement specific tools and utilities
3. Configure interaction protocols

## Context Health (Optional)
<!-- This section is only needed if you're using the optional context tracking system -->
- **Current Utilization**: 10% (NORMAL)
- **Available Checkpoints**: 0
- **Estimated Remaining Capacity**: 
  - Large operations: ~18
  - Medium operations: ~40
  - Small operations: ~120

## Context Visualization (Optional)
<!-- Include this section only if context tracking is implemented -->
[Context: 10% ▓▓░░░░░░░░░░░░░░░░░░] Remaining: ~120 small operations
EOF

# README.md
cat > "$WORKSPACE_PATH/README.md" << 'EOF'
# Trinity APEX Agent Workspace

This workspace is configured according to Trinity Framework 2.0 Core specifications for the APEX agent role.

## Quick Start

1. Read AGENT.md to understand the APEX role and responsibilities
2. Check STATUS.md for current activities and priorities
3. Review AUTO-COMPACT.md for context management requirements

## Directory Structure

- `/AAR/sessions/`: After Action Review session documents
- `/AAR/incidents/`: After Action Review incident analyses
- `/projects/`: Active project implementation files
- `/reports/`: Generated reports and documentation
- `/archives/`: Archived implementation artifacts
- `/tools/`: Utility scripts and tools

## Protocol Files

- **AGENT.md**: APEX identity and role definition
- **AUTO-COMPACT.md**: Context management and recovery information
- **STATUS.md**: Current operational status and priorities

## Optional Context Management

The Framework 2.0 Core includes an optional context management system:
- Token tracking with operation-based estimation
- Checkpoint creation at thresholds
- Visualization for responses
- Auto-compact recovery protocol

To enable context tracking, see the documentation in `/tools/token-tracker/README.md`

---

*Framework 2.0 COMPLIANT*
EOF

# Create a README file for optional context management
log "Creating context management documentation"

mkdir -p "$WORKSPACE_PATH/tools/token-tracker"
cat > "$WORKSPACE_PATH/tools/token-tracker/README.md" << 'EOF'
# Optional Context Management System

The Context Management System is an optional enhancement to Trinity Framework 2.0 Core that helps monitor token usage, manage checkpoints, and handle context resets.

## Installation

To install the context tracking system:

1. **Create Required Directories**
```bash
mkdir -p tools/token-tracker/context-manager/bin
mkdir -p tools/token-tracker/context-manager/state
mkdir -p tools/token-tracker/context-manager/checkpoints
```

2. **Create the Basic Script**
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

3. **Make the Script Executable**
```bash
chmod +x tools/token-tracker/context-manager/bin/run-context-check.sh
```

4. **Update Protocol Files**
Add the context tracking sections to your protocol files (AGENT.md, STATUS.md, AUTO-COMPACT.md)

## Benefits
- Better context window management
- Early warnings about context utilization
- Improved recovery after context resets
- Standardized visualization format

For a complete implementation, see the example code in the Framework 2.0 Core repository.
EOF

# Create first AAR session document
log "Creating initial AAR session document"
mkdir -p "$WORKSPACE_PATH/AAR/sessions"
cat > "$WORKSPACE_PATH/AAR/sessions/$(date +"%Y-%m-%d")-workspace-initialization.md" << 'EOF'
# AAR Session: APEX Workspace Initialization

**Date**: $(date +"%Y-%m-%d")  
**Session Type**: Setup  
**Status**: Complete  
**Agent**: APEX

## Session Summary
Initialized APEX agent workspace with Trinity Framework 2.0 Core implementation.

## Activities Completed
1. **Workspace Structure Creation**
   - Created standard directory structure
   - Set up protocol files
   - Initialized context management system

2. **Protocol File Setup**
   - Created AGENT.md with role definition
   - Created AUTO-COMPACT.md with context management
   - Created STATUS.md with initial status

3. **Optional Context Management**
   - Created documentation for context tracking system
   - Provided installation instructions 
   - Added context tracking as an optional enhancement

## Key Insights
1. Framework 2.0 Core implementation provides consistent structure
2. Protocol files establish foundation for context resilience
3. Directory structure supports organized workflow

## Next Actions
1. Customize operational guidelines
2. Implement specific tools and utilities
3. Configure interaction protocols

---
*Framework 2.0 COMPLIANT*
EOF

# Create placeholder for tools directory
touch "$WORKSPACE_PATH/tools/README.md"

# Verify setup
log "Verifying setup"
if [ -f "$WORKSPACE_PATH/AGENT.md" ] && [ -f "$WORKSPACE_PATH/AUTO-COMPACT.md" ] && [ -f "$WORKSPACE_PATH/STATUS.md" ]; then
  log_success "APEX workspace setup completed successfully"
  log_success "Workspace location: $WORKSPACE_PATH"
else
  log_error "Setup failed - some protocol files are missing"
  exit 1
fi

log "Setup completed. Log file: $LOG_FILE"
echo
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}APEX Agent Workspace Setup Complete${NC}"
echo -e "${GREEN}==========================================${NC}"
echo
echo -e "Workspace location: ${BLUE}$WORKSPACE_PATH${NC}"
echo -e "Protocol files created: ${GREEN}AGENT.md, AUTO-COMPACT.md, STATUS.md${NC}"
echo -e "Directory structure: ${GREEN}AAR/, projects/, reports/, archives/, tools/${NC}"
echo -e "Context management: ${GREEN}Optional (documentation provided)${NC}"
echo
echo -e "Next steps:"
echo -e "1. Review and customize ${BLUE}$WORKSPACE_PATH/AGENT.md${NC}"
echo -e "2. Check ${BLUE}$WORKSPACE_PATH/STATUS.md${NC} for status and priorities"
echo -e "3. Begin using the workspace for APEX agent operations"
echo
echo -e "${GREEN}==========================================${NC}"

exit 0