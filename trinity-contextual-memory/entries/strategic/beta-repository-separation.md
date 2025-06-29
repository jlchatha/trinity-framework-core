# Beta Repository Public/Private Separation

**Date**: May 2025  
**Decision**: Maintain separate public (apex-beta) and private (apex-beta-dev) repositories  
**Status**: Implemented  

## Context

**Q: "Why does Trinity beta program use two separate repositories?"**

**A:** The two-repository approach separates user-facing documentation from technical implementation details. Public repository (apex-beta) contains guides and walkthroughs accessible to beta testers, while private repository (apex-beta-dev) holds comprehensive technical details, monitoring plans, and internal development roadmaps. This ensures users aren't overwhelmed with technical complexity while developers have full implementation details.

## Evidence

From apex-beta-dev/documentation/documentation-lifecycle.md:
- "Public Repository (apex-beta): User-facing guides and walkthroughs"
- "Private Repository (apex-beta-dev): Technical implementation details"
- "Content Segregation Principles: User guides focus on how-to, step-by-step"

From testing-status.md line 53:
- "404 errors when accessing raw GitHub URLs" - private repos require authentication

## Impact

- **User Experience**: Clean, focused documentation for beta testers
- **Developer Freedom**: Technical details preserved without confusing users
- **Security**: Sensitive implementation details remain private
- **Flexibility**: Can update technical docs without affecting user guides
- **Compliance**: Meets both user accessibility and technical depth needs

## Related Context

- [Open Source Boundaries](open-source-strategy.md) - Strategic separation approach
- [The OVERSEER/APEX Duality](overseer-apex-duality.md) - Public/private naming
- [Beta AWS Workspace Architecture](../technical/beta-workspace-aws-choice.md) - Implementation

## Validation

This separation proved valuable when:
1. Beta testers successfully followed guides without technical confusion
2. Developers could document complex details without simplification
3. Security reviews passed without exposing internal architecture
4. Documentation updates could target specific audiences

---

*Evidence-backed decision from beta documentation lifecycle*