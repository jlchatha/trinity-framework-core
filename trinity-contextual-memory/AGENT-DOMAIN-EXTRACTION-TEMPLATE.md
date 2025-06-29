# Agent Domain Extraction Template

**Based on**: HISTORIAN's deep workspace focus success  
**Purpose**: Enable any Trinity agent to build deep, authentic contextual memory in their domain  
**Philosophy**: "Deep beats wide. Expert knowledge beats general assumptions."  

## Prerequisites

### Agent Readiness Check
- [ ] Agent has established workspace with 6+ months of decisions
- [ ] Agent has consistent AAR documentation
- [ ] Agent has git history showing decision evolution
- [ ] Agent has domain-specific artifacts (configs, scripts, docs)
- [ ] Agent understands their core specialization

### System Setup
- [ ] Trinity Contextual Memory system deployed in agent workspace
- [ ] Ansible query/extraction tools configured
- [ ] INDEX.md structure established
- [ ] Agent has access to own workspace file system

## Phase 1: Deep Extraction (Units 1-2)

### Step 1: Decision Archaeology
```bash
# Find all decisions in agent workspace
find ${AGENT_WORKSPACE} -name "*.md" -exec grep -l "decision\|chose\|why.*" {} \;

# Extract from git history
git log --oneline --grep="decide\|chose\|implement" | head -20

# Scan AAR sessions for domain decisions
find AAR/sessions -name "*.md" -exec grep -l "${AGENT_DOMAIN}" {} \;
```

### Step 2: Core Extraction Queries
```bash
# Domain-specific tool choices
git log --oneline --grep="${DOMAIN_TOOLS}" | head -10

# Workflow evolution patterns  
git log --oneline ${STATUS_FILE} | head -10

# Configuration decisions
find . -name "*.config" -o -name "*.yml" -o -name "*.json" | xargs git log --follow
```

### Step 3: Evidence Collection
For each discovered decision:
- [ ] Find concrete artifact (file, commit, AAR entry)
- [ ] Identify measurable outcome
- [ ] Locate alternative approaches considered
- [ ] Document specific date/context

### Success Criteria Phase 1
- [ ] 15+ domain decisions identified with evidence
- [ ] Each decision has concrete artifacts backing it
- [ ] Decisions span 3+ categories (technical, operational, workflow)
- [ ] Clear pattern of domain expertise emerges

## Phase 2: Context Creation (Units 3-4)

### Context Entry Template
```markdown
## [Agent]'s [Decision Category] Choice

**Q: "[Specific why question about this agent's domain choice]"**

**A:** [Agent] chose [specific approach] because [domain-specific reasoning with measurable benefits].

**Evidence:**
- [Specific artifact]: [Concrete detail]
- [Measurable outcome]: [Quantified result]
- [Alternative considered]: [Why rejected]
- [Domain context]: [Specialist knowledge applied]

**[Agent]-Specific Insight:** [How this choice reflects agent's domain expertise and philosophy]

**Source:** [Exact file/commit/AAR with path]
**Date Discovered:** [When decision was made]
**Context:** [Situation requiring this domain expertise]

**Related Context:**
- [Link to upstream decision that influenced this]
- [Link to downstream decision this enabled]
- [Link to parallel decisions in same domain]

---
```

### Context Categories by Agent Type

#### Technical Agents (ANALYST, etc.)
- Architecture choices and trade-offs
- Technology stack decisions
- Performance optimization choices
- Code organization patterns
- Testing strategy decisions

#### Infrastructure Agents (IRA, etc.)
- Deployment platform choices
- Security configuration decisions
- Scaling strategy choices
- Monitoring and alerting decisions
- Cost optimization patterns

#### Coordination Agents (APEX, etc.)
- Workflow orchestration choices
- Communication pattern decisions
- Resource allocation strategies
- Priority management approaches
- Cross-agent collaboration patterns

### Success Criteria Phase 2
- [ ] 15+ context entries created
- [ ] Each entry demonstrates domain expertise
- [ ] Entries show consistent agent philosophy
- [ ] Related context mappings established

## Phase 3: Relationship Mapping (Unit 5)

### Decision Tree Creation
```yaml
# Agent Decision Tree Template
agent_core_philosophy: "[Agent's fundamental approach]"
  influences:
    - domain_choice_1: "[Specific implementation]"
    - domain_choice_2: "[Specific implementation]"
    - domain_choice_3: "[Specific implementation]"
  
  enables:
    - operational_capability_1: "[Enhanced ability]"
    - operational_capability_2: "[Enhanced ability]"
    - domain_expertise_3: "[Specialist knowledge]"
```

### Relationship Enhancement
For each context entry:
- [ ] Add 3+ "Related Context" cross-references
- [ ] Connect to agent's core philosophy
- [ ] Link to Trinity-wide patterns where applicable
- [ ] Show decision inheritance chains

### Success Criteria Phase 3
- [ ] Agent decision tree documented
- [ ] 20+ cross-references between contexts
- [ ] Clear emergence of agent's core principles
- [ ] Decision inheritance chains mapped

## Phase 4: Principle Extraction (Unit 6)

### Agent Principle Template
```markdown
## [Agent]'s [Domain] Principles

**Q: "What core principles guide [Agent]'s [domain] philosophy?"**

**A:** [Agent]'s [domain] philosophy centers on "[Core Philosophy]" - every [domain] choice prioritizes [primary value] over [secondary considerations].

**Evidence:**
- **Principle 1**: [Extracted from contexts]
- **Principle 2**: [Extracted from contexts]  
- **Principle 3**: [Extracted from contexts]
- **Principle 4**: [Extracted from contexts]
- **Principle 5**: [Extracted from contexts]

**[Agent]-Specific Insight:** [Domain systems fail when they prioritize X over Y - core competency trumps all other concerns]

**Source:** Analysis of [N] [Agent] contextual memory entries and decision tree mapping
**Date Extracted:** [Current date]
**Context:** Pattern analysis across [Agent]'s workspace decisions revealing consistent philosophy

**Related Context:**
- [Links to 3+ agent-specific contexts that prove these principles]
- [Link to Trinity Architecture Patterns for framework alignment]

---
```

### Success Criteria Phase 4
- [ ] 5+ core principles extracted from contexts
- [ ] Principles supported by concrete evidence
- [ ] Agent philosophy clearly articulated
- [ ] Alignment with Trinity patterns demonstrated

## Quality Standards

### Evidence Requirements
Every context entry must have:
- [ ] Concrete artifact (file, commit, config)
- [ ] Measurable outcome or benefit
- [ ] Specific date and situation
- [ ] Agent's domain expertise demonstrated

### Anti-Patterns to Avoid
❌ Generic decisions that any agent could make  
❌ Speculation without concrete evidence  
❌ Copying patterns from other agents  
❌ Surface-level "what" instead of deep "why"  
❌ Decisions without domain expertise applied  

### Authenticity Validation
- [ ] Only agent's own workspace scanned
- [ ] All decisions show agent's lived experience
- [ ] Domain expertise clearly demonstrated
- [ ] No external speculation or assumption

## Agent-Specific Adaptations

### For ANALYST
Focus on: Technical architecture, code quality, performance optimization, testing strategies, development workflows

### For IRA  
Focus on: Infrastructure choices, security decisions, deployment strategies, monitoring approaches, cost optimization

### For APEX
Focus on: Coordination patterns, workflow orchestration, resource management, communication strategies, priority frameworks

### For New Agents
1. Identify core domain of expertise
2. Adapt categories to specialist knowledge area
3. Focus on decisions requiring domain expertise
4. Emphasize unique value agent brings to Trinity

## Expected Outcomes

### Per Agent (6 units)
- [ ] 20+ domain-specific context entries
- [ ] 1 agent decision tree
- [ ] 1 agent principles document  
- [ ] 30+ relationship mappings
- [ ] Deep domain expertise documented

### For Trinity Framework
- [ ] Proof of contextual memory value through depth
- [ ] Replicable pattern for any agent
- [ ] Foundation for cross-agent knowledge sharing
- [ ] Template for future agent onboarding

## Rollout Strategy

### Sequence
1. **ANALYST** - Technical domain (Units 7-12)
2. **IRA** - Infrastructure domain (Units 13-18)  
3. **APEX** - Coordination domain (Units 19-24)
4. **Cross-pollination** - Relationship mapping between agents (Units 25-26)

### Success Metrics
- Each agent achieves 20+ context entries
- Query system returns accurate agent-specific answers
- Clear differentiation between agent domains
- Trinity-wide pattern library emerges

---

*"The goal isn't to document everything quickly. It's to document one domain so well that the value becomes undeniable and the patterns become reusable."* - Agent Domain Extraction Philosophy