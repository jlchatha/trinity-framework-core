# GitHub SSH Authentication Pivot

**Date**: May 2025  
**Decision**: Switch from HTTPS to SSH for all GitHub operations  
**Status**: Implemented and Standardized  

## Context

**Q: "Why did Trinity pivot from HTTPS to SSH for GitHub authentication?"**

**A:** HTTPS authentication caused interactive credential prompts that broke automation, while private repositories returned 404 errors on raw content access. SSH authentication eliminated these issues by providing non-interactive, key-based authentication that works reliably for both cloning and raw file access. The pivot improved automation reliability and aligned with GitHub's move away from password authentication.

## Evidence

From testing-status.md:
- "Clone initially attempted with HTTPS URL, resulting in credential prompt"
- "Fixed by using SSH URL: git@github.com:jlchatha/apex-beta.git"
- "404 errors when accessing raw GitHub URLs" for private repos

From AWS-WORKSPACE-MANUAL-STEPS.md:
```bash
# Standardized SSH setup
ssh-keygen -t ed25519 -C "apex@trinity-apex.com"
gh config set git_protocol ssh
```

## Impact

- **Automation**: Eliminated interactive prompts breaking scripts
- **Reliability**: 100% success rate with SSH vs failures with HTTPS
- **Security**: Key-based auth more secure than passwords
- **Standardization**: All Trinity operations now use SSH
- **User Experience**: One-time setup vs repeated auth prompts

## Related Context

- [Beta AWS Workspace Architecture](beta-workspace-aws-choice.md) - Environment setup
- [Checkpoint System Recovery Design](checkpoint-system-recovery-design.md) - Automation reliability
- [Extreme Simplicity Deployment](extreme-simplicity-deployment-fix.md) - Removing friction

## Lessons Learned

SSH pivot taught valuable lessons:
1. Pre-flight SSH verification prevents downstream failures
2. Ed25519 keys preferred over RSA for efficiency
3. Full repository clone more reliable than raw file access
4. Clear documentation essential for SSH setup success

---

*Evidence-backed decision from beta testing authentication issues*