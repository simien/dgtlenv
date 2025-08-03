#!/bin/bash

# Validate README Structure Script
# Compares visual directory structures in README files with actual directory structure

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "=========================================="
echo "  DgtlEnv README Structure Validation"
echo "=========================================="
echo

# Check if specific file is provided
if [ $# -eq 1 ]; then
    README_FILE="$1"
    if [ ! -f "$README_FILE" ]; then
        echo -e "${RED}Error: File '$README_FILE' does not exist${NC}"
        exit 1
    fi

    echo -e "${BLUE}Validating structure in: $README_FILE${NC}"
    echo

    # Get the directory this README is for
    README_DIR=$(dirname "$README_FILE")

    # Extract visual structure from README
    echo "📋 Visual structure found in README:"
    grep -A 20 -B 5 "├──\|└──\|│   " "$README_FILE" || echo "No visual structure found"
    echo

    # Get actual directory structure
    echo "📁 Actual directory structure:"
    find "$README_DIR" -type f -name "*.md" | sort | head -20
    echo

    # Check for discrepancies
    echo "🔍 Checking for discrepancies..."

    # Extract file names from visual structure
    VISUAL_FILES=$(grep -o "├── [^#]*" "$README_FILE" | sed 's/├── //' | sed 's/ *$//' | grep -v "^$")
    VISUAL_FILES="$VISUAL_FILES $(grep -o "└── [^#]*" "$README_FILE" | sed 's/└── //' | sed 's/ *$//' | grep -v "^$")"

    # Get actual files
    ACTUAL_FILES=$(find "$README_DIR" -maxdepth 1 -type f -name "*.md" | xargs -n 1 basename)

    echo "Files in visual structure:"
    echo "$VISUAL_FILES" | tr ' ' '\n' | grep -v "^$"
    echo
    echo "Actual files:"
    echo "$ACTUAL_FILES"
    echo

    # Check for missing files in visual structure
    MISSING_IN_VISUAL=0
    for file in $ACTUAL_FILES; do
        if ! echo "$VISUAL_FILES" | grep -q "$file"; then
            echo -e "${RED}❌ Missing in visual: $file${NC}"
            ((MISSING_IN_VISUAL++))
        fi
    done

    # Check for extra files in visual structure
    EXTRA_IN_VISUAL=0
    for file in $VISUAL_FILES; do
        if [ -n "$file" ] && ! echo "$ACTUAL_FILES" | grep -q "$file"; then
            echo -e "${YELLOW}⚠️ Extra in visual: $file${NC}"
            ((EXTRA_IN_VISUAL++))
        fi
    done

    echo
    echo "=========================================="
    echo "  Validation Summary"
    echo "=========================================="
    echo "Missing in visual structure: $MISSING_IN_VISUAL"
    echo "Extra in visual structure: $EXTRA_IN_VISUAL"

    if [ $MISSING_IN_VISUAL -eq 0 ] && [ $EXTRA_IN_VISUAL -eq 0 ]; then
        echo -e "${GREEN}✅ Visual structure is accurate!${NC}"
        exit 0
    else
        echo -e "${YELLOW}⚠️ Visual structure needs updating${NC}"
        exit 1
    fi

else
    echo "Usage: $0 <readme-file-path>"
    echo "Example: $0 ./docs/README.md"
    echo
    echo "This script validates visual directory structures in README files"
    echo "against the actual directory structure."
    echo
    echo "To check all README files with visual structures:"
    echo "find . -name 'README.md' -exec $0 {} \\;"
fi
