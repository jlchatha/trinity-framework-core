# Trinity Framework 2.0 Core - Quick Start Guide

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

This quick start guide will help you set up a basic Trinity Framework 2.0 Core implementation in just a few minutes. You'll create a standardized workspace with all required protocol files and directory structure.

## Prerequisites

- Bash-compatible environment (Linux or macOS only - Claude Code does not fully support Windows/WSL)
- Git installed
- Basic familiarity with command line operations
- Claude Pro subscription or Claude API access (for agent operation)

## 1. Clone the Repository

```bash
# Clone the Trinity Framework 2.0 Core repository
git clone https://github.com/trinity-framework/trinity-framework-core.git

# Navigate to the cloned repository
cd trinity-framework-core
```

## 2. Set Up Agent Workspaces

### Recommended Directory Structure

For optimal organization, we recommend creating agent workspaces at the same level as the cloned repository:

```
/home/user/
├── trinity-framework-core/       # Cloned repository
├── trinity-apex-workspace/       # APEX agent workspace
├── trinity-analyst-workspace/    # ANALYST agent workspace
└── trinity-historian-workspace/  # HISTORIAN agent workspace
```

This keeps the framework separate from the agent workspaces and avoids nesting, making it easier to manage and update each component independently.

### Option A: Create All Agent Workspaces (Recommended)

To create standardized workspaces for all three core agents (APEX, ANALYST, and HISTORIAN):

```bash
# Navigate to the setup directory
cd tools/setup

# Make scripts executable
chmod +x *.sh

# Create all agent workspaces at parent directory level
./create-workspaces.sh $(dirname $(pwd)/../../)

# Verify installation
./verify-installation.sh $(dirname $(pwd)/../../)/trinity-apex-workspace
```

This will create three complete workspaces at the same directory level as your cloned repository.

### Option B: Create All Agent Workspaces (Custom Location)

To create workspaces in a specific location:

```bash
# Navigate to the setup directory
cd tools/setup

# Make scripts executable
chmod +x *.sh

# Create all agent workspaces
./create-workspaces.sh ~/trinity-workspaces

# Verify installation
./verify-installation.sh ~/trinity-workspaces
```

This will create three complete workspaces:
- APEX workspace at `~/trinity-workspaces/trinity-apex-workspace`
- ANALYST workspace at `~/trinity-workspaces/trinity-analyst-workspace`
- HISTORIAN workspace at `~/trinity-workspaces/trinity-historian-workspace`

### Option C: Create a Single Agent Workspace

To create a workspace for a specific agent:

```bash
# Navigate to the setup directory
cd tools/setup

# Make scripts executable
chmod +x *.sh

# Create a specific agent workspace
./setup-apex.sh ~/trinity-apex-workspace      # For APEX agent
./setup-analyst.sh ~/trinity-analyst-workspace    # For ANALYST agent
./setup-historian.sh ~/trinity-historian-workspace  # For HISTORIAN agent

# Verify installation
./verify-installation.sh ~/trinity-apex-workspace  # Change path as needed
```

## 3. Explore Your Workspace

After setup, explore your new workspace:

```bash
# Navigate to the workspace
cd ~/trinity-apex-workspace  # Or the path you specified

# Verify protocol files
cat AGENT.md       # Agent identity and role
cat STATUS.md      # Current operational status
cat AUTO-COMPACT.md  # Context management information

# Explore the directory structure
ls -la
```

Your workspace should have this structure:

```
workspace/
├── AGENT.md
├── AUTO-COMPACT.md
├── STATUS.md
├── WORKSPACE-ORGANIZATION.md
├── AAR/
│   ├── incidents/
│   └── sessions/
├── projects/
├── reports/
├── tools/
├── checkpoints/
└── archives/
```

## 4. Optional: Install Context Management

The Trinity Framework 2.0 Core includes an optional context management system for tracking and visualizing context utilization. To install:

```bash
# Context tracking is already installed if you used the setup scripts
# To use it, run:
./tools/token-tracker/context-manager/bin/run-context-check.sh check
```

You should see output like:
```
[Context: 25% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~100 small operations
```

## 5. Create Your First AAR Session

After completing some work, document it in an AAR session:

```bash
# Create a new AAR session file
cp templates/aar/session-template.md AAR/sessions/$(date +%Y-%m-%d)-first-session.md

# Edit the file
nano AAR/sessions/$(date +%Y-%m-%d)-first-session.md
```

## 6. Next Steps

Congratulations! You've set up a Trinity Framework 2.0 Core workspace. Next steps:

- Read the [Framework Core Principles](../principles/context-resilience.md)
- Explore the [Agent Setup Guide](./agent-setup-guide.md)
- Learn about the [AAR System](../guides/aar-system.md)
- Review the [Protocol Files Reference](../reference/protocol-files.md)

## Troubleshooting

If you encounter issues:

- **Permission Errors**: Make sure scripts are executable with `chmod +x tools/setup/*.sh`
- **Directory Structure Issues**: Run `./tools/setup/verify-installation.sh [path]` to diagnose
- **Context Tracking Errors**: Check that Node.js is installed

---

*Framework 2.0 COMPLIANT*