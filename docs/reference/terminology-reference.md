# Terminology Reference

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

Trinity Framework 2.0 Core uses standardized terminology to ensure clear communication and context resilience across agent systems. This reference document defines the standard terms used throughout the framework, with a focus on project-based terminology that replaces temporal references.

## Project-Based Terminology

Trinity Framework 2.0 replaces time-based references with project-based terminology to ensure context resilience. This mapping provides a standardized way to refer to operational cycles and project segments.

| Temporal Term | Project Term | Definition | Typical Duration |
|--------------|--------------|------------|------------------|
| Daily | UNIT | Atomic operational cycle | 1 rotation |
| Weekly | MILESTONE | Achievement checkpoint | 7 units |
| Biweekly | ITERATION | Process improvement cycle | 14 units |
| Monthly | PHASE | Major project segment | 4 milestones |
| Quarterly | PROJECT | Complete initiative | 3 phases |

## Core Framework Terminology

### Agent Types

- **APEX**: Strategic direction and architecture agent
- **ANALYST**: Data analysis and optimization agent
- **HISTORIAN**: Documentation and knowledge management agent

### Protocol Files

- **AGENT.md**: Agent identity and role definition file
- **STATUS.md**: Current operational status and priorities file
- **AUTO-COMPACT.md**: Context management and recovery information file

### System Components

- **AAR System**: After Action Review documentation system for learning and context preservation
- **Context Management System**: Optional system for tracking and visualizing context utilization
- **Protocol-Based Recovery**: Standardized recovery mechanism for context resets
- **Workspace Standardization**: Consistent file structure and organization

## Context Management Terminology

### Context States

- **Utilization**: Percentage of context window currently in use
- **Checkpoint**: Serialized state snapshot for recovery
- **Threshold**: Defined utilization level triggering actions
- **Auto-Compact**: Context reset process to clear window

### Threshold Levels

- **Notice** (65%): First level threshold creating checkpoint
- **Warning** (75%): Second level threshold with caution notification
- **Alert** (85%): Critical threshold offering auto-compact

### Operation Types

#### User Messages
- **USER_SMALL**: Brief messages (~750 tokens)
- **USER_MEDIUM**: Standard messages (~2200 tokens)
- **USER_LARGE**: Detailed messages (~4400 tokens)

#### Assistant Responses
- **ASSISTANT_SMALL**: Brief responses (~1500 tokens)
- **ASSISTANT_MEDIUM**: Standard responses (~4400 tokens)
- **ASSISTANT_LARGE**: Detailed responses (~10000 tokens)

#### Tool Operations
- **TOOL_READ_SMALL**: Small file reads (~1500 tokens)
- **TOOL_READ_MEDIUM**: Medium file reads (~4400 tokens)
- **TOOL_READ_LARGE**: Large file reads (~7500 tokens)
- **TOOL_WRITE**: File writing operations (~750 tokens)
- **TOOL_EDIT**: File editing operations (~1500 tokens)
- **TOOL_TASK**: Task tool executions (~6000 tokens)

## Workspace Terminology

### Directory Structure

- **/AAR/**: After Action Review documentation
- **/projects/**: Active project implementation files
- **/reports/**: Generated reports and documentation
- **/archives/**: Archived implementation artifacts
- **/tools/**: Utility scripts and tools
- **/checkpoints/**: Context recovery checkpoints

### File Naming Conventions

- **Protocol Files**: UPPERCASE-WITH-HYPHENS.md
- **Session AARs**: YYYY-MM-DD-description.md
- **Incident AARs**: DESCRIPTIVE-NAME-RCA.md
- **Scripts**: verb-noun.sh or verb-noun.js

## Recovery Terminology

### Recovery States

- **Recognition**: Identification of context reset
- **Identity Restoration**: Regaining agent identity
- **Context Loading**: Retrieving implementation context
- **Work Resumption**: Continuing operations with recovered context

### Recovery Metrics

- **Recovery Time**: Exchanges needed for full operational awareness
- **Context Retention**: Percentage of knowledge preserved across resets
- **Recovery Completeness**: Degree of state restoration

## Success Metrics Terminology

- **Recovery Time**: ≤1.0 exchanges to full operational awareness
- **Context Retention**: ≥90% knowledge preservation across resets
- **Response Time**: ≤500ms for standard operations
- **Task Completion**: ≥95% successful completion rate
- **Protocol Compliance**: 100% on critical requirements

## Conclusion

This terminology reference provides a standardized vocabulary for working with Trinity Framework 2.0 Core. Consistent use of these terms ensures clear communication, effective documentation, and operational resilience across context limitations.

---

*Framework 2.0 COMPLIANT*