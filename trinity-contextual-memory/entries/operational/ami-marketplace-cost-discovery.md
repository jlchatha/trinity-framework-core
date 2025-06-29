## The 70% AMI Marketplace Cost Discovery

**Q: "Why should we avoid marketplace AMIs for production infrastructure?"**

**A:** Marketplace AMIs can consume 70% of your infrastructure budget while providing insufficient value compared to free alternatives.

**Evidence:**
- Oracle Linux marketplace AMI: $34/month fee on t3a.medium instance
- Total cost: $49/month ($15 instance + $34 AMI = 70% AMI overhead)  
- Free Oracle Linux AMI alternative: $0/month (ami-0b5a1d936f517ad3e)
- Result: 22% cost reduction + double resources after optimization

**Key Insight:** Always evaluate free AMI alternatives before accepting marketplace fees. The "convenience" of marketplace AMIs often masks significant budget impact.

**Source:** OVERSEER AAR Session 2025-06-25 (Trinity Beta2 Migration Planning)
**Date Discovered:** June 25, 2025
**Context:** Beta 2 spot instance failure revealed expensive AMI choice consuming majority of budget

**Related Context:**
- [The 100GB Storage Decision](../operational/storage-100gb-decision.md) - Infrastructure optimization patterns
- [Beta Infrastructure Evolution](../operational/workspaces-to-k8s.md) - Cost-conscious deployment strategies

---
