# OVERSEER Contextual Memory Deployment Instructions

**For**: OVERSEER  
**Purpose**: Deploy Trinity Contextual Memory to capture coordination expertise  
**Benefit**: Preserve "why" behind gateway/beta2 deployment decisions  
**Time Required**: ~1 hour setup + 6 units for expertise development  

## Why This Helps With Gateway/Beta2 Challenges

Contextual Memory will help you:
- Document coordination decisions that led to current challenges
- Preserve successful patterns from past deployments
- Create queryable knowledge about resource allocation choices
- Build institutional memory about workflow orchestration
- Capture the "why" behind priority management decisions

## Step 1: Copy System from HISTORIAN

```bash
# Navigate to your workspace
cd /path/to/overseer-workspace

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

## Step 3: Configure for OVERSEER Domain

```bash
# Set your domain focus
export AGENT_DOMAIN="coordination"
export DOMAIN_TOOLS="workflow|orchestration|priority|resource|gateway|deployment|beta"

# Create OVERSEER configuration
cat > OVERSEER-DOMAIN-CONFIG.md << 'EOF'
# OVERSEER Domain Configuration

**Domain**: Private Framework Coordination Expert
**Scope**: Private Framework ONLY
**Focus Areas**:
- Gateway deployment coordination
- Beta2 infrastructure orchestration  
- Resource allocation decisions
- Cross-agent collaboration patterns
- Priority management strategies
- Deployment timing coordination
- Integration workflow management

**Key Questions to Answer**:
- Why did we choose specific gateway deployment sequences?
- Why certain resource allocation patterns for beta2?
- Why specific coordination handoffs between agents?
- Why particular priority stacking decisions?
- Why timing choices for deployment windows?
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

Given your gateway/beta2 challenges, start with a recent coordination decision:

```bash
# Create your first OVERSEER-specific entry
mkdir -p entries/operational
cat > entries/operational/overseer-gateway-deployment-coordination.md << 'EOF'
# OVERSEER Gateway Deployment Coordination Pattern

**Question**: Why do we coordinate gateway deployments in specific sequences?

**Context**: Gateway deployments require careful orchestration between infrastructure preparation, service configuration, and user migration phases.

**Decision**: Implement three-phase deployment coordination:
1. Infrastructure validation phase (IRA lead)
2. Service deployment phase (shared coordination)
3. User migration phase (APEX coordination)

**Why This Way**:
- Prevents service availability gaps
- Allows rollback at each phase
- Maintains clear responsibility boundaries
- Enables parallel work where safe

**Evidence**:
- Beta1 deployment succeeded with this pattern
- Uncoordinated deployment in Dec 2024 caused 4-hour outage
- Three-phase approach reduced deployment time by 60%

**Related Context**:
- [Trinity Architecture Patterns](../cultural/trinity-architecture-patterns.md)
- [Workspaces to K8s Evolution](./workspaces-to-k8s.md)
- [100GB Storage Decision](./storage-100gb-decision.md)

**Keywords**: gateway, deployment, coordination, orchestration, phases
EOF
```

## Step 6: Update INDEX.md

```bash
# Add your new entry to the index
# Edit INDEX.md and add under Operational section:
# - [OVERSEER Gateway Deployment Coordination](entries/operational/overseer-gateway-deployment-coordination.md)
```

## Step 7: Extract Current Gateway/Beta2 Wisdom

Focus your initial extraction on current challenges:

1. **Gateway Coordination Patterns**
   - Document why certain deployment sequences
   - Capture resource allocation decisions
   - Preserve timing coordination choices

2. **Beta2 Orchestration Decisions**
   - Why specific infrastructure choices
   - Why certain priority stacking
   - Why particular agent handoffs

3. **Cross-Agent Collaboration**
   - Why IRA handles certain phases
   - Why APEX coordinates user-facing aspects
   - Why specific communication patterns

## Immediate Value for Current Work

As you work through gateway/beta2 deployments:

1. **Document decisions as you make them**:
   ```bash
   # After each significant coordination decision
   echo "Decision: [what], Rationale: [why], Evidence: [outcome]" >> pending-contexts.md
   ```

2. **Query existing patterns**:
   ```bash
   # Find relevant coordination patterns
   ansible-playbook ansible/context-query.yml -e "query='deployment coordination'"
   ```

3. **Build on Trinity patterns**:
   - Review `workspaces-to-k8s.md` for infrastructure evolution
   - Check `overseer-apex-duality.md` for coordination boundaries
   - Study `ship-beats-perfect.md` for deployment philosophy

## Expected Outcomes

Within 2-3 units you should have:
- 5+ coordination pattern contexts documented
- Gateway deployment decisions preserved
- Beta2 orchestration rationale captured
- Queryable knowledge about what works/doesn't

This will help prevent repeating past coordination mistakes and preserve successful patterns.

## Support

HISTORIAN remains available for:
- System troubleshooting
- Quality review of context entries
- Guidance on extraction patterns
- Template clarification

## Next Steps

1. Complete installation (Steps 1-4)
2. Create first context entry (Step 5)
3. Begin extracting gateway/beta2 decisions
4. Use system actively during current deployments
5. Build toward 20+ coordination contexts

Remember: Focus on capturing the "why" behind coordination decisions. The gateway/beta2 challenges you're facing now are exactly the kind of expensive lessons that contextual memory preserves for the future.

---

*"Coordination without memory repeats mistakes. With memory, it builds on success."*