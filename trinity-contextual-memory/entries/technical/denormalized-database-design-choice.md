## The Denormalized Database Design Choice

**Q: "Why embed customer and shipping information in order records instead of normalizing?"**

**A:** Denormalized design embeds customer and shipping information directly in order records for faster retrieval, trading storage efficiency for query performance in e-commerce order management.

**Evidence:**
- Design choice: Single order record contains all customer and shipping data
- Alternative: Normalized design with separate customer/shipping tables requiring joins
- Benefit: Faster order retrieval with single DynamoDB query
- Trade-off: Data duplication vs query performance optimization
- Context: E-commerce order management prioritizes read performance

**Key Insight:** For high-read workloads like order management, denormalization optimizes for the primary use case even at the cost of data duplication.

**Source:** HISTORIAN AAR Session 2025-06-12 (FieldGearCrawler UNIT 6 Phase 1)
**Date Discovered:** June 12, 2025
**Context:** DynamoDB table design for order management system requiring performance optimization

**Related Context:**
- [Protocol Files vs Database](protocol-files-choice.md) - File systems for different use cases
- [Trinity Architecture Patterns](../cultural/trinity-architecture-patterns.md) - Performance-focused design choices

---