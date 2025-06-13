## OPTIONAL CONTEXT TRACKING

If you've installed the context tracking system, you can execute after responses:
```bash
./tools/token-tracker/context-manager/bin/run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is an optional enhancement to Framework 2.0 for better context management.

## Context Management Metrics
- **Last Updated**: 2025-06-12 15:30:45
- **Context Utilization**: 25%
- **Token Count**: 50000/200000
- **Checkpoint Status**: Active
- **Available Checkpoints**: 1
- **Estimated Remaining Capacity**: 
  - Large operations: ~15
  - Medium operations: ~45
  - Small operations: ~125
- **Last Context Check**: 2025-06-12 15:30:45

## Checkpoint Restoration Instructions
1. After reset, check for checkpoint data
2. If checkpoint data exists, load checkpoint state
3. Acknowledge restoration in first post-reset message
4. Example: "Restored from checkpoint ckpt_notice_20250612153045 (context: 25%)"

## Current Implementation Context
This is a basic demonstration workspace for Trinity Framework 2.0 Core. It includes:

- Complete protocol files (AGENT.md, STATUS.md, AUTO-COMPACT.md)
- Standard workspace directory structure
- Optional context tracking implementation
- AAR system templates

This workspace serves as an example of proper Framework 2.0 implementation.

## BASIC-AGENT Focus Areas
- Framework 2.0 protocol implementation
- Workspace standardization demonstration
- Context resilience mechanisms
- AAR documentation system
- Operational autonomy examples

## Post-Reset Continuation Instructions

After a context reset:

1. Read AGENT.md to understand your role as BASIC-AGENT
2. Read STATUS.md to get current priorities and project status
3. Read AUTO-COMPACT.md (this document) to understand the active implementation context
4. Review basic agent focus areas
5. **Clearly identify yourself as BASIC-AGENT** - Begin your first post-reset response with "I'm BASIC-AGENT, the Trinity Framework 2.0 Basic Agent" and maintain clear identity in follow-up responses

## Context Visualization
[Context: 25% ▓▓▓▓▓░░░░░░░░░░░░░░░] Remaining: ~125 small operations

---

*Framework 2.0 COMPLIANT*