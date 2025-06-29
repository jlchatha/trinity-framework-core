## Beta Infrastructure Evolution

**Q: "Why did we move from AWS WorkSpaces to Kubernetes?"**

**A:** AWS WorkSpaces cost $80 per user per month for the beta environment, limiting us to 2 testers. Moving to Kubernetes on AWS spot instances reduced costs to $6 per user per month - an 86% reduction that enabled supporting 5 beta testers instead of 2.

**Evidence:**
- Beta 1 cost: $80/user/month (AWS WorkSpaces)
- Beta 2 cost: $6/user/month (K8s on spot instances)
- Cost reduction: 86% ($74/user savings)
- Capacity increase: 2.5x (2 testers → 5 testers)
- Decision date: June 2025

**Key Insight:** 10x cost efficiency unlocked 2.5x capacity - complexity was worth the savings.

**Related Context:**
- [AMI Marketplace Cost Discovery](ami-marketplace-cost-discovery.md) - Infrastructure cost optimization lessons  
- [The 100GB Storage Decision](storage-100gb-decision.md) - Resource planning and buffer strategies
- [Ship Beats Perfect Origin](../cultural/ship-beats-perfect.md) - Pragmatic approach over perfect solutions

---