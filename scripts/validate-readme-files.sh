#!/bin/bash

# Validate README Files Script
# Checks for missing README files and validates existing ones

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "=========================================="
echo "  DgtlEnv README File Validation"
echo "=========================================="
echo

# Counters
TOTAL_DIRS=0
MISSING_README=0
VALID_README=0
INVALID_README=0

echo "🔍 Scanning directories for README files..."
echo

# Find all directories (excluding .git, .cursor, .vscode)
while IFS= read -r -d '' dir; do
    ((TOTAL_DIRS++))

    if [ -f "$dir/README.md" ]; then
        # Check if README has basic required sections
        if grep -q "## 📁 Contents" "$dir/README.md" && \
           grep -q "## 🚀 Quick Start" "$dir/README.md"; then
            echo -e "${GREEN}✅${NC} $dir/README.md"
            ((VALID_README++))
        else
            echo -e "${YELLOW}⚠️ ${NC} $dir/README.md (missing required sections)"
            ((INVALID_README++))
        fi
    else
        echo -e "${RED}❌${NC} $dir (missing README.md)"
        ((MISSING_README++))
    fi
done < <(find . -type d -not -path "./.git*" -not -path "./.cursor*" -not -path "./.vscode*" -print0)

echo
echo "=========================================="
echo "  Validation Results"
echo "=========================================="
echo "Total Directories: $TOTAL_DIRS"
echo -e "Valid README Files: ${GREEN}$VALID_README${NC}"
echo -e "Invalid README Files: ${YELLOW}$INVALID_README${NC}"
echo -e "Missing README Files: ${RED}$MISSING_README${NC}"
echo

# Calculate percentage
if [ $TOTAL_DIRS -gt 0 ]; then
    COVERAGE=$(( (VALID_README * 100) / TOTAL_DIRS ))
    echo "README Coverage: $COVERAGE%"

    if [ $COVERAGE -eq 100 ]; then
        echo -e "${GREEN}🎉 All directories have valid README files!${NC}"
    elif [ $COVERAGE -ge 80 ]; then
        echo -e "${GREEN}✅ Good README coverage${NC}"
    elif [ $COVERAGE -ge 60 ]; then
        echo -e "${YELLOW}⚠️ Moderate README coverage${NC}"
    else
        echo -e "${RED}❌ Poor README coverage${NC}"
    fi
fi

echo
echo "=========================================="
echo "  Recommendations"
echo "=========================================="

if [ $MISSING_README -gt 0 ]; then
    echo -e "${BLUE}📝 Create README files for missing directories:${NC}"
    echo "Use: ./scripts/create-directory-readme.sh <directory-path>"
    echo
fi

if [ $INVALID_README -gt 0 ]; then
    echo -e "${BLUE}🔧 Update invalid README files to include:${NC}"
    echo "- ## 📁 Contents section"
    echo "- ## 🚀 Quick Start section"
    echo "- Proper cross-references"
    echo
fi

echo -e "${BLUE}📊 Run this script regularly to maintain documentation quality${NC}"
echo

# Exit with appropriate code
if [ $MISSING_README -eq 0 ] && [ $INVALID_README -eq 0 ]; then
    exit 0
else
    exit 1
fi
