#!/bin/bash

# ##############################################################################
# DgtlEnv Prompt Router v1.0.0
#
# Takes a prompt alias, finds the latest version of that prompt, injects
# context from specified files, and copies the final result to the clipboard.
#
# Usage:
#   ./ops/run-prompt.sh <prompt-alias>
#
# Example:
#   ./ops/run-prompt.sh diagnose-ci
# ##############################################################################

# --- Configuration ---
PROMPT_ALIAS=$1
PROMPTS_DIR="prompts/categories"

# --- Input Validation ---
if [[ -z "$PROMPT_ALIAS" ]]; then
  echo "❌ Error: No prompt alias provided."
  echo "Usage: $0 <prompt-alias>"
  echo ""
  echo "Available commands:"
  echo "  $0 --list          # List all available prompts"
  echo "  $0 --search <term> # Search prompts by term"
  exit 1
fi

# --- Handle Special Commands ---
if [[ "$PROMPT_ALIAS" == "--list" ]]; then
  echo "📋 Available Prompts:"
  find "$PROMPTS_DIR" -name "*.md" | grep -v README | sort | while read -r file; do
    basename=$(basename "$file" .md)
    echo "  • $basename"
  done
  exit 0
fi

if [[ "$PROMPT_ALIAS" == "--search" ]]; then
  SEARCH_TERM=$2
  if [[ -z "$SEARCH_TERM" ]]; then
    echo "❌ Error: No search term provided."
    echo "Usage: $0 --search <term>"
    exit 1
  fi
  echo "🔍 Searching for prompts containing: '$SEARCH_TERM'"
  find "$PROMPTS_DIR" -name "*.md" | grep -v README | grep -i "$SEARCH_TERM" | while read -r file; do
    basename=$(basename "$file" .md)
    echo "  • $basename"
  done
  exit 0
fi

# --- 1. Search and Route ---
echo "🔎 Searching for prompts matching alias: '$PROMPT_ALIAS'..."

# Normalize the alias: convert spaces to hyphens and lowercase
NORMALIZED_ALIAS=$(echo "$PROMPT_ALIAS" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

# Try exact match first
LATEST_PROMPT_FILE=$(find "$PROMPTS_DIR" -type f -name "${NORMALIZED_ALIAS}-*.md" | sort -V | tail -n 1)

# If no exact match, try fuzzy matching
if [[ -z "$LATEST_PROMPT_FILE" ]]; then
  echo "🔍 No exact match found, trying fuzzy search..."

  # Create a pattern that matches the alias with any separators
  FUZZY_PATTERN=$(echo "$PROMPT_ALIAS" | sed 's/[[:space:]]/.*/g' | sed 's/./[&]/g')

  # Find files that contain the alias words in any order
  LATEST_PROMPT_FILE=$(find "$PROMPTS_DIR" -name "*.md" | grep -v README | while read -r file; do
    basename=$(basename "$file" .md)
    # Check if all words in the alias are present in the filename
    MATCH=true
    for word in $PROMPT_ALIAS; do
      # Convert word to lowercase for comparison
      word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
      if [[ ! "$basename" =~ $word_lower ]]; then
        MATCH=false
        break
      fi
    done
    if [[ "$MATCH" == "true" ]]; then
      echo "$file"
    fi
  done | sort -V | tail -n 1)
fi

if [[ -z "$LATEST_PROMPT_FILE" ]]; then
  echo "❌ Error: No prompt files found for alias '$PROMPT_ALIAS'."
  echo ""
  echo "💡 Try these alternatives:"
  find "$PROMPTS_DIR" -name "*.md" | grep -v README | while read -r file; do
    basename=$(basename "$file" .md)
      # Show files that contain any of the words in the alias
  for word in $PROMPT_ALIAS; do
    # Convert word to lowercase for comparison
    word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
    if [[ "$basename" =~ $word_lower ]]; then
      echo "  • $basename"
      break
    fi
  done
  done
  exit 1
fi

echo "✅ Latest version found: $LATEST_PROMPT_FILE"

# --- 2. Perform Context Engineering ---
echo "⚙️  Processing context for the prompt..."
PROMPT_BODY=$(cat "$LATEST_PROMPT_FILE")

# Find all 'include' placeholders, e.g., {{include:path/to/file.log}}
# Using a while loop to handle multiple placeholders in the same file
while IFS= read -r line; do
  if [[ "$line" == *"{{include:"* ]]; then
    # Extract the file path from the placeholder
    FILE_TO_INCLUDE=$(echo "$line" | sed -n 's/.*{{include:\([^}]*\)}}.*/\1/p')

    if [[ -f "$FILE_TO_INCLUDE" ]]; then
      # Read the content of the file to be included
      INCLUDED_CONTENT=$(cat "$FILE_TO_INCLUDE")
      # Replace the placeholder with the actual file content
      PROMPT_BODY=$(echo "$PROMPT_BODY" | sed "s|{{include:${FILE_TO_INCLUDE}}}|${INCLUDED_CONTENT}|")
      echo "   → Injected context from: $FILE_TO_INCLUDE"
    else
      echo "   ⚠️  Warning: Could not find file to include: $FILE_TO_INCLUDE"
    fi
  fi
done <<< "$PROMPT_BODY"

# --- 3. Deliver Final Output ---
echo "$PROMPT_BODY" | pbcopy

echo "🚀 Prompt Router: Successfully prepared '$LATEST_PROMPT_FILE' with live context."
echo "📋 The final prompt has been copied to your clipboard."
echo ""
echo "💡 Tip: You can now paste the prompt directly into your AI assistant."
