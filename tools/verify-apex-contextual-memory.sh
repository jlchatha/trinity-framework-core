#!/bin/bash
#
# Verification Script for APEX Contextual Memory Deployment
# Ensures all components are properly installed and functional
#

echo "==================================================="
echo "APEX Contextual Memory Verification"
echo "==================================================="
echo ""

# Check workspace
if [[ ! "$PWD" == *"trinity-apex-workspace"* ]]; then
    echo "ERROR: Not in APEX workspace"
    echo "Please run from: /home/alreadyinuse/git/trinity-apex-workspace"
    exit 1
fi

echo "1. Checking directory structure..."
errors=0

# Check main directories
dirs=(
    "trinity-contextual-memory"
    "trinity-contextual-memory/entries"
    "trinity-contextual-memory/entries/technical"
    "trinity-contextual-memory/entries/strategic"
    "trinity-contextual-memory/entries/operational"
    "trinity-contextual-memory/entries/cultural"
    "trinity-contextual-memory/ansible"
    "trinity-contextual-memory/templates"
)

for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✓ $dir"
    else
        echo "  ✗ Missing: $dir"
        ((errors++))
    fi
done

echo ""
echo "2. Checking essential files..."

files=(
    "trinity-contextual-memory/INDEX.md"
    "trinity-contextual-memory/README.md"
    "trinity-contextual-memory/APEX-DOMAIN-CONFIG.md"
    "trinity-contextual-memory/ansible/context-query.yml"
    "trinity-contextual-memory/ansible/context-extract-unit.yml"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ Missing: $file"
        ((errors++))
    fi
done

echo ""
echo "3. Checking APEX-specific content..."

# Check for APEX entry
if grep -q "APEX Beta Onboarding Sequence" trinity-contextual-memory/INDEX.md 2>/dev/null; then
    echo "  ✓ APEX entry found in INDEX.md"
else
    echo "  ✗ APEX entry missing from INDEX.md"
    ((errors++))
fi

# Check for HISTORIAN artifacts (should be removed)
historian_files=$(find trinity-contextual-memory -name "*historian*" -o -name "*HISTORIAN*" | grep -v README | wc -l)
if [ "$historian_files" -eq 0 ]; then
    echo "  ✓ HISTORIAN-specific files removed"
else
    echo "  ✗ Found $historian_files HISTORIAN files (should be 0)"
    ((errors++))
fi

echo ""
echo "4. Testing query functionality..."

cd trinity-contextual-memory
if ansible-playbook ansible/context-query.yml -e "query='ship beats perfect'" > /tmp/apex-test.log 2>&1; then
    echo "  ✓ Query system functional"
    if grep -q "Ship Beats Perfect" /tmp/apex-test.log; then
        echo "  ✓ Query returned expected results"
    else
        echo "  ✗ Query didn't return expected results"
        ((errors++))
    fi
else
    echo "  ✗ Query system failed"
    ((errors++))
fi
cd ..

echo ""
echo "5. Checking helper scripts..."

if [ -x "trinity-contextual-memory/query-context.sh" ]; then
    echo "  ✓ query-context.sh is executable"
else
    echo "  ✗ query-context.sh missing or not executable"
    ((errors++))
fi

if [ -x "trinity-contextual-memory/add-context.sh" ]; then
    echo "  ✓ add-context.sh is executable"
else
    echo "  ✗ add-context.sh missing or not executable"
    ((errors++))
fi

echo ""
echo "6. Counting context entries..."

total_entries=$(find trinity-contextual-memory/entries -name "*.md" -type f | wc -l)
apex_entries=$(find trinity-contextual-memory/entries -name "*apex*" -type f | wc -l)

echo "  Total context entries: $total_entries"
echo "  APEX-specific entries: $apex_entries"

echo ""
echo "==================================================="
if [ $errors -eq 0 ]; then
    echo "✓ Verification PASSED - System ready for use!"
    echo ""
    echo "Quick Start:"
    echo "  cd trinity-contextual-memory"
    echo "  ./query-context.sh 'beta onboarding'"
    echo ""
    echo "Add new contexts with:"
    echo "  ./add-context.sh"
else
    echo "✗ Verification FAILED - Found $errors errors"
    echo ""
    echo "Please run the deployment script again:"
    echo "  /home/alreadyinuse/git/trinity-historian-workspace/tools/deploy-contextual-memory-apex.sh"
fi
echo "==================================================="

# Save verification results
cat > trinity-contextual-memory/.verification-results << EOF
Verification Date: $(date)
Total Errors: $errors
Total Entries: $total_entries
APEX Entries: $apex_entries
Status: $([ $errors -eq 0 ] && echo "PASSED" || echo "FAILED")
EOF