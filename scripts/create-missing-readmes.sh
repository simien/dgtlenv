#!/bin/bash

# Create Missing README Files Script
# Batch creates README files for all missing directories

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "=========================================="
echo "  DgtlEnv Missing README Creation"
echo "=========================================="
echo

# Get list of directories missing README files
MISSING_DIRS=$(find . -type d -not -path "./.git*" -not -path "./.cursor*" -not -path "./.vscode*" | while read dir; do if [ ! -f "$dir/README.md" ]; then echo "$dir"; fi; done)

if [ -z "$MISSING_DIRS" ]; then
    echo -e "${GREEN}✅ All directories already have README files!${NC}"
    exit 0
fi

echo "📝 Creating README files for missing directories..."
echo

# Counter
CREATED=0
TOTAL=$(echo "$MISSING_DIRS" | wc -l)

# Create README for each missing directory
while IFS= read -r dir; do
    if [ -n "$dir" ]; then
        echo -e "${BLUE}Creating README for: $dir${NC}"
        ./scripts/create-directory-readme.sh "$dir" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Created README.md for '$dir'${NC}"
            ((CREATED++))
        else
            echo -e "${RED}❌ Failed to create README.md for '$dir'${NC}"
        fi
    fi
done <<< "$MISSING_DIRS"

echo
echo "=========================================="
echo "  Creation Summary"
echo "=========================================="
echo "Total Missing: $TOTAL"
echo -e "Successfully Created: ${GREEN}$CREATED${NC}"
echo

if [ $CREATED -eq $TOTAL ]; then
    echo -e "${GREEN}🎉 All missing README files created successfully!${NC}"
    echo
    echo "📝 Next steps:"
    echo "1. Edit the created README files to add specific descriptions"
    echo "2. Update the 'Purpose' and 'Related Documentation' sections"
    echo "3. Run validation: ./scripts/validate-readme-files.sh"
else
    echo -e "${YELLOW}⚠️ Some README files may need manual creation${NC}"
fi

echo
