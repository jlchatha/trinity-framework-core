#!/bin/bash
# Regenerate INDEX.md for Trinity Contextual Memory

MEMORY_BASE="$1"
if [ -z "$MEMORY_BASE" ]; then
    MEMORY_BASE="$(dirname "$0")/.."
fi

cd "$MEMORY_BASE"

# Start with header
cat > INDEX.md << 'EOF'
# Trinity Contextual Memory - Index

**Purpose**: Answer "why" questions about Trinity's evolution  
**Method**: Simple markdown files, no fancy features  
**Success**: When someone asks "why", we have an answer  

## Entries by Stream
EOF

# Add each stream
for stream in technical strategic operational cultural; do
  if [ -d "entries/$stream" ] && [ "$(ls -A entries/$stream/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "" >> INDEX.md
    echo "### ${stream^}" >> INDEX.md
    for file in entries/$stream/*.md; do
      if [ -f "$file" ]; then
        title=$(grep "^## " "$file" | head -1 | sed 's/## //')
        question=$(grep "^\*\*Q:" "$file" | head -1 | sed 's/\*\*Q: "//' | sed 's/"$//')
        echo "- [$title]($file)" >> INDEX.md
      fi
    done
  fi
done

# Add pending section if entries exist
if [ -d "entries/pending" ] && [ "$(ls -A entries/pending/*.md 2>/dev/null | wc -l)" -gt 0 ]; then
  echo "" >> INDEX.md
  echo "### Pending Review" >> INDEX.md
  for file in entries/pending/*.md; do
    if [ -f "$file" ]; then
      title=$(grep "^## " "$file" | head -1 | sed 's/## //')
      echo "- [$title]($file)" >> INDEX.md
    fi
  done
fi

echo "INDEX.md regenerated with $(find entries -name "*.md" | wc -l) entries"