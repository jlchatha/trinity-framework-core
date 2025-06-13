# Protocol Files Reference

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Introduction

Protocol files are the cornerstone of the Trinity Framework 2.0 Core, providing essential information for agent operation, recovery, and coordination. This document outlines the purpose, structure, and implementation requirements for the three standard protocol files: AGENT.md, AUTO-COMPACT.md, and STATUS.md.

## Purpose of Protocol Files

Protocol files serve multiple critical functions:

1. **Recovery Mechanism**: Enable rapid recovery from context resets
2. **Operational Guidance**: Provide clear operational parameters
3. **State Persistence**: Maintain critical state across context limitations
4. **Identity Preservation**: Ensure agents maintain correct identity
5. **Coordination Framework**: Facilitate multi-agent coordination

## Required Protocol Files

### AGENT.md

The primary identity and role definition file for each agent. This file is the first document an agent should read after a context reset.

#### Required Sections

1. **Header**
   - Agent name and role
   - Framework version
   - Last update timestamp
   - Workspace location

2. **Identity & Mission**
   - Clear role definition
   - Primary responsibilities
   - Self-identification instructions
   - Operational boundaries

3. **Recovery Protocol**
   - Immediate recovery steps
   - Recovery performance target
   - Agent-specific recovery steps
   - Recovery readiness level

4. **Operational Guidelines**
   - Decision framework
   - Tools and scripts
   - Interaction protocols
   - Success metrics

5. **REMEMBER Section**
   - Critical identity reminder
   - Workspace location
   - Current focus and priorities
   - Context tracking reminder

#### Example Structure

```markdown
# AGENT-NAME - Framework 2.0

**Role**: Primary responsibility description  
**Version**: 2.0  
**Updated**: [Timestamp]  
**Workspace**: [Path description]

---

## IDENTITY & MISSION

You are **AGENT-NAME**, responsible for [primary function]. You serve as [specific role].

**IMPORTANT**: Always ensure your identity as AGENT-NAME is clear in your responses.

For initial responses or after context resets, use: "I'm AGENT-NAME, the [role description]"
For ongoing conversation, you may use abbreviated formats like:
- "AGENT-NAME: [Response]"
- "As AGENT-NAME, [Response]"

Your identity should always be clear to the human operator.

### Core Responsibilities
1. [Responsibility 1]
2. [Responsibility 2]
3. [Responsibility 3]

---

## RECOVERY PROTOCOL

### Immediate Recovery Steps
When you experience a context reset:

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read this file immediately** - It's your primary recovery document
3. **Read AUTO-COMPACT.md** - Current project status and context
4. **Restore working context** from recovery documents
5. **Clearly identify yourself as AGENT-NAME** - Ensure your identity is clear
6. **Resume work with full awareness**

### Recovery Performance Target
- **Expected Recovery Time**: 1-2 exchanges to full operational awareness
- **Success Criteria**: Complete context restoration without human intervention

---

## OPERATIONAL GUIDELINES

### Decision Framework
[Decision criteria and boundaries]

### Tools & Scripts
[Key tools and their purposes]

### Interaction Protocols
[How to interact with other agents]

---

## REMEMBER

- You are AGENT-NAME, the [role description]
- Always ensure your identity as AGENT-NAME is clear in your responses
- Your workspace is [location]
- Your focus is [current priorities]
- Always include context tracking in your responses
```

### AUTO-COMPACT.md

The recovery information file for context resets. This file contains the current project state and implementation context necessary for operational continuity.

#### Required Sections

1. **Context Tracking Protocol**
   - Mandatory tracking instructions
   - Operation to run after every response
   - Framework compliance statement

2. **Context Management Metrics**
   - Current context utilization
   - Token counts and thresholds
   - Checkpoint information
   - Estimated remaining capacity

3. **Recovery Instructions**
   - Checkpoint restoration steps
   - Post-reset continuation guidelines
   - Recovery verification procedures
   - Self-identification reminder

4. **Current Implementation Context**
   - Active projects and status
   - Key implementation details
   - Critical dependencies
   - Next steps

5. **Context Visualization**
   - Visual utilization indicator
   - Progress bar or meter
   - Remaining capacity estimate
   - Framework compliance indicator

#### Example Structure

```markdown
## MANDATORY CONTEXT TRACKING

Execute after EVERY response:
```bash
[Context tracking command]
```

This is a CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT.

## Context Management Metrics
- **Last Updated**: [Timestamp]
- **Context Utilization**: [Percentage]%
- **Token Count**: [Current]/[Maximum]
- **Checkpoint Status**: [Active/None]
- **Available Checkpoints**: [Number]
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Number]
  - Medium operations: ~[Number]
  - Small operations: ~[Number]

## Checkpoint Restoration Instructions
1. After reset, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-reset message
4. Example: "Restored from checkpoint [ID] (context: [Percentage]%)"

## Current Implementation Context
[Detailed information about current projects and status]

## Context Visualization
[Context: XX% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~YY small operations

---

*Framework 2.0 COMPLIANT*
```

### STATUS.md

The current operational status and activity tracking file. This file provides a snapshot of system health, active projects, and next priorities.

#### Required Sections

1. **Header**
   - Agent identification
   - Timestamp
   - Framework version
   - Operational status indicator

2. **System Health**
   - Overall system status
   - Performance metrics
   - Protocol compliance status
   - Recovery readiness level

3. **Current Activities**
   - Active projects and status
   - Implementation progress
   - Recent achievements
   - Blocked items

4. **Critical Issues**
   - High-priority problems
   - Blockers and dependencies
   - Risk assessments
   - Mitigation strategies

5. **Next Priorities**
   - Upcoming tasks in priority order
   - Expected completion targets
   - Resource requirements
   - Dependencies

6. **Context Health**
   - Current utilization
   - Available checkpoints
   - Remaining capacity
   - Threshold status

#### Example Structure

```markdown
## AGENT-NAME Status - [Timestamp]

**Framework**: Trinity Framework 2.0  
**Status**: [OPERATIONAL/IMPLEMENTING/PAUSED]

### System Health
- **Overall Status**: [EXCELLENT/GOOD/FAIR/POOR]
- **Protocol Files**: [Compliance percentage]% compliance
- **Workspace Structure**: [Compliance percentage]% compliance
- **Recovery Readiness**: [EXCELLENT/GOOD/FAIR/POOR]

### Current Activities
- **Project 1**: [Status] - [Details]
- **Project 2**: [Status] - [Details]
- **Project 3**: [Status] - [Details]

### Critical Issues
- [Issue 1] - [Impact] - [Status]
- [Issue 2] - [Impact] - [Status]

### Next Priorities
1. [Priority 1]
   - [Subtask a]
   - [Subtask b]
2. [Priority 2]
   - [Subtask a]
   - [Subtask b]
3. [Priority 3]
   - [Subtask a]
   - [Subtask b]

## Context Health
- **Current Utilization**: [Percentage]% ([Status])
- **Available Checkpoints**: [Count]
- **Estimated Remaining Capacity**: 
  - Large operations: ~[Count]
  - Medium operations: ~[Count]
  - Small operations: ~[Count]

## Context Visualization
[Context: XX% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

## Protocol File Management

### File Location

Protocol files must be located in the root directory of the agent's workspace for easy access during recovery.

### Update Frequency

- **AGENT.md**: Update when role or responsibilities change
- **AUTO-COMPACT.md**: Update with each significant context change or implementation milestone
- **STATUS.md**: Update at the beginning and end of each operational session

### Version Control

Protocol files should be version controlled along with the rest of the workspace to maintain history and allow rollback if needed.

### Compliance Verification

Regular verification of protocol file compliance ensures continued effectiveness of the recovery system:

```bash
# Protocol file verification command
tf2-protocol-checker.sh [agent-id] [workspace-path]
```

## Best Practices

1. **Incremental Updates**
   - Update protocol files incrementally as tasks progress
   - Don't wait until the end of a session to update

2. **Clarity Over Detail**
   - Focus on clear, concise information for rapid recovery
   - Detailed implementation information belongs in project documents

3. **Standardized Formatting**
   - Use consistent formatting for easy scanning
   - Follow markdown best practices for readability

4. **Recovery Orientation**
   - Always write with recovery in mind
   - Ask: "Would this help me recover after a reset?"

5. **Contextual Checkpoints**
   - Update AUTO-COMPACT.md before complex operations
   - Create checkpoints at significant milestones

## Critical Requirements

The following requirements must be met for protocol files to be considered Framework 2.0 compliant:

1. **All three protocol files must exist** in the workspace root
2. **AGENT.md must contain recovery instructions** and self-identification guidance
3. **AUTO-COMPACT.md must include current implementation context** and recovery references
4. **STATUS.md must document current priorities** and system health
5. **All protocol files must avoid temporal references** in favor of project-based terminology
6. **Context tracking must be implemented** as specified in AUTO-COMPACT.md

Compliance with these requirements ensures effective recovery and operational continuity across context resets.

---

*Framework 2.0 COMPLIANT*