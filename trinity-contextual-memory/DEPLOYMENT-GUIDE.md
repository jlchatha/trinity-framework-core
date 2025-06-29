# Trinity Contextual Memory - Deployment Guide

**Purpose**: Install and configure Trinity Contextual Memory system in any agent workspace  
**Based on**: HISTORIAN's proven implementation  
**Target**: Individual agent workspaces requiring domain expertise capture  

## Deployment Options

### Option 1: Copy from HISTORIAN (Immediate)
**Best for**: Quick setup, agents ready to start immediately  
**Process**: Copy complete system from HISTORIAN's workspace  

### Option 2: Clone from Repository (Future)
**Best for**: Standard installation, version control  
**Process**: Clone from Trinity Framework repository (when available)  

### Option 3: ORCA Integration (Future)
**Best for**: Automated deployment and management  
**Process**: ORCA-managed installation and configuration  

## Option 1: Copy from HISTORIAN (Current)

### Prerequisites
- Agent has established workspace following Trinity Framework 2.0
- Agent has Ansible installed and configured
- Agent has git access and basic shell skills
- Agent workspace has AAR directory structure

### Installation Steps

#### Step 1: Copy Core System
```bash
# Navigate to target agent workspace
cd /path/to/target-agent-workspace

# Copy complete contextual memory system
cp -r /home/alreadyinuse/git/trinity-historian-workspace/trinity-contextual-memory .

# Verify structure
ls trinity-contextual-memory/
# Should show: entries/, ansible/, templates/, *.md files
```

#### Step 2: Clear HISTORIAN-Specific Content
```bash
cd trinity-contextual-memory

# Remove HISTORIAN's entries (keep structure)
rm entries/operational/historian-*
rm entries/cultural/historian-documentation-principles.md
rm entries/technical/historian-github-pages-choice.md

# Remove HISTORIAN-specific documentation
rm HISTORIAN-DECISION-TREE.md
rm HISTORIAN-EXEMPLAR-PATTERNS.md

# Keep these files (agent-agnostic):
# - INDEX.md (will be updated)
# - AGENT-DOMAIN-EXTRACTION-TEMPLATE.md
# - EXPANSION-GUIDELINES.md
# - PHASE-3-ORCA-HANDOFF.md
# - ansible/ (tools)
# - entries/technical/protocol-files-choice.md
# - entries/cultural/trinity-architecture-patterns.md
# - entries/cultural/ship-beats-perfect.md
```

#### Step 3: Configure for Agent
```bash
# Update INDEX.md to remove HISTORIAN entries
cat > INDEX.md << 'EOF'
# Trinity Contextual Memory - Index

**Purpose**: Answer "why" questions about Trinity's evolution  
**Method**: Simple markdown files, no fancy features  
**Success**: When someone asks "why", we have an answer  

## Entries by Stream

### Technical
- [Framework 2.0 Creation](entries/technical/framework-2-birth.md)
- [Protocol Files vs Database](entries/technical/protocol-files-choice.md)
- [Trinity-AD Achievement](entries/technical/analyst-6-hour-miracle.md)

### Strategic
- [Open Source Boundaries](entries/strategic/open-source-strategy.md)
- [The OVERSEER/APEX Duality](entries/strategic/overseer-apex-duality.md)

### Operational
- [AMI Marketplace Cost Discovery](entries/operational/ami-marketplace-cost-discovery.md)
- [Barracuda Speed Record](entries/operational/barracuda-6-minutes.md)
- [The 100GB Storage Decision](entries/operational/storage-100gb-decision.md)
- [Beta Infrastructure Evolution](entries/operational/workspaces-to-k8s.md)

### Cultural
- [Ship Beats Perfect Origin](entries/cultural/ship-beats-perfect.md)
- [Trinity Architecture Patterns](entries/cultural/trinity-architecture-patterns.md)
- [Unit/Milestone/Phase Measurements](entries/cultural/unit-not-daily.md)

### Pending Review
- None currently
EOF
```

#### Step 4: Test Installation
```bash
# Test query system
cd trinity-contextual-memory
ansible-playbook ansible/context-query.yml -e "query='Why ship beats perfect'"

# Should return: Ship Beats Perfect Origin entry
# If successful, installation is working
```

#### Step 5: Create Agent's First Context Entry
```bash
# Follow AGENT-DOMAIN-EXTRACTION-TEMPLATE.md
# Start with Phase 1: Deep Extraction for your domain
# Create first agent-specific context entry

# Example for ANALYST:
mkdir -p entries/technical/
# Create entries/technical/analyst-[first-decision].md
# Follow the template format exactly
```

### Directory Structure Post-Installation
```
target-agent-workspace/
├── trinity-contextual-memory/
│   ├── entries/
│   │   ├── technical/        # Trinity core + agent entries
│   │   ├── strategic/        # Trinity core entries
│   │   ├── operational/      # Trinity core entries  
│   │   ├── cultural/         # Trinity core entries
│   │   └── pending/          # Agent's pending entries
│   ├── ansible/              # Query/extraction tools
│   │   ├── context-query.yml
│   │   └── context-extract-unit.yml
│   ├── templates/            # Entry templates
│   ├── INDEX.md             # Navigation (agent updates)
│   ├── AGENT-DOMAIN-EXTRACTION-TEMPLATE.md
│   ├── EXPANSION-GUIDELINES.md
│   └── PHASE-3-ORCA-HANDOFF.md
├── AGENT.md                  # Agent's existing files
├── STATUS.md
├── AUTO-COMPACT.md
└── AAR/                      # Agent's existing AARs
    └── sessions/
```

## Configuration by Agent Type

### For ANALYST (Technical Domain Expert)
```bash
# Agent-specific focus areas
export AGENT_DOMAIN="technical"
export DOMAIN_TOOLS="python|javascript|typescript|architecture|performance"

# Profile: Technical Domain Expert (Private Framework)
# Focus: Technical architecture, code quality, performance optimization
```

### For IRA (Infrastructure & Security Expert)  
```bash
# Agent-specific focus areas
export AGENT_DOMAIN="infrastructure"
export DOMAIN_TOOLS="kubernetes|docker|terraform|ansible|security"

# Profile: Infrastructure & Security Expert (Private Framework)
# Focus: Infrastructure resilience, security, deployment, monitoring
```

### For APEX (Beta Coordination & Framework Education Expert)
```bash
# Agent-specific focus areas  
export AGENT_DOMAIN="beta_coordination"
export DOMAIN_TOOLS="beta|onboarding|education|demonstration|workspace"

# Profile: Beta Coordination & Framework Education Expert
# Deployment Scope: Both Private & Public/Beta
# Public Role: Framework Education & Beta Coordination
# Private Role: Internal Beta Management & User Onboarding
# Focus: Beta coordination, framework education, workspace guidance
```

### For OVERSEER (Private Framework Coordination Expert)
```bash
# Agent-specific focus areas  
export AGENT_DOMAIN="coordination"
export DOMAIN_TOOLS="workflow|orchestration|priority|resource"

# Profile: Private Framework Coordination Expert
# Deployment Scope: Private Framework ONLY
# CRITICAL: OVERSEER exists only in private - never in public/beta
# Focus: Coordination patterns, workflow orchestration, resource allocation
```

## Validation Checklist

### Installation Validation
- [ ] `trinity-contextual-memory/` directory exists in agent workspace
- [ ] `ansible/context-query.yml` exists and is executable
- [ ] Trinity core entries preserved (ship-beats-perfect, protocol-files-choice, etc.)
- [ ] HISTORIAN-specific entries removed
- [ ] Query system returns results for "Why ship beats perfect"

### Configuration Validation
- [ ] Agent domain focus documented in templates/
- [ ] INDEX.md updated with agent-agnostic content
- [ ] Agent environment variables set correctly
- [ ] Agent can access own AAR sessions for extraction

### Readiness Validation
- [ ] Agent has 6+ months of workspace decisions to extract
- [ ] Agent understands their domain expertise area
- [ ] Agent has read AGENT-DOMAIN-EXTRACTION-TEMPLATE.md
- [ ] Agent ready to begin Phase 1: Deep Extraction

## Support and Troubleshooting

### Common Issues

#### Query System Not Working
```bash
# Check Ansible installation
ansible --version

# Check file permissions
ls -la ansible/context-query.yml

# Test with simple query
ansible-playbook ansible/context-query.yml -e "query='Trinity'"
```

#### No Results from Queries
```bash
# Check entries directory
ls -la entries/*/

# Verify entry format
head -20 entries/cultural/ship-beats-perfect.md

# Check Ansible inventory
ansible localhost -m ping
```

#### Context Entry Creation Issues
```bash
# Verify template access
cat AGENT-DOMAIN-EXTRACTION-TEMPLATE.md | head -50

# Check directory permissions
ls -la entries/
mkdir -p entries/technical entries/operational
```

### Getting Help

1. **HISTORIAN Consultation**: HISTORIAN remains available for system support
2. **Template Reference**: Use AGENT-DOMAIN-EXTRACTION-TEMPLATE.md as complete guide
3. **Example Reference**: Study remaining Trinity core entries for format examples
4. **Documentation**: Read EXPANSION-GUIDELINES.md for quality standards

## Next Steps After Installation

1. **Read Template**: Study AGENT-DOMAIN-EXTRACTION-TEMPLATE.md thoroughly
2. **Phase 1 Extraction**: Begin with Step 1: Decision Archaeology in your workspace
3. **Create First Context**: Document your first domain-specific decision
4. **Test Query System**: Verify you can query your new context
5. **Follow 6-Unit Program**: Complete all phases for domain expertise

## Maintenance

### Regular Updates
- Update INDEX.md when adding new entries
- Maintain relationship mappings in "Related Context" sections
- Follow evidence quality standards for all new contexts
- Coordinate with HISTORIAN for system improvements

### Quality Assurance
- All context entries must have concrete evidence
- Maintain 3+ "Related Context" links per entry
- Focus on domain-specific decisions requiring agent expertise
- Follow Trinity measurement standards (units/milestones/phases)

---

**Success Criteria**: Agent can query domain-specific questions and receive accurate, evidence-based answers from their own documented expertise.

**Timeline**: Installation takes ~1 hour. Domain expertise development takes 6 units following the template.

---

*"Every agent deserves deep, authentic domain expertise documentation. This deployment makes it possible."* - Trinity Contextual Memory Deployment Philosophy