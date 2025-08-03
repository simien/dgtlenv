#!/bin/bash

# Create Directory README Script
# Creates README files for directories missing them

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if directory path is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Please provide a directory path${NC}"
    echo "Usage: $0 <directory-path>"
    echo "Example: $0 ./logs"
    exit 1
fi

DIRECTORY="$1"

# Check if directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo -e "${RED}Error: Directory '$DIRECTORY' does not exist${NC}"
    exit 1
fi

# Check if README already exists
if [ -f "$DIRECTORY/README.md" ]; then
    echo -e "${YELLOW}Warning: README.md already exists in '$DIRECTORY'${NC}"
    echo "Do you want to overwrite it? (y/N): "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
fi

# Get directory name for title
DIR_NAME=$(basename "$DIRECTORY")
PARENT_DIR=$(dirname "$DIRECTORY")

# Get list of files and subdirectories
FILES=$(find "$DIRECTORY" -maxdepth 1 -type f -name "*.md" -o -name "*.sh" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" | head -10)
SUBDIRS=$(find "$DIRECTORY" -maxdepth 1 -type d | tail -n +2 | head -10)

# Create README content
cat > "$DIRECTORY/README.md" << EOF
# $DIR_NAME Overview

**Purpose:** [Brief description of directory purpose]
**Contents:** Main files and subdirectories in this directory
**Usage:** How to use files in this directory
**Related:** Links to related directories and documentation

## 📁 Contents

### **Files**
EOF

# Add files to README
if [ -n "$FILES" ]; then
    echo "$FILES" | while read -r file; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            echo "- \`$filename\` - [Description of purpose]" >> "$DIRECTORY/README.md"
        fi
    done
else
    echo "- No files found" >> "$DIRECTORY/README.md"
fi

cat >> "$DIRECTORY/README.md" << EOF

### **Subdirectories**
EOF

# Add subdirectories to README
if [ -n "$SUBDIRS" ]; then
    echo "$SUBDIRS" | while read -r subdir; do
        if [ -d "$subdir" ]; then
            subdir_name=$(basename "$subdir")
            echo "- \`$subdir_name/\` - [Description of contents]" >> "$DIRECTORY/README.md"
        fi
    done
else
    echo "- No subdirectories found" >> "$DIRECTORY/README.md"
fi

cat >> "$DIRECTORY/README.md" << EOF

## 🚀 Quick Start

\`\`\`bash
# Example commands for this directory
# command1
# command2
\`\`\`

## 🔗 Related Documentation

- \`../README.md\` - Parent directory documentation
- \`../../docs/guides/\` - Setup and usage guides

---

**Last Updated:** $(date +%Y-%m-%d)
**Maintainer:** [Name]
**Status:** 🔄 IN PROGRESS
EOF

echo -e "${GREEN}✅ Created README.md for '$DIRECTORY'${NC}"
echo -e "${BLUE}📝 Please edit the README.md file to add specific descriptions and usage examples${NC}"
echo -e "${YELLOW}💡 Remember to update the 'Purpose' and 'Related Documentation' sections${NC}"
