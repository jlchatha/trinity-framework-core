# Checkpoint File-Based Storage Decision

**Date**: June 2025  
**Decision**: Use JSON files for checkpoint storage instead of database  
**Status**: Implemented  

## Context

**Q: "Why does Trinity store checkpoints as JSON files rather than in a database?"**

**A:** File-based JSON storage was chosen for checkpoint persistence to maintain transparency, simplicity, and recovery reliability. JSON files can be manually inspected, edited if corrupted, backed up trivially, and accessed without running services. This aligns with Trinity's philosophy of human-readable, recoverable systems that work even when things go wrong.

## Evidence

From tools/token-tracker/checkpoint-manager.js:
- "Automatic Pruning: Keeps only the 3 most recent checkpoints"
- "File-Based Storage: JSON files for simplicity and transparency"
- Checkpoint files stored in checkpoints/ directory with timestamp naming

Example checkpoint structure:
```json
{
  "id": "ckpt_20250626_123456",
  "timestamp": "2025-06-26T12:34:56Z",
  "utilization": 75,
  "tokens": { "used": 150000, "limit": 200000 },
  "recent_operations": []
}
```

## Impact

- **Transparency**: Checkpoints can be inspected without special tools
- **Recovery**: Manual recovery possible if automated systems fail
- **Portability**: Easy backup and transfer between systems
- **Debugging**: Clear visibility into saved state
- **Simplicity**: No database dependencies or services to maintain

## Related Context

- [Protocol Files Choice](../technical/protocol-files-choice.md) - File-based philosophy
- [Denormalized Database Design](../technical/denormalized-database-design-choice.md) - Simplicity principle
- [Context Tracking Token Estimation](../technical/context-tracking-token-estimation.md) - System design

## Validation

File-based approach proven effective when:
1. Manual checkpoint recovery saved multiple sessions
2. Checkpoint corruption was fixed with text editor
3. Backup/restore worked with simple file copy
4. No database meant no connection failures

---

*Evidence-backed decision from checkpoint manager implementation*