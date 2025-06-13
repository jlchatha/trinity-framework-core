#!/bin/bash
#
# Trinity Framework 2.0 - Dependencies Installer
# 
# This script installs the necessary dependencies for Trinity Framework 2.0,
# including Node.js packages required for optional context management.
#
# Usage:
#   ./install-dependencies.sh [--with-context-tracking]
#
# Options:
#   --with-context-tracking    Install dependencies for optional context tracking system
#
# Example:
#   ./install-dependencies.sh --with-context-tracking

set -e  # Exit immediately if a command exits with a non-zero status

# Default options
INSTALL_CONTEXT_TRACKING=false
WORKSPACE_PATH="$(pwd)"

# Color definitions
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}===========================================================${NC}"
echo -e "${BLUE}Trinity Framework 2.0 - Dependencies Installer${NC}"
echo -e "${BLUE}===========================================================${NC}"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-context-tracking)
      INSTALL_CONTEXT_TRACKING=true
      shift
      ;;
    --workspace=*)
      WORKSPACE_PATH="${1#*=}"
      shift
      ;;
    *)
      echo -e "${RED}Error: Unknown option: $1${NC}"
      echo "Usage: ./install-dependencies.sh [--with-context-tracking] [--workspace=/path/to/workspace]"
      exit 1
      ;;
  esac
done

# Validate Node.js installation
echo -e "${YELLOW}Checking for Node.js installation...${NC}"
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}Node.js found: $NODE_VERSION${NC}"
else
    echo -e "${RED}Node.js not found. Please install Node.js v14 or higher before continuing.${NC}"
    echo "Visit https://nodejs.org/ for installation instructions."
    exit 1
fi

# Validate npm installation
echo -e "${YELLOW}Checking for npm installation...${NC}"
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    echo -e "${GREEN}npm found: $NPM_VERSION${NC}"
else
    echo -e "${RED}npm not found. Please install npm before continuing.${NC}"
    exit 1
fi

# Validate bash installation
echo -e "${YELLOW}Checking for bash installation...${NC}"
if command -v bash &> /dev/null; then
    BASH_VERSION=$(bash --version | head -n 1)
    echo -e "${GREEN}bash found: $BASH_VERSION${NC}"
else
    echo -e "${RED}bash not found. Please install bash before continuing.${NC}"
    exit 1
fi

# Create package.json if it doesn't exist
if [ ! -f "$WORKSPACE_PATH/package.json" ]; then
    echo -e "${YELLOW}Creating package.json...${NC}"
    cat > "$WORKSPACE_PATH/package.json" << EOF
{
  "name": "trinity-framework-core",
  "version": "2.0.0",
  "description": "Trinity Framework 2.0 Core",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": ["trinity", "framework", "agent"],
  "author": "Trinity Framework Team",
  "license": "MIT"
}
EOF
    echo -e "${GREEN}package.json created${NC}"
fi

# Install common dependencies
echo -e "${YELLOW}Installing common dependencies...${NC}"
npm install --save-dev fs-extra chalk commander

# Setup directory structure
echo -e "${YELLOW}Setting up directory structure...${NC}"
mkdir -p "$WORKSPACE_PATH/logs"
mkdir -p "$WORKSPACE_PATH/tmp"

# Install context tracking dependencies if requested
if [ "$INSTALL_CONTEXT_TRACKING" = true ]; then
    echo -e "${YELLOW}Installing context tracking dependencies...${NC}"
    
    # Create package directories
    mkdir -p "$WORKSPACE_PATH/tools/context-management/bin"
    mkdir -p "$WORKSPACE_PATH/tools/context-management/storage"
    
    # Install specific dependencies for context tracking
    npm install --save node-fetch uuid jsonfile winston
    
    echo -e "${GREEN}Context tracking dependencies installed${NC}"
    
    # Copy context tracking scripts to destination
    echo -e "${YELLOW}Setting up context tracking scripts...${NC}"
    
    # Create basic run-context-check.sh script
    cat > "$WORKSPACE_PATH/tools/context-management/bin/run-context-check.sh" << 'EOF'
#!/bin/bash

# Trinity Framework 2.0 - Context Management Tool
# This is a simplified version for the public repository

# Default operation
OPERATION="check"
TYPE="ASSISTANT_MEDIUM"
CONFIRM=""
FORMAT="text"

# Process command line arguments
if [ $# -gt 0 ]; then
  OPERATION="$1"
  shift
  
  # Process operation-specific arguments
  case "$OPERATION" in
    check)
      if [ $# -gt 0 ]; then
        TYPE="$1"
      fi
      ;;
    compact)
      if [ $# -gt 0 ]; then
        CONFIRM="$1"
      fi
      ;;
    report)
      if [ $# -gt 0 ]; then
        FORMAT="$1"
      fi
      ;;
  esac
fi

# Simulation functions for the public repository version
function simulate_check() {
  # This would call the actual token counter in a real implementation
  # Here we just simulate with sample output
  
  # Get a random percentage between 20-60% for demonstration
  PERCENT=$((20 + RANDOM % 41))
  
  # Calculate the number of filled blocks (out of 20)
  FILLED=$((PERCENT / 5))
  EMPTY=$((20 - FILLED))
  
  # Create the visualization
  VIZ=""
  for ((i=0; i<FILLED; i++)); do
    VIZ="${VIZ}▓"
  done
  for ((i=0; i<EMPTY; i++)); do
    VIZ="${VIZ}░"
  done
  
  # Calculate remaining operations
  REMAINING=$((140 - PERCENT))
  
  echo "[Context: ${PERCENT}% ${VIZ}] Remaining: ~${REMAINING} small operations"
}

function simulate_recovery() {
  echo "No recovery needed. Starting fresh session."
  simulate_check
}

function simulate_compact() {
  if [ "$CONFIRM" == "yes" ]; then
    echo "Simulating auto-compact process with confirmation..."
    echo "In a real implementation, this would create a checkpoint and signal for compact"
    echo "Auto-compact simulation complete. Context has been reset."
    echo "Starting fresh session with 0% utilization."
  else
    echo "Auto-compact cancelled by user."
  fi
}

function simulate_report() {
  echo "Context Management Report (Simulated)"
  echo "===================================="
  echo "Status: OPERATIONAL"
  echo "Context Tracking: ACTIVE"
  echo "Checkpoints Available: 2"
  echo "Last Operation: check $TYPE"
  echo "Format: $FORMAT"
  echo ""
  echo "This is a demonstration report. In a real implementation,"
  echo "this would provide detailed context usage statistics."
}

function simulate_reset() {
  echo "Context tracking state reset. Run './run-context-check.sh recovery' to initialize."
}

# Execute the requested operation
case "$OPERATION" in
  check)
    simulate_check
    ;;
  recovery)
    simulate_recovery
    ;;
  compact)
    simulate_compact
    ;;
  report)
    simulate_report
    ;;
  reset)
    simulate_reset
    ;;
  *)
    echo "Unknown operation: $OPERATION"
    echo "Valid operations: check, recovery, compact, report, reset"
    exit 1
    ;;
esac

exit 0
EOF
    
    # Make script executable
    chmod +x "$WORKSPACE_PATH/tools/context-management/bin/run-context-check.sh"
    
    echo -e "${GREEN}Context tracking scripts created${NC}"
fi

# Create a README with installation information
cat > "$WORKSPACE_PATH/tools/setup/README.md" << EOF
# Trinity Framework 2.0 Setup Tools

This directory contains scripts for setting up and configuring Trinity Framework 2.0 agent workspaces.

## Available Scripts

- **create-workspaces.sh**: Creates all three agent workspaces (APEX, ANALYST, HISTORIAN)
- **setup-apex.sh**: Creates an APEX agent workspace
- **setup-analyst.sh**: Creates an ANALYST agent workspace
- **setup-historian.sh**: Creates a HISTORIAN agent workspace
- **verify-installation.sh**: Verifies the correctness of an installation
- **install-dependencies.sh**: Installs required dependencies

## Usage

### Installing Dependencies

```bash
# Install basic dependencies
./install-dependencies.sh

# Install with optional context tracking
./install-dependencies.sh --with-context-tracking
```

### Creating Agent Workspaces

```bash
# Create all three agent workspaces
./create-workspaces.sh /path/to/parent/directory

# Create individual agent workspace
./setup-apex.sh /path/to/parent/directory
./setup-analyst.sh /path/to/parent/directory
./setup-historian.sh /path/to/parent/directory
```

### Verifying Installation

```bash
# Verify an agent workspace
./verify-installation.sh /path/to/agent/workspace
```

## Dependencies

The following dependencies are installed by the install-dependencies.sh script:

- fs-extra: File system operations
- chalk: Terminal output styling
- commander: Command-line interface

If context tracking is enabled, these additional dependencies are installed:

- node-fetch: HTTP requests
- uuid: Unique identifier generation
- jsonfile: JSON file handling
- winston: Logging framework

## Notes

- All paths should be absolute to ensure consistent operation
- It's recommended to run these scripts from the root of the trinity-framework-core repository
- The scripts will create the necessary directory structure if it doesn't exist

EOF

echo -e "${GREEN}Dependencies installation complete!${NC}"
echo -e "${BLUE}===========================================================${NC}"

if [ "$INSTALL_CONTEXT_TRACKING" = true ]; then
    echo -e "${GREEN}Context tracking dependencies have been installed.${NC}"
    echo -e "${YELLOW}You can now create agent workspaces with context tracking enabled.${NC}"
else
    echo -e "${YELLOW}Context tracking dependencies were NOT installed.${NC}"
    echo -e "${YELLOW}To install them later, run:${NC}"
    echo -e "${BLUE}./install-dependencies.sh --with-context-tracking${NC}"
fi

echo -e "${YELLOW}Next steps:${NC}"
echo -e "${GREEN}1. Create agent workspaces using setup-*.sh scripts${NC}"
echo -e "${GREEN}2. Verify installation using verify-installation.sh${NC}"
echo -e "${GREEN}3. Begin using Trinity Framework 2.0${NC}"
echo -e "${BLUE}===========================================================${NC}"

exit 0