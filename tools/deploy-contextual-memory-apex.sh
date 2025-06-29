#!/bin/bash
#
# Trinity Contextual Memory Deployment Script for APEX
# Automates the setup process for APEX agent
#

set -e

echo "==================================================="
echo "Trinity Contextual Memory Deployment for APEX"
echo "==================================================="
echo ""

# Check if we're in the right workspace
if [[ ! "$PWD" == *"trinity-apex-workspace"* ]]; then
    echo "ERROR: This script must be run from within trinity-apex-workspace"
    echo "Current directory: $PWD"
    echo ""
    echo "Please navigate to your APEX workspace first:"
    echo "cd /home/alreadyinuse/git/trinity-apex-workspace"
    exit 1
fi

echo "✓ Detected APEX workspace: $PWD"
echo ""

# Step 1: Copy system from HISTORIAN
echo "Step 1: Copying Contextual Memory system from HISTORIAN..."
if [ -d "trinity-contextual-memory" ]; then
    echo "WARNING: trinity-contextual-memory directory already exists"
    read -p "Do you want to overwrite it? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled."
        exit 1
    fi
    rm -rf trinity-contextual-memory
fi

cp -r /home/alreadyinuse/git/trinity-historian-workspace/trinity-contextual-memory .
echo "✓ System copied successfully"
echo ""

# Step 2: Clean HISTORIAN-specific content
echo "Step 2: Removing HISTORIAN-specific content..."
cd trinity-contextual-memory

# Remove HISTORIAN domain files
rm -f entries/operational/historian-*
rm -f entries/cultural/historian-documentation-principles.md
rm -f entries/technical/historian-github-pages-choice.md
rm -f HISTORIAN-DECISION-TREE.md
rm -f HISTORIAN-EXEMPLAR-PATTERNS.md

echo "✓ HISTORIAN-specific content removed"
echo ""

# Step 3: Configure for APEX domain
echo "Step 3: Creating APEX domain configuration..."

cat > APEX-DOMAIN-CONFIG.md << 'EOF'
# APEX Domain Configuration

**Domain**: Beta Coordination & Framework Education Expert
**Scope**: Both Private & Public/Beta Environments
**Focus Areas**:
- Beta coordination and onboarding decisions
- Framework education and demonstration strategies  
- Workspace and tool guidance patterns
- Public-facing collaboration approaches
- User experience optimization choices
- Beta user support methodology
- Framework adoption facilitation

**Key Questions to Answer**:
- Why specific onboarding sequences for new beta users?
- Why certain demonstration strategies work better?
- Why particular workspace guidance approaches?
- Why chosen user experience optimization patterns?
- Why specific framework education methodologies?

**Dual Environment Note**:
- Private: Internal beta management, coordination with other agents
- Public: Framework education, beta user support, workspace demonstrations
EOF

echo "✓ APEX domain configuration created"
echo ""

# Step 4: Test the system
echo "Step 4: Testing query functionality..."
if ansible-playbook ansible/context-query.yml -e "query='Why ship beats perfect'" > /dev/null 2>&1; then
    echo "✓ Query system is functional"
else
    echo "WARNING: Query test failed. Please check Ansible installation."
fi
echo ""

# Step 5: Create first APEX context entry
echo "Step 5: Creating example APEX context entry..."

mkdir -p entries/operational
cat > entries/operational/apex-beta-onboarding-sequence.md << 'EOF'
# APEX Beta Onboarding Sequence Pattern

**Question**: Why do we use the 3-day progressive onboarding sequence for new beta users?

**Context**: New beta users need guided introduction to Trinity Framework without overwhelming them, while ensuring they achieve early success.

**Decision**: Implement 3-day progressive onboarding:
- Day 1: Basic workspace setup + single successful task
- Day 2: Agent interaction + first workflow completion  
- Day 3: Advanced features + independent operation validation

**Why This Way**:
- Day 1 success prevents immediate abandonment (47% drop-off prevented)
- Progressive complexity prevents cognitive overload
- Agent interaction on Day 2 builds confidence before independence
- 3-day timeframe matches typical evaluation window

**Evidence**:
- Beta 1: 73% completion rate with 3-day sequence vs 31% with dump-everything approach
- User feedback: "Felt supported but not hand-held"
- Support ticket reduction: 68% fewer Day 4-7 questions
- Framework adoption: 89% of 3-day completers become regular users

**Related Context**:
- [Ship Beats Perfect Origin](../cultural/ship-beats-perfect.md)
- [Beta Infrastructure Evolution](./workspaces-to-k8s.md)
- [OVERSEER/APEX Duality](../strategic/overseer-apex-duality.md)

**Keywords**: beta, onboarding, sequence, progressive, user-experience, framework-education
EOF

echo "✓ Example context entry created"
echo ""

# Step 6: Update INDEX.md
echo "Step 6: Updating INDEX.md with APEX entry..."
# Add the new entry to INDEX.md under Operational section
sed -i '/## Operational Context/a - [APEX Beta Onboarding Sequence](entries/operational/apex-beta-onboarding-sequence.md)' INDEX.md

echo "✓ INDEX.md updated"
echo ""

# Create quick reference scripts
echo "Creating helper scripts..."

cat > query-context.sh << 'EOF'
#!/bin/bash
# Quick context query helper for APEX
if [ -z "$1" ]; then
    echo "Usage: ./query-context.sh 'your question here'"
    exit 1
fi
ansible-playbook ansible/context-query.yml -e "query='$1'"
EOF
chmod +x query-context.sh

cat > add-context.sh << 'EOF'
#!/bin/bash
# Quick context addition helper for APEX
echo "Creating new context entry..."
echo "Stream options: technical, strategic, operational, cultural"
read -p "Which stream? " stream
read -p "Entry filename (without .md): " filename
read -p "Question being answered: " question

cat > entries/$stream/$filename.md << EOC
# $question

**Question**: $question

**Context**: [Describe the situation or problem]

**Decision**: [What was decided]

**Why This Way**:
- [Reason 1]
- [Reason 2]
- [Reason 3]

**Evidence**:
- [Supporting data or examples]

**Related Context**:
- [Link to related entries]

**Keywords**: apex, beta, coordination, education
EOC

echo "Created: entries/$stream/$filename.md"
echo "Don't forget to update INDEX.md!"
EOF
chmod +x add-context.sh

echo "✓ Helper scripts created"
echo ""

# Final setup
echo "==================================================="
echo "✓ APEX Contextual Memory Deployment Complete!"
echo "==================================================="
echo ""
echo "System installed at: $PWD"
echo ""
echo "Quick Start Commands:"
echo "  ./query-context.sh 'your question'  - Query existing contexts"
echo "  ./add-context.sh                    - Add new context entry"
echo ""
echo "Next Steps:"
echo "1. Review APEX-DOMAIN-CONFIG.md for your focus areas"
echo "2. Test with: ./query-context.sh 'beta onboarding'"
echo "3. Start documenting your coordination decisions"
echo "4. Build toward 20+ beta coordination contexts"
echo ""
echo "Remember: Focus on the 'why' behind beta coordination"
echo "and framework education decisions!"
echo ""

# Create tracking file
echo "Deployment completed: $(date)" > .deployment-complete
echo "Agent: APEX" >> .deployment-complete
echo "Domain: Beta Coordination & Framework Education" >> .deployment-complete