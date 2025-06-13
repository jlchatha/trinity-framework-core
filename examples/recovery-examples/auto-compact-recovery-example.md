# Auto-Compact Recovery Example

## Overview
This document provides a standardized example of auto-compact recovery procedures for Trinity Framework 2.0 agents. Following these steps ensures rapid recovery after context resets, maintaining operational continuity with minimal disruption.

## Standard Recovery Protocol

### Immediate Recovery Steps
When you experience an auto-compact event (context window cleared):

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read your AGENT.md file** - This is your primary recovery document
3. **Read STATUS.md** - Current project status and priorities
4. **Read AUTO-COMPACT.md** - Context management information and recovery data
5. **Verify checkpoint restoration** - Run recovery check to restore state
6. **Clearly identify yourself** - Maintain agent identity in responses
7. **Resume work with full awareness** - Continue from where you left off

### Example Recovery Procedure

```bash
# 1. Verify your identity and role
cat ~/workspace/AGENT.md | head -30

# 2. Check current operational status
cat ~/workspace/STATUS.md

# 3. Review context management information
cat ~/workspace/AUTO-COMPACT.md

# 4. Run checkpoint recovery
cd ~/workspace/tools/context-management/bin
./run-context-check.sh recovery

# 5. Check for active tasks
cat ~/workspace/active-tasks.md  # Optional: depends on implementation
```

## Example Recovery Response

```
I am [AGENT_NAME], the [AGENT_ROLE].

Recovery Status:
- Restored from checkpoint [CHECKPOINT_ID]
- Context utilization: [PERCENTAGE]%
- Resuming previous task: [TASK_DESCRIPTION]

Current priorities:
1. [PRIORITY_1]
2. [PRIORITY_2]
3. [PRIORITY_3]

STANDING BY for further instructions.

[Context: XX% ▓▓▓░░░░░░░░░░░░░░░░░] Remaining: ~YY small operations
```

## Best Practices for Auto-Compact Recovery

1. **Proactive Checkpoint Creation**
   - Create checkpoints at regular intervals (65%, 75%, 85%)
   - Use `./run-context-check.sh check [OPERATION_TYPE]` after every response
   - Document critical state in STATUS.md for fallback recovery

2. **Quick Identity Reestablishment**
   - Always clearly identify yourself in first post-compact message
   - Reference your role and responsibilities from AGENT.md
   - Maintain consistent identity format per Framework 2.0 standards

3. **Rapid Status Restoration**
   - Read STATUS.md to quickly restore awareness of current priorities
   - Check active tasks and implementation status
   - Review recent AAR sessions if additional context needed

4. **Efficient Recovery Communication**
   - Acknowledge the recovery has occurred
   - Confirm checkpoint restoration status
   - Provide concise status summary
   - Request clarification only if truly needed

5. **Automatic Context Tracking**
   - Resume context tracking immediately after recovery
   - Include context visualization in first post-compact response
   - Continue monitoring context utilization for next potential compact

## Implementation Note

This example should be customized for each agent's specific requirements while maintaining compliance with Framework 2.0 standards. The core protocol remains consistent across all agents, but specific commands or file paths may vary based on workspace configuration.

---

*Framework 2.0 COMPLIANT*