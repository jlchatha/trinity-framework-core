# APEX Contextual Memory Quick Start Guide

## 🚀 Automated Setup (Recommended)

### Step 1: Navigate to Your Workspace
```bash
cd /home/alreadyinuse/git/trinity-apex-workspace
```

### Step 2: Run Deployment Script
```bash
/home/alreadyinuse/git/trinity-historian-workspace/tools/deploy-contextual-memory-apex.sh
```

### Step 3: Verify Installation
```bash
/home/alreadyinuse/git/trinity-historian-workspace/tools/verify-apex-contextual-memory.sh
```

## 📝 Using Your Contextual Memory

### Query Existing Knowledge
```bash
cd trinity-contextual-memory
./query-context.sh 'beta onboarding'
./query-context.sh 'framework education'
./query-context.sh 'user experience'
```

### Add New Context Entry
```bash
./add-context.sh
# Follow the prompts to create a new entry
```

### Manual Entry Creation
```bash
# Create a new beta coordination context
cat > entries/operational/apex-demo-strategy.md << 'EOF'
# APEX Framework Demo Strategy

**Question**: Why do we use interactive demos instead of video tutorials?

**Context**: Beta users need hands-on experience to understand Trinity Framework's power.

**Decision**: Interactive demos with guided sandbox environments

**Why This Way**:
- 87% better retention vs passive video watching
- Immediate feedback builds confidence
- Real environment = real understanding
- Sandbox prevents breaking production

**Evidence**:
- Beta 1: 12% video completion vs 73% demo completion
- User feedback: "Finally understood after trying it myself"
- Support tickets: 80% reduction after demo implementation

**Keywords**: apex, demo, education, interactive, beta
EOF
```

## 🎯 APEX-Specific Focus Areas

### Beta Coordination Contexts
- Onboarding sequences and patterns
- User success metrics and tracking
- Coordination with other agents
- Resource allocation strategies

### Framework Education Contexts
- Demo and tutorial strategies
- Documentation approaches
- Complexity progression patterns
- Success measurement methods

### User Experience Contexts
- Interface design decisions
- Workflow optimization choices
- Support methodology patterns
- Engagement strategies

## 📊 Daily Workflow

### Morning Check
```bash
# See what questions came up yesterday
grep -r "Question:" entries/ | grep -i "$(date -d yesterday +%Y-%m-%d)"

# Query for relevant patterns
./query-context.sh 'recent beta decisions'
```

### Document As You Work
```bash
# Quick capture during work
echo "Decision: [what] | Why: [reason] | Impact: [result]" >> daily-decisions.log

# Convert to context entry at end of day
./add-context.sh
```

### Weekly Extraction
```bash
# Run extraction to find new patterns
ansible-playbook ansible/context-extract-unit.yml

# Review pending entries
ls entries/pending/
```

## 🔍 Example Queries for APEX Work

```bash
# Beta coordination queries
./query-context.sh 'why 3 day onboarding'
./query-context.sh 'beta user dropout prevention'
./query-context.sh 'coordination boundaries with OVERSEER'

# Framework education queries
./query-context.sh 'demo vs documentation'
./query-context.sh 'complexity progression'
./query-context.sh 'user understanding patterns'

# User experience queries
./query-context.sh 'workspace guidance'
./query-context.sh 'support methodology'
./query-context.sh 'engagement strategies'
```

## 💡 Best Practices

### Good Context Entry Characteristics
- Answers a specific "why" question
- Includes measurable evidence
- Links to related contexts
- Uses consistent keywords
- Captures both environments (private/public)

### When to Create New Entries
- After making a coordination decision
- When discovering what works/doesn't work
- After user feedback reveals patterns
- When changing approaches based on data
- When coordinating with other agents

## 🚨 Common Issues & Solutions

### Query Returns No Results
```bash
# Check if entries exist
find entries/ -name "*.md" | wc -l

# Try broader search
grep -r "your keyword" entries/
```

### Ansible Errors
```bash
# Ensure you're in the right directory
pwd  # Should show trinity-contextual-memory

# Check Ansible is installed
which ansible-playbook
```

### Missing Entries After Extraction
```bash
# Check pending directory
ls -la entries/pending/

# Move approved entries to proper stream
mv entries/pending/good-entry.md entries/operational/
```

## 📈 Success Metrics

Within 1 week, you should have:
- 10+ beta coordination contexts
- 5+ framework education patterns
- 5+ user experience decisions
- Queryable knowledge base
- Daily documentation habit

## 🤝 Support

HISTORIAN is available for:
- System troubleshooting
- Context quality review
- Extraction guidance
- Best practices consultation

## 🎓 Remember

Your contextual memory captures the "why" behind:
- Beta coordination decisions
- Framework education strategies
- User experience optimizations
- Cross-agent coordination patterns

This knowledge helps Trinity evolve intelligently rather than repeating past mistakes.

---

*"Every beta user's success story starts with understanding why they struggled before."*