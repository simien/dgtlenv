#!/bin/bash

# Sync VS Code Project Settings with Cursor IDE
# This script copies project-specific VS Code settings to Cursor IDE
#
# 🎯 PERFORMANCE IMPACT:
# - Optimizes Cursor IDE for faster performance
# - Reduces memory usage through optimized settings
# - Improves file watching and TypeScript server performance
# - Disables unused extensions to save resources
# - BEFORE: Cursor IDE lag, high memory usage, slow file operations
# - AFTER: Optimized IDE performance, reduced memory usage, faster operations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CURSOR_SETTINGS="$HOME/Library/Application Support/Cursor/User/settings.json"
VSCODE_SETTINGS="$PROJECT_ROOT/.vscode/settings.json"

echo "=== Cursor IDE Settings Sync ==="
echo "Project: $PROJECT_ROOT"
echo "Cursor Settings: $CURSOR_SETTINGS"
echo "VS Code Settings: $VSCODE_SETTINGS"
echo

# Check if VS Code settings exist
if [[ ! -f "$VSCODE_SETTINGS" ]]; then
    echo "❌ VS Code settings not found: $VSCODE_SETTINGS"
    exit 1
fi

# Check if Cursor settings exist
if [[ ! -f "$CURSOR_SETTINGS" ]]; then
    echo "❌ Cursor settings not found: $CURSOR_SETTINGS"
    exit 1
fi

echo "📋 Current Cursor Settings:"
echo "------------------------"
cat "$CURSOR_SETTINGS" | jq '.' 2>/dev/null || cat "$CURSOR_SETTINGS"
echo

echo "📋 Project VS Code Settings:"
echo "---------------------------"
cat "$VSCODE_SETTINGS" | jq '.' 2>/dev/null || cat "$VSCODE_SETTINGS"
echo

# Create backup of current Cursor settings
BACKUP_FILE="$HOME/Library/Application Support/Cursor/User/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
cp "$CURSOR_SETTINGS" "$BACKUP_FILE"
echo "✅ Backup created: $BACKUP_FILE"

# Function to merge JSON settings
merge_settings() {
    local cursor_settings="$1"
    local vscode_settings="$2"
    local backup_file="$3"

    # Use jq to merge settings (project settings take precedence)
    if command -v jq &> /dev/null; then
        echo "🔄 Merging settings with jq..."
        # First, clean the cursor settings by removing comments
        sed '/^[[:space:]]*\/\//d' "$cursor_settings" | jq '.' > "$cursor_settings.clean"
        jq -s '.[0] * .[1]' "$cursor_settings.clean" "$vscode_settings" > "$cursor_settings.tmp"
        mv "$cursor_settings.tmp" "$cursor_settings"
        rm -f "$cursor_settings.clean"
    else
        echo "⚠️  jq not found, using manual merge..."
        # Manual merge approach
        python3 -c "
import json
import sys

try:
    with open('$cursor_settings', 'r') as f:
        cursor = json.load(f)
    with open('$vscode_settings', 'r') as f:
        vscode = json.load(f)

    # Merge settings (vscode settings override cursor settings)
    cursor.update(vscode)

    with open('$cursor_settings', 'w') as f:
        json.dump(cursor, f, indent=4)
    print('✅ Settings merged successfully')
except Exception as e:
    print(f'❌ Error merging settings: {e}')
    sys.exit(1)
"
    fi
}

# Ask user for confirmation
echo "🤔 Do you want to merge project VS Code settings with Cursor settings?"
echo "   This will apply project-specific optimizations to Cursor IDE"
echo "   Backup will be created automatically"
echo
read -p "Continue? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔄 Merging settings..."
    merge_settings "$CURSOR_SETTINGS" "$VSCODE_SETTINGS" "$BACKUP_FILE"

    echo "✅ Settings merged successfully!"
    echo
    echo "📋 Updated Cursor Settings:"
    echo "-------------------------"
    cat "$CURSOR_SETTINGS" | jq '.' 2>/dev/null || cat "$CURSOR_SETTINGS"
    echo
    echo "🔄 Please restart Cursor IDE to apply changes"
    echo "💡 You can restore from backup if needed: $BACKUP_FILE"
else
    echo "❌ Operation cancelled"
    rm -f "$BACKUP_FILE"
fi

echo
echo "=== Sync Complete ==="
