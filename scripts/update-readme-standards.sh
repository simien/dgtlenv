#!/bin/bash

# Update README Standards Script
# Helps update existing README files to meet new standards

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "=========================================="
echo "  DgtlEnv README Standards Update"
echo "=========================================="
echo

# Check if specific file is provided
if [ $# -eq 1 ]; then
    README_FILE="$1"
    if [ ! -f "$README_FILE" ]; then
        echo -e "${RED}Error: File '$README_FILE' does not exist${NC}"
        exit 1
    fi

    echo -e "${BLUE}Updating: $README_FILE${NC}"
    echo

    # Check if file has required sections
    if grep -q "## 📁 Contents" "$README_FILE" && grep -q "## 🚀 Quick Start" "$README_FILE"; then
        echo -e "${GREEN}✅ File already meets standards${NC}"
        exit 0
    fi

    # Create backup
    cp "$README_FILE" "$README_FILE.backup"

    # Get directory name and path
    DIR_PATH=$(dirname "$README_FILE")
    DIR_NAME=$(basename "$DIR_PATH")

    # Get list of files and subdirectories
    FILES=$(find "$DIR_PATH" -maxdepth 1 -type f -name "*.md" -o -name "*.sh" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" | head -10)
    SUBDIRS=$(find "$DIR_PATH" -maxdepth 1 -type d | tail -n +2 | head -10)

    # Add required sections if missing
    if ! grep -q "## 📁 Contents" "$README_FILE"; then
        echo "" >> "$README_FILE"
        echo "## 📁 Contents" >> "$README_FILE"
        echo "" >> "$README_FILE"
        echo "### **Files**" >> "$README_FILE"

        if [ -n "$FILES" ]; then
            echo "$FILES" | while read -r file; do
                if [ -f "$file" ] && [ "$file" != "$README_FILE" ]; then
                    filename=$(basename "$file")
                    echo "- \`$filename\` - [Description of purpose]" >> "$README_FILE"
                fi
            done
        else
            echo "- No files found" >> "$README_FILE"
        fi

        echo "" >> "$README_FILE"
        echo "### **Subdirectories**" >> "$README_FILE"

        if [ -n "$SUBDIRS" ]; then
            echo "$SUBDIRS" | while read -r subdir; do
                if [ -d "$subdir" ]; then
                    subdir_name=$(basename "$subdir")
                    echo "- \`$subdir_name/\` - [Description of contents]" >> "$README_FILE"
                fi
            done
        else
            echo "- No subdirectories found" >> "$README_FILE"
        fi
    fi

    if ! grep -q "## 🚀 Quick Start" "$README_FILE"; then
        echo "" >> "$README_FILE"
        echo "## 🚀 Quick Start" >> "$README_FILE"
        echo "" >> "$README_FILE"
        echo "\`\`\`bash" >> "$README_FILE"
        echo "# Example commands for this directory" >> "$README_FILE"
        echo "# command1" >> "$README_FILE"
        echo "# command2" >> "$README_FILE"
        echo "\`\`\`" >> "$README_FILE"
    fi

    echo -e "${GREEN}✅ Updated $README_FILE${NC}"
    echo -e "${YELLOW}💡 Please review and edit the added sections${NC}"

else
    echo "Usage: $0 <readme-file-path>"
    echo "Example: $0 ./README.md"
    echo
    echo "This script will add missing required sections to README files:"
    echo "- ## 📁 Contents (with files and subdirectories)"
    echo "- ## 🚀 Quick Start (with example commands)"
    echo
    echo "To update all invalid README files, run:"
    echo "./scripts/validate-readme-files.sh | grep 'missing required sections' | awk '{print \$2}' | xargs -I {} $0 {}"
fi
