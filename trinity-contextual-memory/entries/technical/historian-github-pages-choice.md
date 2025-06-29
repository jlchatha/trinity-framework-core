## HISTORIAN's GitHub Pages Choice

**Q: "Why use GitHub Pages with custom HTML instead of Jekyll or static site generators?"**

**A:** HISTORIAN chose GitHub Pages with direct HTML deployment to avoid Jekyll's dependency constraints and markdown-to-HTML conversion issues, prioritizing deployment reliability over development convenience.

**Evidence:**
- Direct HTML deployment: "Deploy HTML documentation to GitHub Pages" (commit 2270bfd)
- Custom theme implementation: ShadowRun-inspired CSS (1012 lines) instead of Jekyll themes
- 404 error fix: "Create HTML versions of Markdown files to fix 404 errors"
- Manual control: Direct file management vs Jekyll build process
- No Jekyll dependencies: Eliminates Ruby gem compatibility issues

**HISTORIAN-Specific Insight:** For documentation deployment, direct control over HTML output ensures reliability, even at the cost of development convenience - deployment success beats authoring elegance.

**Source:** Git commits 2270bfd, 3bc9a2f (GitHub Pages implementation)
**Date Discovered:** June 13, 2025
**Context:** Trinity Framework public documentation requiring reliable deployment

**Related Context:**
- [HISTORIAN's Documentation Principles](../cultural/historian-documentation-principles.md) - Deployment reliability principle
- [Extreme Simplicity Deployment Fix](extreme-simplicity-deployment-fix.md) - Reliable deployment over sophisticated tools
- [Build Environment Reality Check](build-environment-reality-check.md) - Deployment environment limitations
- [Trinity Architecture Patterns](../cultural/trinity-architecture-patterns.md) - Simple solutions over complex ones

---