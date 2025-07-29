#!/bin/bash

# Cursor Prompt Router Wrapper
# This script can be bound to Cursor keyboard shortcuts for quick prompt access

# Get the prompt alias from command line argument
PROMPT_ALIAS=$1

if [[ -z "$PROMPT_ALIAS" ]]; then
    echo "Usage: $0 <prompt-alias>"
    echo "Example: $0 diagnose-ci"
    exit 1
fi

# Run the prompt router
./ops/run-prompt.sh "$PROMPT_ALIAS"

# Optional: Open the prompt in Cursor for editing
# cursor prompts/categories/system-optimization/diagnose-ci-failure-v1.0.0.md
