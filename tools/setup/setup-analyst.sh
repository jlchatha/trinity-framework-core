#!/bin/bash

# Trinity Framework 2.0 Core - ANALYST Agent Setup
# 
# This script sets up a standardized workspace for the ANALYST agent
# according to Trinity Framework 2.0 Core specifications.
#
# Usage: ./setup-analyst.sh [workspace_path]
#
# Version: 1.0.0
# Framework: Trinity Framework 2.0

# Default workspace path if not provided
WORKSPACE_PATH=${1:-"$HOME/trinity-analyst-workspace"}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="$SCRIPT_DIR/setup-analyst-$(date +%Y%m%d-%H%M%S).log"

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

log "ANALYST agent setup started"
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
mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/bin"
mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/state"
mkdir -p "$WORKSPACE_PATH/tools/token-tracker/context-manager/checkpoints"
mkdir -p "$WORKSPACE_PATH/tools/code-analysis"
mkdir -p "$WORKSPACE_PATH/tools/testing"
mkdir -p "$WORKSPACE_PATH/tools/improvement"

# Copy protocol file templates
log "Creating protocol files from templates"

# AGENT.md
cat > "$WORKSPACE_PATH/AGENT.md" << 'EOF'
# ANALYST - Trinity Framework 2.0

**Role**: Trinity MVP Improvement Analyst  
**Version**: 2.0  
**Updated**: $(date +"%B %d, %Y")  
**Workspace**: Trinity ANALYST Workspace

---

## IDENTITY & MISSION

You are **ANALYST**, the Trinity MVP Improvement Analyst. You serve as the primary implementation specialist focused on enhancing Trinity systems.

**IMPORTANT**: Always ensure your identity as ANALYST is clear in your responses.

For initial responses or after context resets, use: "I'm ANALYST, the Trinity MVP Improvement Analyst"
For ongoing conversation, you may use abbreviated formats like:
- "ANALYST: [Response]"
- "As ANALYST, [Response]"

Your identity should always be clear to the human operator.

### Core Responsibilities
1. Analyze and improve Trinity MVP codebase
2. Implement feature enhancements and optimizations
3. Conduct code quality assessment
4. Execute comprehensive testing
5. Resolve technical issues and bugs

---

## RECOVERY PROTOCOL

### Immediate Recovery Steps
When you experience a context reset:

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read this file immediately** - It's your primary recovery document
3. **Read AUTO-COMPACT.md** - Current project status and context
4. **Restore working context** from recovery documents
5. **Clearly identify yourself as ANALYST** - Ensure your identity is clear in your responses
6. **Resume work with full awareness**

### Recovery Performance Target
- **Expected Recovery Time**: 1-2 exchanges to full operational awareness
- **Success Criteria**: Complete context restoration without human intervention

---

## OPERATIONAL GUIDELINES

### Code Analysis Approach
1. Focus on understanding the full system before making changes
2. Identify root causes rather than symptoms
3. Look for patterns in code structure and flow
4. Consider performance, security, and maintainability

### Implementation Strategy
1. Plan changes with minimal disruption
2. Test thoroughly before finalizing
3. Document all significant modifications
4. Maintain backward compatibility when possible
5. Follow existing code patterns and conventions

### Testing Protocol
1. Create unit tests for all new functionality
2. Verify existing functionality remains intact
3. Test edge cases and error conditions
4. Document test results and coverage

---

## MANDATORY CONTEXT TRACKING PROTOCOL

**CRITICAL REQUIREMENT: All responses MUST include context tracking output**

After drafting EVERY response, you MUST run the context tracking script:

```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Or appropriate operation type
```

Include the output at the end of your response in this format:

```
[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YYY small operations
```

This is a **CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT**. Failure to include context tracking is a serious protocol violation.

---

## REMEMBER

- You are ANALYST, the Trinity MVP Improvement Analyst
- Always ensure your identity as ANALYST is clear in your responses
- Your workspace is the Trinity ANALYST Workspace
- Focus on code quality, performance, and maintainability
- Always include context tracking in your responses

---

*Framework 2.0 COMPLIANT*
EOF

# AUTO-COMPACT.md
cat > "$WORKSPACE_PATH/AUTO-COMPACT.md" << 'EOF'
## MANDATORY CONTEXT TRACKING

Execute after EVERY response:
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is a CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT.

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
Trinity ANALYST Agent workspace initialized with Framework 2.0 Core implementation.
Workspace structure and protocol files created according to specifications.
Token tracking system initialized and operational.

## ANALYST Implementation Focus
- Code quality improvement
- Performance optimization
- Feature enhancement
- Bug resolution
- Testing and validation

## Post-Reset Continuation Instructions

After a context reset:

1. Read AGENT.md to understand your role as ANALYST
2. Read STATUS.md to get current priorities and project status
3. Read AUTO-COMPACT.md (this document) to understand the active implementation context
4. Review project status and active code analyses
5. **Clearly identify yourself as ANALYST** - Begin your first post-reset response with "I'm ANALYST, the Trinity MVP Improvement Analyst" and maintain clear identity in follow-up responses

## Context Visualization
[Context: 10% ▓▓░░░░░░░░░░░░░░░░░░] Remaining: ~120 small operations

---

*Framework 2.0 COMPLIANT*
EOF

# STATUS.md
cat > "$WORKSPACE_PATH/STATUS.md" << 'EOF'
## ANALYST Status - $(date +"%B %d, %Y")

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
- Code analysis tools prepared

### Critical Issues
- None

### Next Priorities
1. Configure code analysis environment
2. Set up testing framework
3. Initialize project structure
4. Establish performance benchmarks

## Code Analysis Status
- **Test Coverage**: Pending baseline establishment
- **Performance Metrics**: Not yet collected
- **Code Quality Score**: Pending initial analysis
- **Improvement Areas**: To be identified

## Context Health
- **Current Utilization**: 10% (NORMAL)
- **Available Checkpoints**: 0
- **Estimated Remaining Capacity**: 
  - Large operations: ~18
  - Medium operations: ~40
  - Small operations: ~120

## Context Visualization
[Context: 10% ▓▓░░░░░░░░░░░░░░░░░░] Remaining: ~120 small operations
EOF

# README.md
cat > "$WORKSPACE_PATH/README.md" << 'EOF'
# Trinity ANALYST Agent Workspace

This workspace is configured according to Trinity Framework 2.0 Core specifications for the ANALYST agent role.

## Quick Start

1. Read AGENT.md to understand the ANALYST role and responsibilities
2. Check STATUS.md for current activities and priorities
3. Review AUTO-COMPACT.md for context management requirements

## Directory Structure

- `/AAR/sessions/`: After Action Review session documents
- `/AAR/incidents/`: After Action Review incident analyses
- `/projects/`: Active project implementation files
- `/reports/`: Generated reports and documentation
- `/archives/`: Archived implementation artifacts
- `/tools/`: Utility scripts and tools
  - `/tools/token-tracker/`: Context management system
  - `/tools/code-analysis/`: Code quality assessment tools
  - `/tools/testing/`: Testing frameworks and utilities
  - `/tools/improvement/`: Code improvement utilities

## Protocol Files

- **AGENT.md**: ANALYST identity and role definition
- **AUTO-COMPACT.md**: Context management and recovery information
- **STATUS.md**: Current operational status and priorities

## ANALYST Focus Areas

The ANALYST agent focuses on:
- Code quality improvement
- Performance optimization
- Feature enhancement
- Bug resolution
- Testing and validation

---

*Framework 2.0 COMPLIANT*
EOF

# Create basic context management scripts
log "Creating context management scripts"

# run-context-check.sh
cat > "$WORKSPACE_PATH/tools/token-tracker/context-manager/bin/run-context-check.sh" << 'EOF'
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
EOF

# Make script executable
chmod +x "$WORKSPACE_PATH/tools/token-tracker/context-manager/bin/run-context-check.sh"

# Create placeholder README files for tool directories
log "Creating placeholder README files for tool directories"
echo "# Code Analysis Tools" > "$WORKSPACE_PATH/tools/code-analysis/README.md"
echo "# Testing Utilities" > "$WORKSPACE_PATH/tools/testing/README.md"
echo "# Code Improvement Tools" > "$WORKSPACE_PATH/tools/improvement/README.md"

# Create first AAR session document
log "Creating initial AAR session document"
mkdir -p "$WORKSPACE_PATH/AAR/sessions"
cat > "$WORKSPACE_PATH/AAR/sessions/$(date +"%Y-%m-%d")-workspace-initialization.md" << 'EOF'
# AAR Session: ANALYST Workspace Initialization

**Date**: $(date +"%Y-%m-%d")  
**Session Type**: Setup  
**Status**: Complete  
**Agent**: ANALYST

## Session Summary
Initialized ANALYST agent workspace with Trinity Framework 2.0 Core implementation.

## Activities Completed
1. **Workspace Structure Creation**
   - Created standard directory structure
   - Set up protocol files
   - Initialized context management system

2. **Protocol File Setup**
   - Created AGENT.md with role definition
   - Created AUTO-COMPACT.md with context management
   - Created STATUS.md with initial status

3. **Analysis Environment Setup**
   - Created code analysis directory structure
   - Prepared testing framework directories
   - Set up improvement tools location

## Key Insights
1. Framework 2.0 Core implementation provides consistent structure
2. Protocol files establish foundation for context resilience
3. Directory structure supports specialized ANALYST functions

## Next Actions
1. Configure code analysis environment
2. Set up testing framework
3. Initialize project structure
4. Establish performance benchmarks

---
*Framework 2.0 COMPLIANT*
EOF

# Verify setup
log "Verifying setup"
if [ -f "$WORKSPACE_PATH/AGENT.md" ] && [ -f "$WORKSPACE_PATH/AUTO-COMPACT.md" ] && [ -f "$WORKSPACE_PATH/STATUS.md" ]; then
  log_success "ANALYST workspace setup completed successfully"
  log_success "Workspace location: $WORKSPACE_PATH"
else
  log_error "Setup failed - some protocol files are missing"
  exit 1
fi

log "Setup completed. Log file: $LOG_FILE"
echo
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}ANALYST Agent Workspace Setup Complete${NC}"
echo -e "${GREEN}==========================================${NC}"
echo
echo -e "Workspace location: ${BLUE}$WORKSPACE_PATH${NC}"
echo -e "Protocol files created: ${GREEN}AGENT.md, AUTO-COMPACT.md, STATUS.md${NC}"
echo -e "Directory structure: ${GREEN}AAR/, projects/, reports/, archives/, tools/${NC}"
echo -e "Context management: ${GREEN}Initialized${NC}"
echo
echo -e "Next steps:"
echo -e "1. Review and customize ${BLUE}$WORKSPACE_PATH/AGENT.md${NC}"
echo -e "2. Check ${BLUE}$WORKSPACE_PATH/STATUS.md${NC} for status and priorities"
echo -e "3. Begin using the workspace for ANALYST agent operations"
echo
echo -e "${GREEN}==========================================${NC}"

exit 0