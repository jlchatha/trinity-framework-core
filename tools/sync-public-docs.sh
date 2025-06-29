#!/bin/bash
# Priority #1 Tool - Must pass before any other work

source $HISTORIAN_HOME/setup-env.sh 2>/dev/null || {
    HISTORIAN_HOME="/home/alreadyinuse/git/trinity-historian-workspace"
    TRINITY_REPO="$HISTORIAN_HOME/trinity-mvp-working"
    TRINITY_DOCS="$HISTORIAN_HOME/trinity-docs-site"
    REPORTS_DIR="$HISTORIAN_HOME/reports"
}

echo "🔍 Trinity MVP Public Documentation Sync Check"
echo "============================================="

REPORT_FILE="$REPORTS_DIR/sync-report-$(date +%Y%m%d-%H%M%S).md"
ISSUES_FOUND=0

echo "# Trinity MVP Public Documentation Sync Report" > "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check if Trinity repo exists
if [ ! -d "$TRINITY_REPO" ]; then
    echo "❌ Trinity repository not found at $TRINITY_REPO"
    ISSUES_FOUND=1
    exit 1
fi

cd "$TRINITY_REPO"

echo "## Repository Status" >> "$REPORT_FILE"
echo "- Location: $TRINITY_REPO" >> "$REPORT_FILE"
echo "- Last commit: $(git log -1 --format='%h - %s (%cr)')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check key public documentation files
echo "## Public Documentation Files" >> "$REPORT_FILE"

PUBLIC_FILES=("README.md" "CHANGELOG.md" "docs/user/quick-start.md" "docs/user/user-guide.md" "docs/developer/api-reference.md")

for file in "${PUBLIC_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists" | tee -a "$REPORT_FILE"
        # Check if file is recent (modified within last 30 days)
        if [ $(find "$file" -mtime -30 | wc -l) -eq 0 ]; then
            echo "⚠️  $file is older than 30 days" | tee -a "$REPORT_FILE"
        fi
    else
        echo "❌ $file missing" | tee -a "$REPORT_FILE"
        ISSUES_FOUND=1
    fi
done

echo "" >> "$REPORT_FILE"

# Check for recent changes not documented
echo "## Recent Changes Analysis" >> "$REPORT_FILE"
RECENT_COMMITS=$(git log --since="7 days ago" --oneline | wc -l)
echo "- Commits in last 7 days: $RECENT_COMMITS" >> "$REPORT_FILE"

if [ $RECENT_COMMITS -gt 0 ]; then
    echo "Recent commits:" >> "$REPORT_FILE"
    git log --since="7 days ago" --oneline >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Summary
echo "## Summary" >> "$REPORT_FILE"
if [ $ISSUES_FOUND -eq 0 ]; then
    echo "✅ Public documentation appears current" >> "$REPORT_FILE"
    echo "✅ Public documentation sync check PASSED"
else
    echo "❌ Issues found requiring attention" >> "$REPORT_FILE"
    echo "❌ Public documentation sync check FAILED"
fi

echo ""
echo "📄 Full report saved to: $REPORT_FILE"

exit $ISSUES_FOUND