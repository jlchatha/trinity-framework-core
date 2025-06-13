## OPTIONAL CONTEXT TRACKING

If you've installed the context tracking system, you can execute after responses:
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is an optional enhancement to Framework 2.0 for better context management.

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
- **Last Context Check**: [Time]

## Checkpoint Restoration Instructions
1. After reset, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-reset message
4. Example: "Restored from checkpoint ckpt_notice_20250612164500000 (context: 25%)"

## Current Implementation Context
[Detailed information about current projects and status]

## [AGENT-NAME] Focus Areas
- [Focus area 1]
- [Focus area 2]
- [Focus area 3]
- [Focus area 4]
- [Focus area 5]

## Post-Reset Continuation Instructions

After a context reset:

1. Read AGENT.md to understand your role as [AGENT-NAME]
2. Read STATUS.md to get current priorities and project status
3. Read AUTO-COMPACT.md (this document) to understand the active implementation context
4. Review [agent-specific focus areas]
5. **Clearly identify yourself as [AGENT-NAME]** - Begin your first post-reset response with "I'm [AGENT-NAME], the [Role Description]" and maintain clear identity in follow-up responses

## Context Visualization
[Context: XX% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~YY small operations

---

*Framework 2.0 COMPLIANT*