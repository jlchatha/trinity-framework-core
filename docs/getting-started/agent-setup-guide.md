# Trinity Framework 2.0 Core - Agent Setup Guide

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

This guide provides detailed instructions for setting up and configuring the three core agent roles in Trinity Framework 2.0: APEX, ANALYST, and HISTORIAN. Each agent has a specific purpose and configuration requirements to ensure proper integration with the framework.

## Agent Roles Overview

Trinity Framework 2.0 Core defines three primary agent roles, each with unique responsibilities:

| Agent | Primary Role | Key Responsibilities |
|-------|-------------|----------------------|
| APEX | User Interface | Primary user interaction, task coordination, status reporting |
| ANALYST | System Improvement | Code analysis, feature implementation, bug fixing, optimization |
| HISTORIAN | Documentation | Knowledge management, documentation maintenance, protocol compliance |

## Common Setup Process

All agents share the same basic setup process using the provided scripts:

```bash
# Navigate to the setup directory
cd trinity-framework-core/tools/setup

# Make scripts executable
chmod +x *.sh

# Create agent workspace
./setup-[agent-name].sh [workspace_path]
```

Replace `[agent-name]` with `apex`, `analyst`, or `historian` and `[workspace_path]` with your desired workspace location.

## APEX Agent Setup

The APEX agent serves as the primary interface between the human operator and the Trinity system.

### 1. Create APEX Workspace

```bash
./setup-apex.sh ~/trinity/trinity-apex-workspace
```

### 2. Review and Customize AGENT.md

Open `~/trinity/trinity-apex-workspace/AGENT.md` in your editor and modify:

- The introduction section to reflect your specific system purpose
- Decision framework criteria based on your project needs
- Tools and script references to match your infrastructure
- Interaction protocols for your organization's requirements

### 3. Configure User Interface Settings

APEX agents require clear user interaction guidelines:

- Define acceptable input formats
- Set up response templates
- Configure communication protocols
- Establish escalation paths

### 4. Implement APEX-Specific Tools

Create APEX-specific tools in the `/tools` directory:

```bash
mkdir -p ~/trinity/trinity-apex-workspace/tools/user-interface
mkdir -p ~/trinity/trinity-apex-workspace/tools/task-management
mkdir -p ~/trinity/trinity-apex-workspace/tools/status-reporting
```

### 5. APEX Verification

Verify your APEX agent setup:

```bash
./verify-installation.sh ~/trinity/trinity-apex-workspace
```

## ANALYST Agent Setup

The ANALYST agent focuses on system improvement, code analysis, and implementation tasks.

### 1. Create ANALYST Workspace

```bash
./setup-analyst.sh ~/trinity/trinity-analyst-workspace
```

### 2. Review and Customize AGENT.md

Open `~/trinity/trinity-analyst-workspace/AGENT.md` in your editor and modify:

- Implementation focus areas
- Code analysis frameworks
- Quality metrics and standards
- Testing requirements

### 3. Configure Development Environment

ANALYST agents require development-specific configuration:

- Set up version control integration
- Configure build and test environments
- Define code review procedures
- Establish release workflows

### 4. Implement ANALYST-Specific Tools

Create ANALYST-specific tools in the `/tools` directory:

```bash
mkdir -p ~/trinity/trinity-analyst-workspace/tools/code-analysis
mkdir -p ~/trinity/trinity-analyst-workspace/tools/testing
mkdir -p ~/trinity/trinity-analyst-workspace/tools/implementation
```

### 5. ANALYST Verification

Verify your ANALYST agent setup:

```bash
./verify-installation.sh ~/trinity/trinity-analyst-workspace
```

## HISTORIAN Agent Setup

The HISTORIAN agent manages documentation and knowledge preservation.

### 1. Create HISTORIAN Workspace

```bash
./setup-historian.sh ~/trinity/trinity-historian-workspace
```

### 2. Review and Customize AGENT.md

Open `~/trinity/trinity-historian-workspace/AGENT.md` in your editor and modify:

- Documentation standards and formats
- Knowledge management protocols
- Archival procedures
- Protocol compliance monitoring

### 3. Configure Documentation Environment

HISTORIAN agents require documentation-specific configuration:

- Set up documentation generation tools
- Configure knowledge base integration
- Define archival workflows
- Establish documentation review processes

### 4. Implement HISTORIAN-Specific Tools

Create HISTORIAN-specific tools in the `/tools` directory:

```bash
mkdir -p ~/trinity/trinity-historian-workspace/tools/documentation
mkdir -p ~/trinity/trinity-historian-workspace/tools/knowledge-base
mkdir -p ~/trinity/trinity-historian-workspace/tools/protocol-compliance
```

### 5. HISTORIAN Verification

Verify your HISTORIAN agent setup:

```bash
./verify-installation.sh ~/trinity/trinity-historian-workspace
```

## Optional: Context Management Integration

For each agent, you can implement the optional context management system:

### 1. Create Context Management Directories

```bash
# For each agent workspace (replace [agent-type] with apex, analyst, or historian)
cd ~/trinity/trinity-[agent-type]-workspace
mkdir -p tools/token-tracker/context-manager/bin
mkdir -p tools/token-tracker/context-manager/state
mkdir -p tools/token-tracker/context-manager/checkpoints
```

### 2. Copy Context Management Tools

```bash
# Copy context management tools from framework repository
cp -r ~/trinity/trinity-framework-core/examples/context-tracking/* tools/token-tracker/
chmod +x tools/token-tracker/context-manager/bin/*.sh
```

### 3. Update Protocol Files

Update the relevant sections in each protocol file to include context tracking:

- AGENT.md: Uncomment the context tracking protocol section
- AUTO-COMPACT.md: Update the context metrics section
- STATUS.md: Enable the context health section

## Multi-Agent Integration

When running multiple agents as part of the same system:

### 1. Establish Communication Channels

Define how agents will communicate with each other:

```bash
# Create shared communication directory
mkdir -p ~/trinity/shared
chmod 777 ~/trinity/shared

# Create symbolic links in each workspace
ln -s ~/trinity/shared ~/trinity/trinity-apex-workspace/shared
ln -s ~/trinity/shared ~/trinity/trinity-analyst-workspace/shared
ln -s ~/trinity/shared ~/trinity/trinity-historian-workspace/shared
```

### 2. Configure Agent Awareness

Modify each agent's AGENT.md to include awareness of other agents:

```markdown
## Agent Ecosystem Awareness

You oversee the following agents:

1. **APEX** (`/path/to/trinity-apex-workspace/`)
   - User interface responsibilities
   - Task management

2. **ANALYST** (`/path/to/trinity-analyst-workspace/`)
   - Implementation responsibilities
   - System improvement

3. **HISTORIAN** (`/path/to/trinity-historian-workspace/`)
   - Documentation responsibilities
   - Knowledge management
```

### 3. Define Interaction Protocols

Create an AGENT-INTERACTION.md file in each workspace that defines:

- Communication formats
- Responsibility boundaries
- Collaboration workflows
- Escalation procedures

## Agent Customization Guidelines

When customizing agents for specific roles:

1. **Maintain Framework Compliance**: All changes must adhere to Framework 2.0 standards
2. **Preserve Protocol Files**: Keep the core protocol files intact and functional
3. **Respect Directory Structure**: Follow the standard workspace organization
4. **Document Customizations**: Create clear documentation for custom elements
5. **Verify After Customizing**: Run verification checks after customization

## Best Practices

### Protocol File Customization

- Keep the core recovery sections intact
- Only modify sections clearly marked for customization
- Document any customizations with comments
- Test recovery protocols after customization

### Workspace Organization

- Keep all protocol files in workspace root
- Limit root directory to 10 files maximum
- Organize project files in the `/projects` directory
- Keep documentation in the `/docs` or `/reports` directories

### Context Management

- Test context tracking before deploying to production
- Customize token estimates based on your actual usage
- Adjust thresholds if needed for your specific workflow
- Test recovery procedures regularly

## Next Steps

After setting up your agent workspaces:

1. Complete the [Verification Checklist](./verification-checklist.md)
2. Explore the [AAR System](../guides/aar-system.md) for documentation
3. Review the [Context Management](../guides/context-management.md) system if needed
4. Learn about [Auto-Compact Recovery](../guides/auto-compact-recovery.md)

---

*Framework 2.0 COMPLIANT*