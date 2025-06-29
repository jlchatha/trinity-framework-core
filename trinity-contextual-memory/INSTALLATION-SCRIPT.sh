#!/bin/bash

# Trinity Contextual Memory Installation Script
# Version: 1.0
# Purpose: Deploy contextual memory system to any Trinity agent workspace

set -e  # Exit on any error

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HISTORIAN_SOURCE="/home/alreadyinuse/git/trinity-historian-workspace/trinity-contextual-memory"
TARGET_WORKSPACE="${1:-$(pwd)}"
AGENT_NAME="${2:-unknown}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[INSTALL]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Validation functions
check_prerequisites() {
    log "Checking prerequisites..."
    
    # Check if we're in a Trinity workspace
    if [[ ! -f "${TARGET_WORKSPACE}/AGENT.md" ]]; then
        error "Target directory is not a Trinity workspace (no AGENT.md found)"
    fi
    
    # Check for Ansible
    if ! command -v ansible &> /dev/null; then
        error "Ansible is required but not installed"
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        error "Git is required but not installed"
    fi
    
    # Check if source exists
    if [[ ! -d "$HISTORIAN_SOURCE" ]]; then
        error "HISTORIAN source not found at: $HISTORIAN_SOURCE"
    fi
    
    success "Prerequisites check passed"
}

# Create backup of existing contextual memory if it exists
backup_existing() {
    if [[ -d "${TARGET_WORKSPACE}/trinity-contextual-memory" ]]; then
        log "Backing up existing contextual memory system..."
        mv "${TARGET_WORKSPACE}/trinity-contextual-memory" \
           "${TARGET_WORKSPACE}/trinity-contextual-memory.backup.$(date +%Y%m%d_%H%M%S)"
        success "Existing system backed up"
    fi
}

# Copy core system from HISTORIAN
copy_core_system() {
    log "Copying core contextual memory system..."
    
    cp -r "$HISTORIAN_SOURCE" "${TARGET_WORKSPACE}/trinity-contextual-memory"
    success "Core system copied"
}

# Remove HISTORIAN-specific content
clean_historian_content() {
    log "Removing HISTORIAN-specific content..."
    
    cd "${TARGET_WORKSPACE}/trinity-contextual-memory"
    
    # Remove HISTORIAN-specific entries
    find entries/ -name "historian-*" -type f -delete
    rm -f entries/cultural/historian-documentation-principles.md
    rm -f entries/technical/historian-github-pages-choice.md
    
    # Remove HISTORIAN-specific docs
    rm -f HISTORIAN-DECISION-TREE.md
    rm -f HISTORIAN-EXEMPLAR-PATTERNS.md
    
    success "HISTORIAN-specific content removed"
}

# Create agent-agnostic INDEX.md
create_clean_index() {
    log "Creating clean INDEX.md..."
    
    cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/INDEX.md" << 'EOF'
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

## Agent Domain Entries
*Agent-specific entries will appear here as they are created*

EOF
    
    success "Clean INDEX.md created"
}

# Configure for specific agent type
configure_agent() {
    log "Configuring for agent: $AGENT_NAME"
    
    mkdir -p "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/${AGENT_NAME,,}/"
    
    case "${AGENT_NAME,,}" in
        "analyst")
            cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/analyst/domain-focus.md" << 'EOF'
# ANALYST Domain Focus

**Profile**: Technical Domain Expert  
**Deployment Scope**: Private Framework  

## Primary Expertise Areas
- Technical architecture decisions
- Code quality patterns  
- Performance optimization choices
- Testing strategy decisions
- Development workflow evolution

## Extraction Keywords
- architecture, performance, testing, refactor, optimize, implement
- python, javascript, typescript, react, node, database
- code quality, technical debt, optimization, scalability

## Success Criteria
>95% query accuracy for technical architecture questions
EOF
            ;;
        "ira")
            cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/ira/domain-focus.md" << 'EOF'
# IRA Domain Focus

**Profile**: Infrastructure & Security Expert  
**Deployment Scope**: Private Framework  

## Primary Expertise Areas
- Infrastructure resilience choices
- Security hardening decisions
- Deployment strategy evolution
- Cost optimization patterns
- Monitoring and alerting design

## Extraction Keywords
- infrastructure, deploy, security, monitoring, kubernetes, docker
- terraform, ansible, cloudformation, aws, cost, optimization
- resilience, scalability, automation, ci/cd

## Success Criteria
>95% query accuracy for infrastructure and security questions
EOF
            ;;
        "apex")
            cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/apex/domain-focus.md" << 'EOF'
# APEX Domain Focus

**Profile**: Beta Coordination & Framework Education Expert  
**Deployment Scope**: Both Private & Public/Beta  
**Public Role**: APEX - Framework Education & Beta Coordination  
**Private Role**: APEX - Internal Beta Management & User Onboarding  

## Primary Expertise Areas
- Beta coordination and onboarding decisions
- Framework education and demonstration strategies
- Workspace and tool guidance patterns
- Public-facing collaboration approaches
- User experience optimization choices

## Extraction Keywords
- beta, onboarding, education, demonstration, workspace, guidance
- coordination, user, experience, framework, teaching
- process, efficiency, communication, delegation

## Success Criteria
>95% query accuracy for beta coordination and framework education questions

## Note
APEX operates in both private framework and public/beta environments, 
with specialized expertise in bridging internal knowledge to external users.
EOF
            ;;
        "overseer")
            cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/overseer/domain-focus.md" << 'EOF'
# OVERSEER Domain Focus

**Profile**: Private Framework Coordination Expert  
**Deployment Scope**: Private Framework ONLY  
**Note**: OVERSEER exists only in private framework - never in public/beta  

## Primary Expertise Areas
- Coordination pattern decisions
- Workflow orchestration choices
- Resource allocation strategies
- Cross-agent collaboration patterns
- Priority management evolution

## Extraction Keywords
- workflow, orchestration, coordination, priority, resource
- management, allocation, collaboration, planning
- process, efficiency, communication, delegation

## Success Criteria
>95% query accuracy for coordination and workflow questions

## Critical Understanding
OVERSEER is the internal coordination agent that never appears in public
or beta environments. All public coordination is handled by APEX.
EOF
            ;;
        *)
            warning "Unknown agent type: $AGENT_NAME. Creating generic configuration."
            cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/templates/${AGENT_NAME,,}/domain-focus.md" << 'EOF'
# Agent Domain Focus

## Primary Expertise Areas
- [Define your domain expertise areas]
- [Add specific decision categories]
- [Include workflow patterns]

## Extraction Keywords
- [Add domain-specific keywords for extraction]
- [Include technology/tool keywords]
- [Add process/pattern keywords]

## Success Criteria
>95% query accuracy for domain-specific questions
EOF
            ;;
    esac
    
    success "Agent configuration created"
}

# Test installation
test_installation() {
    log "Testing installation..."
    
    cd "${TARGET_WORKSPACE}/trinity-contextual-memory"
    
    # Test Ansible connectivity
    if ! ansible localhost -m ping &>/dev/null; then
        error "Ansible connectivity test failed"
    fi
    
    # Test query system
    if ! ansible-playbook ansible/context-query.yml -e "query='Trinity'" &>/dev/null; then
        error "Query system test failed"
    fi
    
    success "Installation tests passed"
}

# Create getting started guide
create_getting_started() {
    log "Creating getting started guide..."
    
    cat > "${TARGET_WORKSPACE}/trinity-contextual-memory/GETTING-STARTED-${AGENT_NAME^^}.md" << EOF
# Getting Started - ${AGENT_NAME^^} Contextual Memory

## Quick Start
1. **Read the Template**: \`AGENT-DOMAIN-EXTRACTION-TEMPLATE.md\`
2. **Check Your Focus**: \`templates/${AGENT_NAME,,}/domain-focus.md\`
3. **Test the System**: \`ansible-playbook ansible/context-query.yml -e "query='Trinity'"\`

## Next Steps  
1. Begin Phase 1: Deep Extraction
   - Find 15+ ${AGENT_NAME,,}-specific decisions in your workspace
   - Use extraction queries from the template
   - Focus on decisions requiring your domain expertise

2. Create Your First Context Entry
   - Use the template format exactly
   - Document a significant ${AGENT_NAME,,} decision
   - Include concrete evidence and artifacts

3. Test Your Entry
   - Query the system with your decision topic
   - Verify it returns your entry accurately
   - Add relationship mappings to existing contexts

## 6-Unit Program
- **Units 1-2**: Domain extraction and evidence gathering
- **Units 3-4**: Context creation and relationship mapping
- **Units 5-6**: Domain authority and principle extraction

## Support
- Template: \`AGENT-DOMAIN-EXTRACTION-TEMPLATE.md\`
- Guidelines: \`EXPANSION-GUIDELINES.md\`
- Help: Consult HISTORIAN for system questions

**Goal**: 20+ ${AGENT_NAME,,}-specific contexts with >95% query accuracy
EOF
    
    success "Getting started guide created"
}

# Main installation function
main() {
    echo "=========================================="
    echo "Trinity Contextual Memory Installation"
    echo "=========================================="
    echo "Target Workspace: $TARGET_WORKSPACE"
    echo "Agent Name: $AGENT_NAME"
    echo "Source: $HISTORIAN_SOURCE"
    echo "=========================================="
    
    check_prerequisites
    backup_existing
    copy_core_system
    clean_historian_content
    create_clean_index
    configure_agent
    test_installation
    create_getting_started
    
    echo "=========================================="
    success "Installation completed successfully!"
    echo "=========================================="
    echo ""
    echo "Next Steps:"
    echo "1. cd trinity-contextual-memory"
    echo "2. Read GETTING-STARTED-${AGENT_NAME^^}.md"  
    echo "3. Read AGENT-DOMAIN-EXTRACTION-TEMPLATE.md"
    echo "4. Begin Phase 1: Deep Extraction"
    echo ""
    echo "Test the system:"
    echo "ansible-playbook ansible/context-query.yml -e \"query='Trinity'\""
}

# Script usage
usage() {
    echo "Usage: $0 [target_workspace] [agent_name]"
    echo ""
    echo "Arguments:"
    echo "  target_workspace  Path to Trinity agent workspace (default: current directory)"
    echo "  agent_name        Agent name: ANALYST, IRA, APEX, etc. (default: unknown)"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/analyst-workspace ANALYST"
    echo "  $0 . IRA"
}

# Handle help flags
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Run installation
main "$@"