#!/bin/bash

# Trinity Framework 2.0 Core - Verify Installation
# 
# This script verifies the installation and setup of Trinity Framework
# workspaces according to specifications.
#
# Usage: ./verify-installation.sh [workspace_base_path]
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

# Workspace paths
APEX_WORKSPACE="$BASE_PATH/trinity-apex-workspace"
ANALYST_WORKSPACE="$BASE_PATH/trinity-analyst-workspace"
HISTORIAN_WORKSPACE="$BASE_PATH/trinity-historian-workspace"

# Function to check a workspace
check_workspace() {
  local workspace="$1"
  local name="$2"
  local status=0
  
  echo -e "\n${BLUE}Checking $name workspace...${NC}"
  
  # Check if workspace exists
  if [ ! -d "$workspace" ]; then
    echo -e "${RED}❌ $name workspace does not exist at $workspace${NC}"
    return 1
  else
    echo -e "${GREEN}✓ $name workspace exists${NC}"
  fi
  
  # Check protocol files
  if [ -f "$workspace/AGENT.md" ]; then
    echo -e "${GREEN}✓ AGENT.md exists${NC}"
  else
    echo -e "${RED}❌ AGENT.md is missing${NC}"
    status=1
  fi
  
  if [ -f "$workspace/AUTO-COMPACT.md" ]; then
    echo -e "${GREEN}✓ AUTO-COMPACT.md exists${NC}"
  else
    echo -e "${RED}❌ AUTO-COMPACT.md is missing${NC}"
    status=1
  fi
  
  if [ -f "$workspace/STATUS.md" ]; then
    echo -e "${GREEN}✓ STATUS.md exists${NC}"
  else
    echo -e "${RED}❌ STATUS.md is missing${NC}"
    status=1
  fi
  
  # Check required directories
  local required_dirs=("AAR/sessions" "AAR/incidents" "projects" "reports" "archives" "tools")
  for dir in "${required_dirs[@]}"; do
    if [ -d "$workspace/$dir" ]; then
      echo -e "${GREEN}✓ $dir directory exists${NC}"
    else
      echo -e "${RED}❌ $dir directory is missing${NC}"
      status=1
    fi
  done
  
  # Check for optional context management setup
  if [ -d "$workspace/tools/token-tracker" ]; then
    echo -e "${GREEN}✓ Optional context management directory exists${NC}"
    
    if [ -f "$workspace/tools/token-tracker/context-manager/bin/run-context-check.sh" ] && [ -x "$workspace/tools/token-tracker/context-manager/bin/run-context-check.sh" ]; then
      echo -e "${GREEN}✓ Context management scripts are executable${NC}"
    else
      echo -e "${BLUE}ℹ Context management is optional and may not be fully set up${NC}"
    fi
  else
    echo -e "${BLUE}ℹ Optional context management not installed${NC}"
    echo -e "${BLUE}ℹ See tools/token-tracker/README.md for installation instructions${NC}"
  fi
  
  # Check AAR session documents
  if [ "$(find "$workspace/AAR/sessions" -name "*.md" | wc -l)" -gt 0 ]; then
    echo -e "${GREEN}✓ AAR session documents exist${NC}"
  else
    echo -e "${YELLOW}⚠ No AAR session documents found${NC}"
  fi
  
  # Root directory file count
  local root_files=$(find "$workspace" -maxdepth 1 -type f | wc -l)
  if [ "$root_files" -le 10 ]; then
    echo -e "${GREEN}✓ Root directory has $root_files files (within 10-file limit)${NC}"
  else
    echo -e "${YELLOW}⚠ Root directory has $root_files files (exceeds 10-file limit)${NC}"
  fi
  
  return $status
}

# Check if aliases file exists
check_aliases() {
  local aliases_file="$BASE_PATH/.trinity_aliases"
  
  echo -e "\n${BLUE}Checking aliases setup...${NC}"
  
  if [ -f "$aliases_file" ]; then
    echo -e "${GREEN}✓ Trinity aliases file exists at $aliases_file${NC}"
    echo -e "${YELLOW}⚠ Remember to source this file in your shell configuration:${NC}"
    echo -e "${BLUE}   source $aliases_file${NC}"
  else
    echo -e "${YELLOW}⚠ Trinity aliases file not found at $aliases_file${NC}"
    echo -e "${YELLOW}⚠ You may want to run create-workspaces.sh to generate aliases${NC}"
  fi
}

# Run the checks
echo -e "${BLUE}Trinity Framework 2.0 Core - Verification Tool${NC}"
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}Base Path: $BASE_PATH${NC}"

apex_status=0
analyst_status=0
historian_status=0

check_workspace "$APEX_WORKSPACE" "APEX" 
apex_status=$?

check_workspace "$ANALYST_WORKSPACE" "ANALYST"
analyst_status=$?

check_workspace "$HISTORIAN_WORKSPACE" "HISTORIAN"
historian_status=$?

check_aliases

# Summary report
echo -e "\n${BLUE}Verification Summary${NC}"
echo -e "${BLUE}===================${NC}"

if [ $apex_status -eq 0 ]; then
  echo -e "${GREEN}✅ APEX workspace: VALID${NC}"
else
  echo -e "${RED}❌ APEX workspace: ISSUES DETECTED${NC}"
fi

if [ $analyst_status -eq 0 ]; then
  echo -e "${GREEN}✅ ANALYST workspace: VALID${NC}"
else
  echo -e "${RED}❌ ANALYST workspace: ISSUES DETECTED${NC}"
fi

if [ $historian_status -eq 0 ]; then
  echo -e "${GREEN}✅ HISTORIAN workspace: VALID${NC}"
else
  echo -e "${RED}❌ HISTORIAN workspace: ISSUES DETECTED${NC}"
fi

# Overall status
if [ $apex_status -eq 0 ] && [ $analyst_status -eq 0 ] && [ $historian_status -eq 0 ]; then
  echo -e "\n${GREEN}All workspaces are properly configured!${NC}"
  exit 0
else
  echo -e "\n${YELLOW}Some workspaces have issues. Please review the details above.${NC}"
  exit 1
fi