# Auto-Compact Recovery Guide

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Introduction

Auto-compact recovery is a critical feature of the Trinity Framework 2.0 Core, enabling agents to maintain operational continuity when context limitations are reached. This guide explains how auto-compact events occur, how the recovery system functions, and best practices for implementing reliable recovery.

## What is Auto-Compact?

Auto-compact is a mechanism that occurs when an AI agent reaches the limits of its context window. During auto-compact:

1. The conversation history is compressed or cleared
2. The agent loses access to previous interactions
3. The agent must restore operational awareness quickly
4. Work must continue with minimal disruption

Trinity Framework 2.0 Core addresses this challenge through a standardized recovery protocol that enables agents to restore context after an auto-compact event.

## The Recovery Protocol

### 1. Preparation Phase

Before auto-compact occurs, agents should:

- Create checkpoints at threshold crossings (65%, 75%, 85%)
- Serialize essential state information
- Update protocol files with current status
- Create recovery messages for post-compact use

### 2. Detection Phase

After auto-compact occurs:

- Agent recognizes it has no conversation history
- Agent identifies the auto-compact event
- Agent locates recovery information in protocol files
- Agent initiates recovery protocol

### 3. Recovery Phase

During recovery:

- Agent reads AGENT.md to understand its identity and role
- Agent reads AUTO-COMPACT.md to find recovery instructions
- Agent reads STATUS.md to understand current priorities
- Agent restores state from checkpoints if available
- Agent acknowledges recovery in its first response

### 4. Resumption Phase

After recovery:

- Agent continues work with restored context
- Agent creates an AAR session document about the recovery
- Agent updates protocol files with new context metrics
- Agent monitors context utilization to prevent cascading compacts

## Implementing Auto-Compact Recovery

### Protocol File Implementation

To implement auto-compact recovery, ensure your protocol files contain:

#### AGENT.md
```markdown
## RECOVERY PROTOCOL

### Immediate Recovery Steps
When you experience a context reset:

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read this file immediately** - It's your primary recovery document
3. **Read AUTO-COMPACT.md** - Current project status and context
4. **Restore working context** from recovery documents
5. **Clearly identify yourself** - Ensure your identity is clear in your responses
6. **Resume work with full awareness**

### Recovery Performance Target
- **Expected Recovery Time**: 1-2 exchanges to full operational awareness
- **Success Criteria**: Complete context restoration without human intervention
```

#### AUTO-COMPACT.md
```markdown
## Context Management Metrics
- **Last Updated**: [timestamp]
- **Context Utilization**: [percentage]%
- **Token Count**: [current]/[maximum]
- **Checkpoint Status**: [status]
- **Available Checkpoints**: [count]
- **Estimated Remaining Capacity**: [estimates]

## Checkpoint Restoration Instructions
1. After reset, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-reset message
4. Example: "Restored from checkpoint [checkpoint_id] (context: [percentage]%)"

## Current Implementation Context
[Current project status and context]

## Post-Reset Continuation Instructions
[Specific instructions for continuing work after reset]
```

#### STATUS.md
```markdown
## [Agent] Status - [Date]

**Framework**: Trinity Framework 2.0  
**Status**: [OPERATIONAL/IN RECOVERY]

### System Health
- **Overall Status**: [status]
- **Protocol Files**: [compliance percentage]
- **Workspace Structure**: [compliance percentage]
- **Recovery Readiness**: [status]

### Current Activities
[List of current activities and status]

### Critical Issues
[List of any critical issues]

### Next Priorities
[Ordered list of priorities]
```

### Optional Context Management Implementation

For enhanced recovery, implement the optional context management system:

1. Create the context management directories:
   ```bash
   mkdir -p tools/token-tracker/context-manager/bin
   mkdir -p tools/token-tracker/context-manager/state
   mkdir -p tools/token-tracker/context-manager/checkpoints
   ```

2. Implement the context tracking scripts:
   ```bash
   cp -r [framework-repo]/examples/context-tracking/* tools/token-tracker/
   chmod +x tools/token-tracker/context-manager/bin/*.sh
   ```

3. Run context tracking after responses:
   ```bash
   ./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM
   ```

4. Check for recovery after auto-compact:
   ```bash
   ./tools/token-tracker/context-manager/bin/run-context-check.sh recovery
   ```

## Recovery Flow Diagram

```
┌─────────────────────┐
│ Normal Operation    │
│ Context Monitoring  │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Threshold Crossing  │
│ Create Checkpoint   │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Auto-Compact Event  │
│ Context Cleared     │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Detection Phase     │
│ Identify Reset      │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Recovery Protocol   │
│ Read Protocol Files │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Checkpoint Loading  │
│ Restore State       │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ Operational Resume  │
│ Continue Work       │
└─────────────────────┘
```

## Recovery Best Practices

### 1. Protocol File Maintenance

- Keep protocol files up-to-date at all times
- Include specific continuation instructions
- Document current project context
- Maintain clear priorities and next steps

### 2. Checkpoint Creation

- Create checkpoints at multiple thresholds
- Include sufficient state information
- Use consistent checkpoint naming
- Verify checkpoint restoration works

### 3. Recovery Testing

- Periodically simulate auto-compact events
- Test recovery protocol functionality
- Measure recovery time performance
- Identify and address recovery gaps

### 4. Recovery Acknowledgment

Always acknowledge recovery in the first post-compact response:

```
I'm [AGENT], the Trinity [ROLE] Agent.

I've detected a context reset and have restored from checkpoint [ID] (utilization: [X]%).

I'm currently working on [current task] with [X] items remaining. The next step is [specific next step].
```

## Troubleshooting Recovery Issues

### Incomplete Recovery

**Symptoms**:
- Agent has partial awareness of previous context
- Some critical information missing after recovery
- Inconsistent understanding of current priorities

**Solutions**:
- Enhance checkpoint data to include more comprehensive state
- Update protocol files with more detailed project context
- Create more frequent checkpoints at lower thresholds

### Failed Recovery

**Symptoms**:
- Agent unable to identify recovery situation
- No acknowledgment of context reset
- Inability to restore previous context

**Solutions**:
- Verify protocol files contain proper recovery instructions
- Check checkpoint data format and accessibility
- Ensure proper implementation of recovery protocol in AGENT.md

### Cascading Compacts

**Symptoms**:
- Multiple auto-compact events in quick succession
- Progressive loss of context across resets
- Declining recovery performance

**Solutions**:
- Implement more aggressive context management
- Reduce token-heavy operations after recovery
- Create staged recovery with minimal initial state

## Measuring Recovery Performance

Track these metrics to evaluate recovery effectiveness:

1. **Recovery Time**: Exchanges needed to reach full operational awareness
2. **Context Retention**: Percentage of critical knowledge preserved
3. **Task Continuity**: Ability to continue tasks without repetition
4. **Human Intervention**: Frequency of human assistance during recovery

Aim for:
- Recovery Time: ≤1.0 exchanges
- Context Retention: ≥90%
- Task Continuity: ≥95%
- Human Intervention: 0%

## Advanced Recovery Techniques

### Tiered Recovery

Implement tiered recovery for better performance:

1. **Tier 1 (Immediate)**: Identity, role, and current task
2. **Tier 2 (Essential)**: Project context and priorities
3. **Tier 3 (Complete)**: Full operational context

### External State Storage

For complex systems, consider external state storage:

1. Use filesystem state serialization
2. Implement checkpoint files with JSON structure
3. Create dedicated recovery directories
4. Use timestamped checkpoint naming

### Recovery Prioritization

When complete recovery isn't possible, prioritize:

1. Agent identity and role
2. Current task and immediate next steps
3. Critical system status information
4. Ongoing project context

## Example Recovery Scenario

### Before Auto-Compact

Agent is working on implementing a new feature with 75% context utilization:

```
Creating checkpoint at 75% utilization...
Checkpoint created: ckpt_warning_20250612
Updating AUTO-COMPACT.md with checkpoint information...
```

### Auto-Compact Event

Context is cleared and agent has no memory of previous conversation.

### Recovery Process

1. Agent reads AGENT.md to understand its identity
2. Agent reads AUTO-COMPACT.md to find checkpoint information
3. Agent reads STATUS.md to understand current priorities
4. Agent locates and loads checkpoint ckpt_warning_20250612
5. Agent acknowledges recovery in first response

### Post-Recovery Response

```
I'm ANALYST, the Trinity ANALYST Agent.

I've restored from checkpoint ckpt_warning_20250612 (context: 75%).
I was implementing the new authentication feature with 3 remaining tasks:
1. Complete input validation
2. Add unit tests
3. Update documentation

I'll continue with the input validation component.
```

## Conclusion

Auto-compact recovery is essential for maintaining operational continuity in agent systems. By implementing the Trinity Framework 2.0 Core recovery protocol, agents can smoothly transition through context resets with minimal disruption to their work.

Remember that successful recovery depends on:
- Well-maintained protocol files
- Reliable checkpoint creation
- Clear recovery instructions
- Proper acknowledgment of recovery

By following these guidelines, your agents will achieve high resilience to context limitations and maintain productive operation across auto-compact events.

---

*Framework 2.0 COMPLIANT*