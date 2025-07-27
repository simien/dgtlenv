#!/bin/bash

# Enforce Organization Standards Script
# Checks for violations of our directory organization standards

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VIOLATIONS=0
WARNINGS=0

echo -e "${BLUE}🔍 DgtlEnv Organization Standards Check${NC}"
echo "=========================================="

# Function to check for violations
check_violation() {
    local pattern="$1"
    local description="$2"
    local severity="$3"

    if find "$PROJECT_ROOT" -name "$pattern" -type f | grep -q .; then
        echo -e "${RED}❌ VIOLATION: $description${NC}"
        find "$PROJECT_ROOT" -name "$pattern" -type f
        if [[ "$severity" == "error" ]]; then
            ((VIOLATIONS++))
        else
            ((WARNINGS++))
        fi
        echo
    else
        echo -e "${GREEN}✅ PASS: $description${NC}"
    fi
}

# Function to check directory structure
check_directory_structure() {
    local dir="$1"
    local description="$2"

    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✅ PASS: $description${NC}"
    else
        echo -e "${YELLOW}⚠️  WARNING: $description${NC}"
        ((WARNINGS++))
    fi
}

# Function to check README files
check_readme_files() {
    local dir="$1"
    local description="$2"

    if [[ -f "$dir/README.md" ]]; then
        echo -e "${GREEN}✅ PASS: $description${NC}"
    else
        echo -e "${RED}❌ VIOLATION: $description${NC}"
        ((VIOLATIONS++))
    fi
}

echo -e "\n${BLUE}📁 Checking for Prohibited Files${NC}"
echo "----------------------------------------"

# Check for backup files in docs
check_violation "*.bak" "Backup files in docs directory" "error"
check_violation "*.backup" "Backup files in docs directory" "error"

# Check for system files
check_violation ".DS_Store" "System files (.DS_Store)" "error"

# Check for temporary files
check_violation "*.tmp" "Temporary files" "warning"
check_violation "*.temp" "Temporary files" "warning"

echo -e "\n${BLUE}📋 Checking Directory Structure${NC}"
echo "----------------------------------------"

# Check required directories
check_directory_structure "$PROJECT_ROOT/docs/guides" "Guides directory exists"
check_directory_structure "$PROJECT_ROOT/docs/setup" "Setup directory exists"
check_directory_structure "$PROJECT_ROOT/docs/style" "Style directory exists"
check_directory_structure "$PROJECT_ROOT/docs/reports" "Reports directory exists"
check_directory_structure "$PROJECT_ROOT/docs/workflows" "Workflows directory exists"
check_directory_structure "$PROJECT_ROOT/docs/development-history" "Development history directory exists"
check_directory_structure "$PROJECT_ROOT/docs/incoming" "Incoming directory exists"

echo -e "\n${BLUE}📖 Checking README Files${NC}"
echo "----------------------------------------"

# Check README files in key directories
check_readme_files "$PROJECT_ROOT/docs" "Main docs README exists"
check_readme_files "$PROJECT_ROOT/docs/guides" "Guides README exists"
check_readme_files "$PROJECT_ROOT/docs/setup" "Setup README exists"
check_readme_files "$PROJECT_ROOT/docs/style" "Style README exists"
check_readme_files "$PROJECT_ROOT/docs/reports" "Reports README exists"
check_readme_files "$PROJECT_ROOT/docs/workflows" "Workflows README exists"
check_readme_files "$PROJECT_ROOT/docs/development-history" "Development history README exists"
check_readme_files "$PROJECT_ROOT/docs/incoming" "Incoming README exists"

echo -e "\n${BLUE}🔗 Checking for Scattered Files${NC}"
echo "----------------------------------------"

# Check for files that should be in subdirectories
if find "$PROJECT_ROOT/docs" -maxdepth 1 -name "*.md" | grep -v "README.md" | grep -q .; then
    echo -e "${RED}❌ VIOLATION: Files in docs root that should be in subdirectories${NC}"
    find "$PROJECT_ROOT/docs" -maxdepth 1 -name "*.md" | grep -v "README.md"
    ((VIOLATIONS++))
else
    echo -e "${GREEN}✅ PASS: No scattered files in docs root${NC}"
fi

echo -e "\n${BLUE}📊 Summary${NC}"
echo "----------------------------------------"

if [[ $VIOLATIONS -eq 0 && $WARNINGS -eq 0 ]]; then
    echo -e "${GREEN}🎉 EXCELLENT: All organization standards met!${NC}"
    exit 0
elif [[ $VIOLATIONS -eq 0 ]]; then
    echo -e "${YELLOW}⚠️  GOOD: $WARNINGS warnings found, no violations${NC}"
    exit 0
else
    echo -e "${RED}❌ FAILED: $VIOLATIONS violations and $WARNINGS warnings found${NC}"
    echo -e "${YELLOW}💡 Run './scripts/enforce-organization-standards.sh --fix' to attempt automatic fixes${NC}"
    exit 1
fi

# Fix mode
if [[ "$1" == "--fix" ]]; then
    echo -e "\n${BLUE}🔧 Attempting Automatic Fixes${NC}"
    echo "----------------------------------------"

    # Remove backup files
    echo "Removing backup files..."
    find "$PROJECT_ROOT" -name "*.bak" -delete
    find "$PROJECT_ROOT" -name "*.backup" -delete

    # Remove system files
    echo "Removing system files..."
    find "$PROJECT_ROOT" -name ".DS_Store" -delete

    # Remove temporary files
    echo "Removing temporary files..."
    find "$PROJECT_ROOT" -name "*.tmp" -delete
    find "$PROJECT_ROOT" -name "*.temp" -delete

    echo -e "${GREEN}✅ Automatic fixes completed${NC}"
    echo -e "${YELLOW}💡 Please review and manually organize any remaining scattered files${NC}"
fi
