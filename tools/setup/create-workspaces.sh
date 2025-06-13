#!/bin/bash

# Trinity Framework 2.0 Core - Create Workspaces
# 
# This script creates standardized workspaces for all Trinity Framework agents.
#
# Usage: ./create-workspaces.sh [base_path]
#
# Version: 1.0.0
# Framework: Trinity Framework 2.0

# Default base path if not provided
BASE_PATH=${1:-"$HOME"}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="$SCRIPT_DIR/create-workspaces-$(date +%Y%m%d-%H%M%S).log"

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

log "Trinity Framework 2.0 Core - Create Workspaces started"
log "Base path: $BASE_PATH"

# Workspace paths
APEX_WORKSPACE="$BASE_PATH/trinity-apex-workspace"
ANALYST_WORKSPACE="$BASE_PATH/trinity-analyst-workspace"
HISTORIAN_WORKSPACE="$BASE_PATH/trinity-historian-workspace"

# Check for existing workspaces
if [ -d "$APEX_WORKSPACE" ]; then
  log_warning "APEX workspace already exists at $APEX_WORKSPACE"
  read -p "Do you want to overwrite? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Skipping APEX workspace setup"
    SETUP_APEX=false
  else
    SETUP_APEX=true
  fi
else
  SETUP_APEX=true
fi

if [ -d "$ANALYST_WORKSPACE" ]; then
  log_warning "ANALYST workspace already exists at $ANALYST_WORKSPACE"
  read -p "Do you want to overwrite? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Skipping ANALYST workspace setup"
    SETUP_ANALYST=false
  else
    SETUP_ANALYST=true
  fi
else
  SETUP_ANALYST=true
fi

if [ -d "$HISTORIAN_WORKSPACE" ]; then
  log_warning "HISTORIAN workspace already exists at $HISTORIAN_WORKSPACE"
  read -p "Do you want to overwrite? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Skipping HISTORIAN workspace setup"
    SETUP_HISTORIAN=false
  else
    SETUP_HISTORIAN=true
  fi
else
  SETUP_HISTORIAN=true
fi

# Setup workspaces
if [ "$SETUP_APEX" = true ]; then
  log "Setting up APEX workspace"
  "$SCRIPT_DIR/setup-apex.sh" "$APEX_WORKSPACE"
  if [ $? -ne 0 ]; then
    log_error "APEX workspace setup failed"
  else
    log_success "APEX workspace setup completed"
  fi
fi

if [ "$SETUP_ANALYST" = true ]; then
  log "Setting up ANALYST workspace"
  "$SCRIPT_DIR/setup-analyst.sh" "$ANALYST_WORKSPACE"
  if [ $? -ne 0 ]; then
    log_error "ANALYST workspace setup failed"
  else
    log_success "ANALYST workspace setup completed"
  fi
fi

if [ "$SETUP_HISTORIAN" = true ]; then
  log "Setting up HISTORIAN workspace"
  "$SCRIPT_DIR/setup-historian.sh" "$HISTORIAN_WORKSPACE"
  if [ $? -ne 0 ]; then
    log_error "HISTORIAN workspace setup failed"
  else
    log_success "HISTORIAN workspace setup completed"
  fi
fi

# Setup verification
log "Verifying workspace setup"

SETUP_SUCCESS=true

if [ "$SETUP_APEX" = true ]; then
  if [ -f "$APEX_WORKSPACE/AGENT.md" ] && [ -f "$APEX_WORKSPACE/AUTO-COMPACT.md" ] && [ -f "$APEX_WORKSPACE/STATUS.md" ]; then
    log_success "APEX workspace verification passed"
  else
    log_error "APEX workspace verification failed"
    SETUP_SUCCESS=false
  fi
fi

if [ "$SETUP_ANALYST" = true ]; then
  if [ -f "$ANALYST_WORKSPACE/AGENT.md" ] && [ -f "$ANALYST_WORKSPACE/AUTO-COMPACT.md" ] && [ -f "$ANALYST_WORKSPACE/STATUS.md" ]; then
    log_success "ANALYST workspace verification passed"
  else
    log_error "ANALYST workspace verification failed"
    SETUP_SUCCESS=false
  fi
fi

if [ "$SETUP_HISTORIAN" = true ]; then
  if [ -f "$HISTORIAN_WORKSPACE/AGENT.md" ] && [ -f "$HISTORIAN_WORKSPACE/AUTO-COMPACT.md" ] && [ -f "$HISTORIAN_WORKSPACE/STATUS.md" ]; then
    log_success "HISTORIAN workspace verification passed"
  else
    log_error "HISTORIAN workspace verification failed"
    SETUP_SUCCESS=false
  fi
fi

# Create bash aliases for convenience
log "Creating bash aliases"
ALIASES_FILE="$BASE_PATH/.trinity_aliases"

cat > "$ALIASES_FILE" << EOF
# Trinity Framework 2.0 Core - Agent Workspace Aliases
# Add these to your .bashrc or .bash_profile with:
# source ~/.trinity_aliases

# Agent workspace navigation
alias apex="cd $APEX_WORKSPACE"
alias analyst="cd $ANALYST_WORKSPACE"
alias historian="cd $HISTORIAN_WORKSPACE"

# Context management shortcuts
alias apex-context="$APEX_WORKSPACE/tools/token-tracker/context-manager/bin/run-context-check.sh"
alias analyst-context="$ANALYST_WORKSPACE/tools/token-tracker/context-manager/bin/run-context-check.sh"
alias historian-context="$HISTORIAN_WORKSPACE/tools/token-tracker/context-manager/bin/run-context-check.sh"
EOF

echo
echo -e "${YELLOW}To use workspace aliases, add the following to your .bashrc or .bash_profile:${NC}"
echo -e "${BLUE}source $ALIASES_FILE${NC}"
echo

# Final status report
if [ "$SETUP_SUCCESS" = true ]; then
  log_success "All workspace setup operations completed successfully"
else
  log_error "Some workspace setup operations failed. Check the log for details: $LOG_FILE"
fi

log "Setup completed. Log file: $LOG_FILE"
echo
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}Trinity Framework 2.0 Core Workspace Setup${NC}"
echo -e "${GREEN}==========================================${NC}"
echo
echo -e "APEX Workspace: ${BLUE}$APEX_WORKSPACE${NC}"
echo -e "ANALYST Workspace: ${BLUE}$ANALYST_WORKSPACE${NC}"
echo -e "HISTORIAN Workspace: ${BLUE}$HISTORIAN_WORKSPACE${NC}"
echo
echo -e "Aliases file: ${BLUE}$ALIASES_FILE${NC}"
echo
echo -e "Next steps:"
echo -e "1. Add aliases to your shell configuration:"
echo -e "   ${BLUE}source $ALIASES_FILE${NC}"
echo -e "2. Explore each workspace to verify setup"
echo -e "3. Begin using the workspaces for agent operations"
echo
echo -e "${GREEN}==========================================${NC}"

exit 0