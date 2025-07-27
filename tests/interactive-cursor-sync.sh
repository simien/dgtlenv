#!/bin/bash

# Interactive Cursor IDE Sync Script
# Asks user if they want to sync VS Code settings to Cursor IDE

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  Cursor IDE Settings Sync"
echo "=========================================="
echo

# Check if Cursor is installed
if command -v cursor >/dev/null 2>&1 || [ -d "/Applications/Cursor.app" ]; then
    echo -e "${BLUE}[INFO]${NC} Cursor IDE detected"
    echo
    echo -e "${BLUE}[QUESTION]${NC} Do you want to sync VS Code settings to Cursor IDE?"
    echo "  This will apply project-specific optimizations to Cursor IDE"
    echo "  A backup of your current Cursor settings will be created"
    echo
    echo -e "${BLUE}[QUESTION]${NC} Continue? (y/N): "
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo
        echo -e "${BLUE}[INFO]${NC} Running Cursor IDE optimization..."
        if ./scripts/sync-cursor-settings.sh; then
            echo -e "${GREEN}[SUCCESS]${NC} Cursor IDE settings synchronized successfully!"
        else
            echo -e "${RED}[ERROR]${NC} Cursor IDE sync failed"
            exit 1
        fi
    else
        echo -e "${YELLOW}[SKIP]${NC} Cursor IDE sync cancelled by user"
    fi
else
    echo -e "${YELLOW}[SKIP]${NC} Cursor IDE not installed"
    echo "  Install Cursor IDE to use this feature"
fi

echo
echo "=========================================="
