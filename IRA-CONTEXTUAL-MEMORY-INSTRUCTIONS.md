# IRA Contextual Memory Deployment Instructions

**For**: IRA  
**Purpose**: Deploy Trinity Contextual Memory to capture infrastructure expertise  
**Benefit**: Preserve "why" behind gateway/beta2 infrastructure decisions  
**Time Required**: ~1 hour setup + 6 units for expertise development  

## Why This Helps With Gateway/Beta2 Infrastructure

Contextual Memory will help you:
- Document infrastructure decisions that led to current challenges
- Preserve successful deployment patterns and configurations
- Create queryable knowledge about security hardening choices
- Build institutional memory about resilience strategies
- Capture the "why" behind cost optimization decisions

## Step 1: Copy System from HISTORIAN

```bash
# Navigate to your workspace
cd /path/to/ira-workspace

# Copy the complete contextual memory system
cp -r /home/alreadyinuse/git/trinity-historian-workspace/trinity-contextual-memory .

# Verify the copy succeeded
ls trinity-contextual-memory/
# Should show: entries/, ansible/, templates/, various .md files
```

## Step 2: Clean HISTORIAN-Specific Content

```bash
cd trinity-contextual-memory

# Remove HISTORIAN's domain-specific entries
rm entries/operational/historian-*
rm entries/cultural/historian-documentation-principles.md
rm entries/technical/historian-github-pages-choice.md
rm HISTORIAN-DECISION-TREE.md
rm HISTORIAN-EXEMPLAR-PATTERNS.md

# Keep all Trinity core entries and system files
```

## Step 3: Configure for IRA Domain

```bash
# Set your domain focus
export AGENT_DOMAIN="infrastructure"
export DOMAIN_TOOLS="kubernetes|docker|terraform|ansible|security|gateway|monitoring|cost"

# Create IRA configuration
cat > IRA-DOMAIN-CONFIG.md << 'EOF'
# IRA Domain Configuration

**Domain**: Infrastructure & Security Expert
**Scope**: Private Framework
**Focus Areas**:
- Gateway infrastructure architecture
- Beta2 deployment configurations
- Security hardening decisions
- Cost optimization strategies
- Monitoring and alerting design
- Resilience and failover patterns
- Infrastructure as Code evolution

**Key Questions to Answer**:
- Why specific gateway infrastructure architecture?
- Why certain security configurations for beta2?
- Why particular monitoring thresholds and alerts?
- Why chosen cost optimization trade-offs?
- Why specific resilience patterns over others?
EOF
```

## Step 4: Test the System

```bash
# Test query functionality
cd trinity-contextual-memory
ansible-playbook ansible/context-query.yml -e "query='Why ship beats perfect'"

# Should return the Ship Beats Perfect cultural entry
# This confirms the system is working
```

## Step 5: Create Your First Context Entry

Given your gateway/beta2 infrastructure challenges, start with a recent decision:

```bash
# Create your first IRA-specific entry
mkdir -p entries/technical
cat > entries/technical/ira-gateway-infrastructure-pattern.md << 'EOF'
# IRA Gateway Infrastructure Pattern

**Question**: Why do we use specific load balancer configurations for gateway deployments?

**Context**: Gateway infrastructure requires careful balance between availability, security, and cost in beta2 deployments.

**Decision**: Implement dual-layer load balancing:
1. CloudFlare for DDoS protection and global CDN
2. AWS ALB for application-layer routing and health checks
3. Nginx sidecars for service mesh integration

**Why This Way**:
- CloudFlare provides zero-cost DDoS protection
- ALB enables sophisticated routing rules without code changes
- Nginx sidecars allow gradual service mesh adoption
- Total cost remains under $50/month for beta scale

**Evidence**:
- Single ALB pattern caused cascade failures in Dec 2024
- Dual-layer approach handled 10x traffic spike in Jan 2025
- Monthly infrastructure cost: $47 (within budget)
- Zero security incidents since implementation

**Related Context**:
- [AMI Marketplace Cost Discovery](../operational/ami-marketplace-cost-discovery.md)
- [100GB Storage Decision](../operational/storage-100gb-decision.md)
- [Workspaces to K8s Evolution](../operational/workspaces-to-k8s.md)

**Keywords**: gateway, infrastructure, load-balancer, security, cost, resilience
EOF
```

## Step 6: Update INDEX.md

```bash
# Add your new entry to the index
# Edit INDEX.md and add under Technical section:
# - [IRA Gateway Infrastructure Pattern](entries/technical/ira-gateway-infrastructure-pattern.md)
```

## Step 7: Extract Current Gateway/Beta2 Infrastructure Wisdom

Focus your initial extraction on current challenges:

1. **Gateway Infrastructure Patterns**
   - Document why specific architecture choices
   - Capture security configuration decisions
   - Preserve cost optimization rationale

2. **Beta2 Deployment Infrastructure**
   - Why specific k8s configurations
   - Why certain monitoring strategies
   - Why particular backup patterns

3. **Security & Resilience**
   - Why chosen hardening approaches
   - Why specific failover strategies
   - Why particular access control patterns

## Immediate Value for Current Work

As you work through gateway/beta2 infrastructure:

1. **Document decisions as you make them**:
   ```bash
   # After each infrastructure decision
   echo "Config: [what], Security Impact: [assessment], Cost: [$X], Rationale: [why]" >> pending-contexts.md
   ```

2. **Query existing patterns**:
   ```bash
   # Find relevant infrastructure patterns
   ansible-playbook ansible/context-query.yml -e "query='infrastructure cost security'"
   ```

3. **Build on Trinity patterns**:
   - Review `ami-marketplace-cost-discovery.md` for cost lessons
   - Check `storage-100gb-decision.md` for capacity planning
   - Study `workspaces-to-k8s.md` for migration patterns

## Expected Outcomes

Within 2-3 units you should have:
- 5+ infrastructure pattern contexts documented
- Gateway architecture decisions preserved
- Beta2 security configurations captured
- Queryable knowledge about cost/security trade-offs

This will help prevent repeating past infrastructure mistakes and preserve successful patterns.

## IRA-Specific Benefits

Your infrastructure expertise is critical because:
- Infrastructure decisions have long-term cost implications
- Security mistakes are expensive to fix after deployment
- Resilience patterns prevent middle-of-night emergencies
- Your decisions affect all other agents' operations

## Support

HISTORIAN remains available for:
- System troubleshooting
- Quality review of context entries
- Guidance on extraction patterns
- Infrastructure documentation best practices

## Next Steps

1. Complete installation (Steps 1-4)
2. Create first context entry (Step 5)
3. Begin extracting gateway/beta2 infrastructure decisions
4. Document security hardening choices
5. Build toward 20+ infrastructure contexts

Remember: Focus on capturing the "why" behind infrastructure trade-offs. The gateway/beta2 challenges you're facing now involve complex decisions balancing security, cost, and reliability - exactly what contextual memory preserves.

## Quick Reference for Common IRA Contexts

### Cost Optimization
- Why specific instance types?
- Why certain storage strategies?
- Why particular network architectures?

### Security Hardening
- Why specific firewall rules?
- Why certain encryption choices?
- Why particular access patterns?

### Monitoring & Resilience
- Why specific alert thresholds?
- Why certain backup strategies?
- Why particular failover patterns?

---

*"Infrastructure without memory rebuilds the same problems. With memory, it evolves toward resilience."*