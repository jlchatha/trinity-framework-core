## The Build Environment Reality Check

**Q: "Why did local development success not predict deployment success?"**

**A:** Local development environments have full context availability while static export builds have severe limitations. What works locally with theme context can fail completely in static prerendering where no context exists.

**Evidence:**
- Local development: Theme context properly initialized, all features working
- AWS Amplify static export: "Cannot read properties of undefined" errors
- Root cause: Static prerendering has no access to React context
- 5 attempts to bridge this gap all failed until abandoning context entirely

**Key Insight:** Build environment limitations require fundamentally different implementation strategies. Development environment success is not a reliable predictor of static export compatibility.

**Source:** HISTORIAN AAR Session 2025-06-12 (FieldGearCrawler Amplify Challenges)
**Date Discovered:** June 12, 2025
**Context:** Multiple deployment failures despite local success requiring architecture understanding

**Related Context:**
- [Extreme Simplicity Deployment Fix](extreme-simplicity-deployment-fix.md) - Solution that worked
- [Trinity Architecture Patterns](../cultural/trinity-architecture-patterns.md) - Consistent simplicity choices

---