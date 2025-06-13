# Trinity Framework 2.0 Core - Setup Guide

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

This guide provides detailed instructions for setting up the Trinity Framework 2.0 Core environment. It covers both the repository setup and the creation of agent workspaces. For a quicker overview, see the [Quick Start Guide](./quick-start.md).

## System Requirements

Trinity Framework 2.0 Core has minimal system requirements, making it accessible across various environments:

- **Operating System**: Linux and macOS only (Claude Code does not fully support Windows/WSL)
- **Shell**: Bash or compatible shell
- **Required Tools**:
  - Git (for repository management)
  - Node.js (for optional context tracking utilities)
  - Text editor (for editing protocol files)
- **Disk Space**: 50MB for repository, ~10MB per agent workspace

## Installation Steps

### 1. Clone the Repository

First, clone the Trinity Framework 2.0 Core repository to your local system:

```bash
# Create a directory for Trinity projects
mkdir -p ~/trinity
cd ~/trinity

# Clone the repository
git clone https://github.com/trinity-framework/trinity-framework-core.git
cd trinity-framework-core
```

### 2. Directory Structure Planning

Before setting up agent workspaces, plan your directory structure. We recommend placing agent workspaces at the same directory level as the cloned repository:

```
/home/user/trinity/                # Base directory
├── trinity-framework-core/        # Cloned framework repository
├── trinity-apex-workspace/        # APEX agent workspace
├── trinity-analyst-workspace/     # ANALYST agent workspace
└── trinity-historian-workspace/   # HISTORIAN agent workspace
```

This flat structure makes each component independently accessible and maintainable.

### 3. Set Up Tools and Scripts

Make the setup scripts executable:

```bash
# Navigate to the setup directory
cd tools/setup

# Make all scripts executable
chmod +x *.sh
```

### 4. Create Agent Workspaces

You can create all three standard agent workspaces at once:

```bash
# Create all workspaces in the parent directory
./create-workspaces.sh ~/trinity
```

Or create individual agent workspaces as needed:

```bash
# Create only the APEX agent workspace
./setup-apex.sh ~/trinity/trinity-apex-workspace

# Create only the ANALYST agent workspace
./setup-analyst.sh ~/trinity/trinity-analyst-workspace

# Create only the HISTORIAN agent workspace
./setup-historian.sh ~/trinity/trinity-historian-workspace
```

### 5. Optional: Install Context Management Components

By default, the setup scripts create placeholder files for the optional context management system. To install the full functionality:

```bash
# For APEX workspace (repeat for each workspace as needed)
cd ~/trinity/trinity-apex-workspace

# Create required directories
mkdir -p tools/token-tracker/context-manager/bin
mkdir -p tools/token-tracker/context-manager/state
mkdir -p tools/token-tracker/context-manager/checkpoints

# Copy context management files from framework repository
cp -r ~/trinity/trinity-framework-core/examples/context-tracking/* tools/token-tracker/

# Make scripts executable
chmod +x tools/token-tracker/context-manager/bin/*.sh
```

### 6. Verify Installation

Verify the installation with the verification script:

```bash
# Navigate to setup directory
cd ~/trinity/trinity-framework-core/tools/setup

# Verify all agent workspaces
./verify-installation.sh ~/trinity
```

The script will check for required files, directories, and proper permissions, and report any issues.

## Workspace Customization

After setting up the basic workspace structure, customize each workspace for its specific agent role:

### APEX Agent Customization

```bash
cd ~/trinity/trinity-apex-workspace

# Edit protocol files
nano AGENT.md
nano STATUS.md
nano AUTO-COMPACT.md

# Create agent-specific tools
mkdir -p tools/apex-specific
```

### ANALYST Agent Customization

```bash
cd ~/trinity/trinity-analyst-workspace

# Edit protocol files
nano AGENT.md
nano STATUS.md
nano AUTO-COMPACT.md

# Create agent-specific tools
mkdir -p tools/analyst-specific
```

### HISTORIAN Agent Customization

```bash
cd ~/trinity/trinity-historian-workspace

# Edit protocol files
nano AGENT.md
nano STATUS.md
nano AUTO-COMPACT.md

# Create agent-specific tools
mkdir -p tools/historian-specific
```

## Bash Aliases Setup

For convenience, you can set up Bash aliases to quickly navigate to each workspace:

```bash
# Add these to your ~/.bashrc or ~/.bash_profile
echo '# Trinity Framework 2.0 Workspace Aliases' >> ~/.bashrc
echo 'alias trinity-apex="cd ~/trinity/trinity-apex-workspace"' >> ~/.bashrc
echo 'alias trinity-analyst="cd ~/trinity/trinity-analyst-workspace"' >> ~/.bashrc
echo 'alias trinity-historian="cd ~/trinity/trinity-historian-workspace"' >> ~/.bashrc
echo 'alias trinity-framework="cd ~/trinity/trinity-framework-core"' >> ~/.bashrc
source ~/.bashrc
```

## Framework Updates

To update the Trinity Framework 2.0 Core repository:

```bash
cd ~/trinity/trinity-framework-core
git pull origin main
```

Note that updates to the framework don't automatically update existing agent workspaces. You'll need to manually apply any changes to established workspaces.

## Integration with Existing Systems

When integrating Trinity Framework 2.0 Core with existing systems:

1. Keep the framework repository separate from application code
2. Position agent workspaces at the same level as existing system directories
3. Reference shared resources using absolute paths
4. Use the verification script to ensure compliance after integration

Example directory structure with an existing system:

```
/home/user/projects/
├── existing-system/              # Your existing system
├── trinity-framework-core/       # Framework repository
├── trinity-apex-workspace/       # APEX agent workspace
├── trinity-analyst-workspace/    # ANALYST agent workspace
└── trinity-historian-workspace/  # HISTORIAN agent workspace
```

## Troubleshooting

### Common Issues

- **Permission Denied**: Run `chmod +x tools/setup/*.sh` to make scripts executable
- **Missing Directories**: Ensure parent directories exist before running setup scripts
- **Context Tracking Errors**: Verify Node.js is installed for full context tracking functionality
- **Protocol File Errors**: Check for syntax errors in customized protocol files

### Getting Help

If you encounter issues not addressed here:

- Check the [GitHub repository](https://github.com/trinity-framework/trinity-framework-core/issues) for known issues
- Review the [Framework Compliance](../reference/compliance-checklist.md) document
- Consult the [Troubleshooting Guide](../troubleshooting.md) for advanced solutions

## Next Steps

After completing the setup:

1. Read the [Framework Core Principles](../principles/context-resilience.md)
2. Explore the [Agent Setup Guide](./agent-setup-guide.md) for agent-specific information
3. Review the [Protocol Files Reference](../reference/protocol-files.md)
4. Try the [Context Management System](../guides/context-management.md) if needed

---

*Framework 2.0 COMPLIANT*