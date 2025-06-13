# Trinity Framework 2.0 Core

**VERSION**: 1.0.0  
**CREATED**: June 13, 2025  
**STATUS**: Release Candidate  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Overview

Trinity Framework 2.0 Core is a standardized operational framework for building context-resilient agent systems. It provides a set of principles, protocols, and tools for creating agent workspaces that maintain operational continuity across context resets.

## Core Principles

1. **Context Resilience**: Maintain operational continuity across context resets through standardized recovery mechanisms.
2. **Workspace Standardization**: Follow consistent file structure patterns for predictable organization.
3. **Protocol-Based Recovery**: Implement standardized procedures for recovery from context limitations.
4. **Systematic Documentation**: Document operations in standardized formats and locations.
5. **Operational Autonomy**: Enable agents to operate independently within their domain expertise.

## Repository Contents

### Documentation

- `/docs/principles/context-resilience.md`: Maintaining operational continuity across context resets
- `/docs/principles/workspace-standardization.md`: Consistent file structure patterns
- `/docs/principles/protocol-recovery.md`: Standardized recovery procedures
- `/docs/principles/systematic-documentation.md`: Documentation standards and practices
- `/docs/principles/operational-autonomy.md`: Independent agent operation guidelines

- `/docs/reference/protocol-files.md`: Detailed guide to protocol file implementation
- `/docs/reference/agent-roles.md`: Agent role definitions and responsibilities
- `/docs/reference/terminology-reference.md`: Framework terminology and concepts

- `/docs/guides/aar-system.md`: After Action Review system for context preservation
- `/docs/guides/auto-compact-recovery.md`: Recovery from context limitations
- `/docs/guides/context-management.md`: Basic context management overview

- `/docs/advanced/context-management.md`: Detailed context tracking and management implementation
- `/docs/advanced/agent-collaboration.md`: Multi-agent collaboration patterns
- `/docs/advanced/interactive-token-tracking.md`: Advanced context tracking techniques

- `/docs/getting-started/framework-setup.md`: Setting up the framework environment
- `/docs/getting-started/quick-start.md`: Getting started with the framework
- `/docs/getting-started/agent-setup-guide.md`: Detailed agent setup procedures
- `/docs/getting-started/verification-checklist.md`: Installation verification steps

### Tools

- `/tools/setup/`: Workspace setup scripts for different agent roles
  - `create-workspaces.sh`: Main script for creating all agent workspaces
  - `setup-apex.sh`: APEX agent workspace setup
  - `setup-analyst.sh`: ANALYST agent workspace setup
  - `setup-historian.sh`: HISTORIAN agent workspace setup
  - `verify-installation.sh`: Verification tool for workspace setup
  - `install-dependencies.sh`: Script for automated dependency installation
  
- `/tools/context-meter/`: Context visualization tools
  - `context-meter.js`: Text-based context visualization

- `/tools/token-tracker/`: Token tracking and checkpoint management
  - `token-counter.js`: Token usage estimation
  - `checkpoint-manager.js`: State checkpoint management

- `/tools/recovery/`: Recovery tools
  - `auto-compact-detector.js`: Tool for detecting context resets

### Templates

- `/templates/protocol-files/`: Protocol file templates
  - `AGENT-template.md`: Template for AGENT.md
  - `AUTO-COMPACT-template.md`: Template for AUTO-COMPACT.md
  - `STATUS-template.md`: Template for STATUS.md

- `/templates/aar/`: AAR system templates
  - `session-template.md`: Template for session AAR documents
  - `incident-template.md`: Template for incident AAR documents

### Examples

- `/examples/basic-workspace/`: Basic workspace example with protocol files
- `/examples/agent-specific/`: Role-specific examples for each agent type
- `/examples/context-tracking/`: Context tracking implementation examples
- `/examples/recovery-examples/`: Auto-compact recovery examples

## Getting Started

### Claude API Requirements

Trinity Framework 2.0 Core is designed to work with Claude AI models. To use this framework, you'll need:

- **Claude Pro subscription** OR **Claude API access**
- **API Key**: If using Claude API, set your key in the environment with:
  ```bash
  export CLAUDE_API_KEY=your_api_key_here
  ```
- **Claude Version**: Framework is optimized for Claude 3.5 Sonnet or newer
- **Context Window**: Requires a model with at least 180K token context

Without Claude access, you can still explore the repository and documentation, but functional agent operation requires Claude API integration.

### Setting Up Agent Workspaces

The fastest way to set up Trinity Framework 2.0 Core is using the provided setup scripts:

```bash
# 1. Clone this repository
git clone [repository-url] trinity-framework-core

# 2. Navigate to the setup directory
cd trinity-framework-core/tools/setup

# 3. Make scripts executable
chmod +x *.sh
```

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

```bash
# 4. Create all agent workspaces at parent directory level (RECOMMENDED)
./create-workspaces.sh $(dirname $(pwd)/../../)

# 5. Verify installation
./verify-installation.sh $(dirname $(pwd)/../../)/trinity-apex-workspace
```

Alternatively, you can specify a custom location:

```bash
# Create all agent workspaces in a specific location
./create-workspaces.sh ~/trinity-workspaces
```

### Manual Setup

For more control over the setup process, you can manually create workspaces:

```bash
# Setup individual agent workspaces
./setup-apex.sh [workspace_path]
./setup-analyst.sh [workspace_path]
./setup-historian.sh [workspace_path]
```

### Using the Framework

Once set up, Trinity Framework 2.0 Core provides:

1. **Protocol Files**: Standard files for agent identity and recovery
2. **Workspace Structure**: Consistent organization for files and projects
3. **Context Management**: Token tracking and visualization
4. **Recovery Mechanisms**: Checkpoint creation and restoration
5. **Documentation System**: Templates for effective documentation

## Key Features

### Protocol Files

Three essential protocol files form the foundation of every agent workspace:

- **AGENT.md**: Agent identity, role definition, and recovery instructions
- **AUTO-COMPACT.md**: Context management metrics and recovery references
- **STATUS.md**: Current operational status and priorities

### Optional Context Management System

An optional enhancement for monitoring and managing context utilization:

- Token tracking with standardized operation types
- Context visualization with threshold notifications
- Checkpoint creation at key thresholds
- Recovery protocol for context resets
- Auto-compact detection

*Note: Context tracking is provided as an optional enhancement that can be implemented based on your specific needs.*

### Agent Identity Protocol

Clear self-identification guidelines to prevent identity confusion:

- Explicit identity statements in all responses
- Multiple format options for natural conversation
- Identity verification during recovery
- Protocol file implementation requirements

### Workspace Organization

Standardized workspace structure for consistent organization:

- Limited root directory files (maximum 10)
- Required directories for specific content types
- File naming conventions for consistency
- Directory purpose documentation

### AAR System

Structured knowledge preservation mechanism for continuous learning:

- Session AARs for regular work documentation
- Incident AARs for comprehensive issue analysis
- Standardized templates for consistency
- Recovery-oriented documentation

## Success Metrics

A successful implementation of Trinity Framework 2.0 Core achieves:

- **Recovery Time**: ≤1.0 exchanges to full operational awareness
- **Context Retention**: ≥90% knowledge preservation across resets
- **Response Time**: ≤500ms for standard operations
- **Task Completion**: ≥95% successful completion rate
- **Protocol Compliance**: 100% on critical requirements

## Platform Support

- **Supported**: Linux and macOS
- **Not Supported**: Windows (due to Claude Code limitations)

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

---

*Framework 2.0 COMPLIANT*