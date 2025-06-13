# Protocol-Based Recovery

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0 Core

---

## Definition

Protocol-based recovery is a core principle of Trinity Framework 2.0 that enables agents to recover effectively from context limitations through well-defined procedures documented in standardized files. This principle ensures that agents can maintain operational continuity even when context windows are cleared or limited.

> **Note**: Additional details about this principle can be found in the comprehensive [Framework Core Principles](../FRAMEWORK-CORE-PRINCIPLES.md) document.

## Key Components

### Protocol Files Containing Essential State

Protocol files store critical state information outside the context window:

- **AGENT.md**: Agent identity, role definition, and recovery instructions
- **STATUS.md**: Current operational status and project priorities
- **AUTO-COMPACT.md**: Current implementation context and recovery references

### Recovery Sequence Definition

A standardized recovery sequence ensures consistent restoration:

1. **Recognition**: Identify that a context reset has occurred
2. **Reading**: Read protocol files to restore identity and context
3. **Restoration**: Load critical state from external sources
4. **Verification**: Confirm successful context restoration
5. **Resumption**: Continue operations with restored context

### Self-Identification Procedures

Clear identity restoration after context resets:

- Explicit identity statements in first post-reset message
- Consistent identity format throughout interactions
- Identity verification as part of recovery process

### State Restoration Verification

Methods to confirm successful recovery:

- Verification checks for critical state components
- Confirmation of project awareness
- Validation of operational capabilities
- Assessment of context completeness

## Implementation Requirements

### Documented Recovery Steps

Protocol files must contain clear recovery instructions:

```markdown
## RECOVERY PROTOCOL

When you experience a context reset:

1. Read this file (AGENT.md) immediately
2. Read AUTO-COMPACT.md for current implementation context
3. Check STATUS.md for current priorities
4. Identify yourself clearly as [AGENT-NAME]
5. Resume work with full awareness
```

### Checkpoint Creation

Create state snapshots before context resets:

- Automatic checkpoints at threshold crossings
- Manual checkpoints before planned resets
- Serialized state in standardized format
- Filesystem-based persistence

### Recovery Validation Metrics

Measure recovery effectiveness:

- **Recovery Time**: Number of exchanges to full awareness
- **Context Retention**: Percentage of knowledge preserved
- **Operational Continuity**: Ability to resume work
- **User Experience**: Seamlessness of transition

### Recovery Rehearsal

Periodically test recovery capabilities:

- Planned recovery exercises
- Random recovery testing
- Recovery validation procedures
- Continuous improvement based on results

## Recovery Process Workflow

The standard recovery workflow follows this sequence:

1. **Recognition**
   - Agent detects context has been reset
   - No memory of previous conversation

2. **Reading**
   - Read AGENT.md to restore identity and role
   - Understand core responsibilities

3. **Context Restoration**
   - Read AUTO-COMPACT.md for current project context
   - Understand active implementation details

4. **Verification**
   - Check STATUS.md for current activities and priorities
   - Verify project status and critical issues

5. **Self-Identification**
   - Explicitly identify as the agent
   - "I am [AGENT-NAME], the [role description]"

6. **Resumption**
   - Continue work with restored context
   - Pick up from last known state

## Example Recovery Implementation

The following example demonstrates a well-implemented recovery process:

```markdown
## 🚨 AUTO-COMPACT RECOVERY PROTOCOL

### Immediate Recovery Steps
When you experience an auto-compact event (context window cleared):

1. **Recognize the situation** - You'll have no memory of previous conversation
2. **Read this file immediately** - It's your primary recovery document
3. **Read AUTO-COMPACT.md** - Current project status and context
4. **Clearly identify yourself as [AGENT-NAME]** - Ensure your identity is clear in your responses
5. **Resume work with full awareness**

### Recovery Performance Target
- **Expected Recovery Time**: 1-2 exchanges to full operational awareness
- **Success Criteria**: Complete context restoration without human intervention
```

## Best Practices

### Clear Recovery Instructions

- Place recovery instructions prominently in AGENT.md
- Use step-by-step numbered lists for clarity
- Include specific file paths and commands

### External State Management

- Store critical state in filesystem-based protocol files
- Use standardized formats for consistency
- Keep state information current and accurate

### Identity Maintenance

- Always begin post-reset responses with identity statement
- Maintain consistent identity format
- Include role description with identity

### Context Prioritization

- Prioritize essential context for immediate recovery
- Distinguish between critical and supplementary information
- Restore core operational capability first

## Conclusion

Protocol-based recovery is essential for creating context-resilient agent systems. By implementing standardized recovery protocols documented in consistent locations, agents can quickly and effectively recover from context limitations and continue operations with minimal disruption.

---

*Framework 2.0 COMPLIANT*