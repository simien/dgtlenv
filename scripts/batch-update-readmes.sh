#!/bin/bash

# Batch Update README Files Script
# Updates all invalid README files to meet new standards

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "=========================================="
echo "  DgtlEnv Batch README Update"
echo "=========================================="
echo

# Get list of README files that need updating
INVALID_READMES=()
while IFS= read -r -d '' file; do
    if [ -f "$file" ] && (! grep -q "## 📁 Contents" "$file" || ! grep -q "## 🚀 Quick Start" "$file"); then
        INVALID_READMES+=("$file")
    fi
done < <(find . -name "README.md" -not -path "./.git*" -print0)

if [ ${#INVALID_READMES[@]} -eq 0 ]; then
    echo -e "${GREEN}✅ All README files already meet standards!${NC}"
    exit 0
fi

echo "📝 Updating ${#INVALID_READMES[@]} README files to meet standards..."
echo

# Counter
UPDATED=0
TOTAL=${#INVALID_READMES[@]}

# Update each invalid README file
for file in "${INVALID_READMES[@]}"; do
    echo -e "${BLUE}Updating: $file${NC}"

    # Create backup
    cp "$file" "$file.backup"

    # Get directory path
    DIR_PATH=$(dirname "$file")

    # Get list of files and subdirectories
    FILES=$(find "$DIR_PATH" -maxdepth 1 -type f -name "*.md" -o -name "*.sh" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" | head -10)
    SUBDIRS=$(find "$DIR_PATH" -maxdepth 1 -type d | tail -n +2 | head -10)

    # Add required sections if missing
    if ! grep -q "## 📁 Contents" "$file"; then
        echo "" >> "$file"
        echo "## 📁 Contents" >> "$file"
        echo "" >> "$file"
        echo "### **Files**" >> "$file"

        if [ -n "$FILES" ]; then
            echo "$FILES" | while read -r f; do
                if [ -f "$f" ] && [ "$f" != "$file" ]; then
                    filename=$(basename "$f")
                    echo "- \`$filename\` - [Description of purpose]" >> "$file"
                fi
            done
        else
            echo "- No files found" >> "$file"
        fi

        echo "" >> "$file"
        echo "### **Subdirectories**" >> "$file"

        if [ -n "$SUBDIRS" ]; then
            echo "$SUBDIRS" | while read -r subdir; do
                if [ -d "$subdir" ]; then
                    subdir_name=$(basename "$subdir")
                    echo "- \`$subdir_name/\` - [Description of contents]" >> "$file"
                fi
            done
        else
            echo "- No subdirectories found" >> "$file"
        fi
    fi

    if ! grep -q "## 🚀 Quick Start" "$file"; then
        echo "" >> "$file"
        echo "## 🚀 Quick Start" >> "$file"
        echo "" >> "$file"
        echo "\`\`\`bash" >> "$file"
        echo "# Example commands for this directory" >> "$file"
        echo "# command1" >> "$file"
        echo "# command2" >> "$file"
        echo "\`\`\`" >> "$file"
    fi

    echo -e "${GREEN}✅ Updated $file${NC}"
    ((UPDATED++))
done

echo
echo "=========================================="
echo "  Update Summary"
echo "=========================================="
echo "Total Files: $TOTAL"
echo -e "Successfully Updated: ${GREEN}$UPDATED${NC}"
echo

if [ $UPDATED -eq $TOTAL ]; then
    echo -e "${GREEN}🎉 All README files updated successfully!${NC}"
    echo
    echo "📝 Next steps:"
    echo "1. Review and edit the updated README files"
    echo "2. Add specific descriptions and usage examples"
    echo "3. Run validation: ./scripts/validate-readme-files.sh"
else
    echo -e "${YELLOW}⚠️ Some files may need manual updates${NC}"
fi

echo
