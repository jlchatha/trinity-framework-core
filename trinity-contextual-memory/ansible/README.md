# Trinity Contextual Memory - Ansible Playbooks

## Quick Start

### 1. Query Context Memory

Find answers to "why" questions:

```bash
# Default query
ansible-playbook context-query.yml

# Custom query
ansible-playbook context-query.yml -e "question='Why did we move to Kubernetes?'"

# Another example
ansible-playbook context-query.yml -e "question='Why use Protocol Files?'"
```

### 2. Extract New Contexts

Scan Trinity workspaces for new decisions and questions:

```bash
# Run extraction (scans last 24 hours of AARs)
ansible-playbook context-extract-unit.yml

# Check pending entries after extraction
ls -la ~/trinity-contextual-memory/entries/pending/
```

## How It Works

### Context Query (`context-query.yml`)
1. Extracts keywords from your question
2. Searches all context entries for matches
3. Scores entries by relevance
4. Returns the best matching answer

### Context Extraction (`context-extract-unit.yml`)
1. Scans AAR sessions from the last 24 hours
2. Extracts decisions, learnings, and insights
3. Finds unanswered "why" questions in STATUS.md files
4. Creates pending entries for review
5. Updates the INDEX.md automatically

## Directory Structure

```
~/trinity-contextual-memory/
├── INDEX.md                    # Auto-generated index
├── entries/
│   ├── technical/             # Technical decisions
│   ├── strategic/             # Business decisions
│   ├── operational/           # Operational lessons
│   ├── cultural/              # Principles
│   └── pending/               # Entries needing review
└── ansible/                    # These playbooks
```

## Tips

- Run extraction daily to capture new contexts
- Review pending entries and move to appropriate streams
- Keep entries focused on answering "why" questions
- Add evidence and dates to support decisions

## No Database Required!

Everything runs with simple shell commands and grep. No complex infrastructure needed.