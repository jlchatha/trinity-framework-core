# Trinity Contextual Memory - Complete Implementation Plan

## Mission Statement
Create a living contextual memory system for Trinity Framework that preserves the "why" behind decisions, the evolution of concepts, and the lessons learned throughout our journey.

## Purpose
This pilot serves three critical goals:
1. **Preserve Trinity's institutional knowledge** before it's lost
2. **Test contextual memory concepts** on real, complex history
3. **Create a template** for contextual memory in other systems

## Phase 1: Foundation (COMPLETE)

### Structure Created
```
trinity-contextual-memory/
├── INDEX.md                    # Main navigation
├── entries/
│   ├── technical/             # Technical decisions
│   ├── strategic/             # Business decisions
│   ├── operational/           # Operational lessons
│   └── cultural/              # Principles and philosophy
└── templates/                  # Entry templates
```

### Entry Format
```markdown
## [Context Title]

**Q: "[Specific why question]"**

**A:** [2-3 sentence answer]

**Evidence:**
- [Fact with date/metric]
- [Supporting evidence]
- [Additional proof point]

**Key Insight:** [One-line takeaway]

---
```

### Initial 10 Entries Created
1. OVERSEER/APEX duality (strategic)
2. WorkSpaces to K8s migration (operational)
3. Protocol Files choice (technical)
4. Ship beats perfect origin (cultural)
5. Framework 2.0 birth (technical)
6. Open source strategy (strategic)
7. 100GB storage decision (operational)
8. Unit measurements shift (cultural)
9. Trinity-AD 6-hour build (technical)
10. Barracuda 6-minute record (operational)

## Phase 2: Ansible-Powered Operations

### 1. Daily Context Extraction (context-extract-unit.yml)

```yaml
---
- name: Unit Context Extraction Operations
  hosts: localhost
  vars:
    memory_base: ~/trinity-contextual-memory
    trinity_workspaces:
      - ~/git/trinity-framework
      - ~/git/trinity-overseer-workspace
      - ~/git/trinity-mvp-improvement
      - ~/git/trinity-mvp-historian
    
  tasks:
    # 1. Scan for new decisions and learnings
    - name: Find recent AAR sessions
      find:
        paths: "{{ item }}/AAR/sessions"
        patterns: "*.md"
        age: "-1d"
      loop: "{{ trinity_workspaces }}"
      register: recent_aars
      
    - name: Extract decisions from AARs
      shell: |
        grep -h -A 2 -E "(Decision:|Learned:|Discovered:|Realized:)" {{ item.path }} | 
        grep -v "^--$" |
        awk '/Decision:|Learned:|Discovered:|Realized:/ {getline; print}'
      loop: "{{ recent_aars.results | map(attribute='files') | flatten }}"
      when: item.path is defined
      register: decisions
      
    # 2. Scan for why questions in STATUS.md files
    - name: Check for unanswered why questions
      shell: |
        grep -h "Why" {{ item }}/STATUS.md 2>/dev/null || true
      loop: "{{ trinity_workspaces }}"
      register: why_questions
      
    # 3. Auto-generate context entry stubs
    - name: Create context entries for new decisions
      template:
        src: auto-context-entry.j2
        dest: "{{ memory_base }}/entries/pending/{{ ansible_date_time.epoch }}-{{ idx }}.md"
      loop: "{{ decisions.results | selectattr('stdout_lines', 'defined') | map(attribute='stdout_lines') | flatten }}"
      loop_control:
        index_var: idx
      when: item | length > 0
      
    # 4. Update the INDEX
    - name: Regenerate INDEX.md with all entries
      shell: |
        cd {{ memory_base }}
        echo "# Trinity Contextual Memory - Index" > INDEX.md
        echo "" >> INDEX.md
        echo "## Entries by Stream" >> INDEX.md
        for stream in technical strategic operational cultural; do
          echo "" >> INDEX.md
          echo "### ${stream^}" >> INDEX.md
          for file in entries/$stream/*.md; do
            if [ -f "$file" ]; then
              title=$(grep "^## " "$file" | head -1 | sed 's/## //')
              echo "- [$title]($file)" >> INDEX.md
            fi
          done
        done
```

### 2. Context Query Operations (context-query.yml)

```yaml
---
- name: Query Trinity Contextual Memory
  hosts: localhost
  vars:
    memory_base: ~/trinity-contextual-memory
    query: "{{ question | default('Why did we choose Protocol Files?') }}"
    
  tasks:
    # 1. Search for relevant entries
    - name: Search context entries for keywords
      shell: |
        # Extract keywords from question
        keywords=$(echo "{{ query }}" | tr ' ' '\n' | grep -E "^[A-Za-z]{4,}" | tr '\n' '|' | sed 's/|$//')
        
        # Search all entries
        grep -r -l -i -E "$keywords" {{ memory_base }}/entries/ || true
      register: matching_files
      
    # 2. Score relevance
    - name: Score entry relevance
      shell: |
        # Count keyword matches
        keywords=$(echo "{{ query }}" | tr ' ' '\n' | grep -E "^[A-Za-z]{4,}")
        score=0
        for word in $keywords; do
          count=$(grep -i -c "$word" "{{ item }}" || true)
          score=$((score + count))
        done
        echo "{{ item }}:$score"
      loop: "{{ matching_files.stdout_lines }}"
      when: matching_files.stdout_lines is defined
      register: scored_entries
      
    # 3. Get best match
    - name: Extract best matching entry
      shell: |
        # Sort by score and get top entry
        best=$(echo "{{ scored_entries.results | map(attribute='stdout') | join('\n') }}" | 
               sort -t: -k2 -nr | head -1 | cut -d: -f1)
        
        if [ -n "$best" ]; then
          cat "$best"
        else
          echo "No context found for: {{ query }}"
        fi
      register: answer
      
    - name: Display answer
      debug:
        msg: |
          Question: {{ query }}
          
          {{ answer.stdout }}
```

### 3. Memory Maintenance Operations (context-maintain.yml)

```yaml
---
- name: Trinity Context Memory Maintenance
  hosts: localhost
  vars:
    memory_base: ~/trinity-contextual-memory
    
  tasks:
    # 1. Find duplicate contexts
    - name: Identify potential duplicate entries
      shell: |
        cd {{ memory_base }}/entries
        
        # Find files with similar questions
        for file1 in */*.md; do
          q1=$(grep "^\*\*Q:" "$file1" | head -1)
          for file2 in */*.md; do
            if [ "$file1" != "$file2" ]; then
              q2=$(grep "^\*\*Q:" "$file2" | head -1)
              # Simple similarity check
              if [ "${q1:0:20}" = "${q2:0:20}" ]; then
                echo "Potential duplicate: $file1 <-> $file2"
              fi
            fi
          done
        done
      register: duplicates
      
    # 2. Validate evidence freshness
    - name: Check for stale evidence
      shell: |
        # Find entries with dates older than 6 phases
        current_date=$(date +%s)
        phase_seconds=$((30 * 24 * 60 * 60))  # 30 days
        stale_threshold=$((current_date - (6 * phase_seconds)))
        
        grep -r -l -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" {{ memory_base }}/entries/ | while read file; do
          dates=$(grep -o -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" "$file")
          for date in $dates; do
            date_seconds=$(date -d "$date" +%s 2>/dev/null || echo 0)
            if [ $date_seconds -lt $stale_threshold ] && [ $date_seconds -gt 0 ]; then
              echo "Stale evidence in: $file (date: $date)"
              break
            fi
          done
        done
      register: stale_entries
      
    # 3. Generate relationship map
    - name: Build context relationship map
      shell: |
        cd {{ memory_base }}
        echo "digraph ContextMap {" > relationships.dot
        echo "  rankdir=LR;" >> relationships.dot
        
        # Extract "Related:" links
        grep -r "^Related:" entries/ | while IFS=: read file _ related; do
          source=$(basename "$file" .md)
          for link in $(echo "$related" | grep -o "\[.*\]" | tr -d '[]'); do
            target=$(basename "$link" .md)
            echo "  \"$source\" -> \"$target\";" >> relationships.dot
          done
        done
        
        echo "}" >> relationships.dot
        
        # Generate visual if graphviz available
        if command -v dot &> /dev/null; then
          dot -Tpng relationships.dot -o relationships.png
          echo "Relationship map generated: relationships.png"
        fi
```

### 4. Context Integration Module (library/trinity_context.py)

```python
#!/usr/bin/python
# Ansible module for Trinity contextual memory operations

from ansible.module_utils.basic import AnsibleModule
import os
import re
import glob

def query_context(question, memory_path, streams=None):
    """Query the contextual memory for answers"""
    if streams is None:
        streams = ['technical', 'strategic', 'operational', 'cultural']
    
    # Extract keywords from question
    keywords = [w.lower() for w in re.findall(r'\b[A-Za-z]{4,}\b', question)]
    
    results = []
    for stream in streams:
        stream_path = os.path.join(memory_path, 'entries', stream)
        if not os.path.exists(stream_path):
            continue
            
        for entry_file in glob.glob(os.path.join(stream_path, '*.md')):
            with open(entry_file, 'r') as f:
                content = f.read().lower()
                
            # Score based on keyword matches
            score = sum(content.count(keyword) for keyword in keywords)
            
            # Boost score if question matches
            if '**q:' in content:
                q_match = re.search(r'\*\*q:\s*"([^"]+)"', content, re.IGNORECASE)
                if q_match and any(kw in q_match.group(1).lower() for kw in keywords):
                    score += 10
                    
            if score > 0:
                results.append({
                    'file': entry_file,
                    'stream': stream,
                    'score': score,
                    'content': open(entry_file).read()
                })
    
    # Sort by score and return best match
    results.sort(key=lambda x: x['score'], reverse=True)
    return results[0] if results else None

def main():
    module = AnsibleModule(
        argument_spec=dict(
            action=dict(required=True, choices=['query', 'add', 'validate']),
            question=dict(required=False, type='str'),
            memory_path=dict(required=True, type='str'),
            streams=dict(required=False, type='list', default=None),
            entry=dict(required=False, type='dict')
        )
    )
    
    action = module.params['action']
    memory_path = module.params['memory_path']
    
    if action == 'query':
        question = module.params['question']
        streams = module.params['streams']
        
        result = query_context(question, memory_path, streams)
        
        if result:
            module.exit_json(
                changed=False,
                answer=result['content'],
                source=result['file'],
                stream=result['stream'],
                score=result['score']
            )
        else:
            module.exit_json(
                changed=False,
                answer="No context found for this question",
                source=None
            )
    
    # Add more actions as needed...

if __name__ == '__main__':
    main()
```

### 5. Example Usage Playbook (use-contextual-memory.yml)

```yaml
---
- name: Use Trinity Contextual Memory
  hosts: localhost
  vars:
    memory_base: ~/trinity-contextual-memory
    
  tasks:
    # Example 1: Query for specific context
    - name: Ask why we chose Protocol Files
      trinity_context:
        action: query
        question: "Why did Trinity choose Protocol Files over a database?"
        memory_path: "{{ memory_base }}"
        streams: ['technical']
      register: protocol_answer
      
    - debug:
        msg: |
          Question: Why Protocol Files?
          Answer: {{ protocol_answer.answer }}
          Source: {{ protocol_answer.source }}
    
    # Example 2: Extract context from new AAR
    - name: Process today's AAR for context
      include_tasks: context-extract-unit.yml
      vars:
        aar_file: "{{ aar_path }}"
    
    # Example 3: Monthly maintenance
    - name: Run monthly context maintenance
      include_tasks: context-maintain.yml
      when: ansible_date_time.day == "1"
```

## Evolution Path

### Phase 1 (COMPLETE): Manual markdown entries
- ✅ 10 priority entries documented
- ✅ Simple directory structure
- ✅ Clear entry format
- ✅ INDEX.md for navigation

### Phase 2 (CURRENT): Ansible-powered operations
- Query existing contexts
- Extract new contexts from AARs
- Maintain and validate entries
- Generate relationship maps

### Phase 3 (FUTURE): ORCA MCP integration
- MCP server for queries
- AI-assisted relationship discovery
- Automated context extraction
- Real-time updates

## Success Metrics

### Quantitative
- Number of "why" questions answered: Target 50+
- Average query resolution time: <30 seconds
- Cross-references per entry: 2-3 average
- Update frequency: 2-3 entries per week

### Qualitative  
- New team members understand decisions faster
- Fewer repeated mistakes
- Better architectural decisions
- Preserved institutional knowledge

## Key Principles
- **Simple beats complex**: Markdown files over databases
- **Ship beats perfect**: Working system over elaborate architecture
- **Answered beats architected**: Focus on answering "why" questions
- **Focus beats features**: Do ONE thing well