#!/bin/bash

# ##############################################################################
# DgtlEnv Prompt Router v2.0.0
#
# Enhanced prompt routing with modular functions, dry-run mode, and improved
# error handling. Follows DgtlEnv standards for maintainability and robustness.
#
# Usage:
#   ./ops/run-prompt-v2.sh [-d|--dry-run] <prompt-alias>
#   ./ops/run-prompt-v2.sh --list
#   ./ops/run-prompt-v2.sh --search <term>
#
# Options:
#   -d, --dry-run   Print the final prompt to terminal instead of copying
#   --list          List all available prompts
#   --search <term> Search prompts by term
#
# Example:
#   ./ops/run-prompt-v2.sh diagnose-ci
#   ./ops/run-prompt-v2.sh --dry-run readme-shortening
# ##############################################################################

set -eo pipefail

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PROMPTS_DIR="${PROJECT_ROOT}/prompts/categories"
LOG_FILE="${PROJECT_ROOT}/logs/prompt-router.log"
CONFIG_FILE="${PROJECT_ROOT}/config/prompt-router-config.json"

# --- Global Variables ---
DRY_RUN=0
VERBOSE=0
PROMPT_ALIAS=""

# --- Logging Functions ---
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # Create log directory if it doesn't exist
    mkdir -p "$(dirname "$LOG_FILE")"

    # Write to log file
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"

    # Output to stderr for errors and warnings
    if [[ "$level" == "error" ]] || [[ "$level" == "warn" ]]; then
        echo "$message" >&2
    elif [[ "$VERBOSE" -eq 1 ]]; then
        echo "$message"
    fi
}

# --- Input Validation Functions ---
validate_input() {
    local alias="$1"

    if [[ -z "$alias" ]]; then
        log "error" "No prompt alias provided"
        return 1
    fi

    # Check for valid characters (alphanumeric, hyphens, spaces)
    if [[ ! "$alias" =~ ^[a-zA-Z0-9\ \-_]+$ ]]; then
        log "error" "Invalid characters in alias: $alias"
        return 1
    fi

    return 0
}

# --- Argument Parsing Functions ---
parse_arguments() {
    local args=("$@")

    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                DRY_RUN=1
                log "info" "Dry-run mode enabled"
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                log "info" "Verbose mode enabled"
                shift
                ;;
            --list)
                list_available_prompts
                exit 0
                ;;
            --search)
                if [[ -z "$2" ]]; then
                    log "error" "No search term provided for --search"
                    exit 1
                fi
                search_prompts "$2"
                exit 0
                ;;
            --chain)
                shift
                if [[ $# -lt 2 ]]; then
                    log "error" "Chain mode requires at least 2 prompts"
                    exit 1
                fi
                local chain_result
                chain_result=$(process_chain "$@")
                if [[ $? -eq 0 ]]; then
                    output_result "$chain_result" "chain-result"
                    log "info" "Chain processing completed successfully"
                else
                    log "error" "Chain processing failed"
                    exit 1
                fi
                exit 0
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            -*)
                log "error" "Unknown option: $1"
                show_help
                exit 1
                ;;
            *)
                PROMPT_ALIAS="$1"
                shift
                ;;
        esac
    done

    if [[ -z "$PROMPT_ALIAS" ]]; then
        log "error" "No prompt alias provided"
        show_help
        exit 1
    fi
}

# --- Prompt Discovery Functions ---
resolve_alias() {
    local input="$1"

    # Check if input is a configured alias
    if [[ -f "$CONFIG_FILE" ]]; then
        # Check if jq is available
        if command -v jq >/dev/null 2>&1; then
            local resolved
            resolved=$(jq -r --arg input "$input" '.aliases | to_entries[] | select(.key == $input) | .value[0]' "$CONFIG_FILE" 2>/dev/null)
            if [[ -n "$resolved" && "$resolved" != "null" ]]; then
                log "debug" "Resolved alias: $input -> $resolved"
                echo "$resolved"
                return 0
            fi
        else
            log "debug" "jq not available, skipping alias resolution"
        fi
    fi

    # Fallback to input as-is
    echo "$input"
}

find_latest_prompt() {
    local alias="$1"
    local search_dir="$2"

    log "info" "Searching for prompts matching alias: '$alias'"

    # Resolve alias first
    local resolved_alias
    resolved_alias=$(resolve_alias "$alias")
    log "debug" "Resolved alias: $alias -> $resolved_alias"

    # Normalize the alias
    local normalized_alias=$(echo "$resolved_alias" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

    # Try exact match first
    local matches
    matches=$(find "$search_dir" -type f -name "${normalized_alias}-*.md" 2>/dev/null)

    if [[ -z "$matches" ]]; then
        log "debug" "No exact match found, trying fuzzy search"

        # Fuzzy matching
        matches=$(find "$search_dir" -name "*.md" | grep -v README | while read -r file; do
            basename=$(basename "$file" .md)
            match=true
            for word in $resolved_alias; do
                word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
                if [[ ! "$basename" =~ $word_lower ]]; then
                    match=false
                    break
                fi
            done
            if [[ "$match" == "true" ]]; then
                echo "$file"
            fi
        done)
    fi

    if [[ -z "$matches" ]]; then
        log "error" "No prompt files found for alias '$alias'"
        suggest_alternatives "$alias" "$search_dir"
        return 1
    fi

    # Use 'sort -V' for natural version sorting and get the latest one
    local latest_file
    latest_file=$(echo "$matches" | sort -V | tail -n 1)

    log "info" "Latest version found: $latest_file"
    echo "$latest_file"
}

suggest_alternatives() {
    local alias="$1"
    local search_dir="$2"

    log "info" "Suggesting alternatives for: $alias"
    echo "💡 Try these alternatives:"

    find "$search_dir" -name "*.md" | grep -v README | while read -r file; do
        basename=$(basename "$file" .md)
        # Show files that contain any of the words in the alias
        for word in $alias; do
            word_lower=$(echo "$word" | tr '[:upper:]' '[:lower:]')
            if [[ "$basename" =~ $word_lower ]]; then
                echo "  • $basename"
                break
            fi
        done
    done
}

# --- Context Engineering Functions ---
inject_context() {
    local prompt_body="$1"

    log "info" "Processing context for the prompt"

    # Parse YAML frontmatter for RAG sources
    local rag_sources
    rag_sources=$(parse_rag_sources "$prompt_body")

    # Process {{include:path}} placeholders
    local final_body
    final_body=$(echo "$prompt_body" | awk '
    {
        while(match($0, /{{include:([^}]+)}}/)) {
            file=substr($0, RSTART+10, RLENGTH-11);
            if ((getline content < file) > 0) {
                gsub("{{include:" file "}}", content);
                print "   → Injected context from: " file > "/dev/stderr";
            } else {
                print "   ⚠️  Warning: Could not find file to include: " file > "/dev/stderr";
                gsub("{{include:" file "}}", "[CONTEXT NOT FOUND: " file "]");
            }
            close(file);
        }
        print;
    }
    ')

    # Inject RAG sources if available
    if [[ -n "$rag_sources" ]]; then
        final_body=$(inject_rag_sources "$final_body" "$rag_sources")
    fi

    # Substitute variables
    final_body=$(substitute_variables "$final_body")

    echo "$final_body"
}

# --- RAG Source Parsing Functions ---
parse_rag_sources() {
    local prompt_body="$1"

    # Extract YAML frontmatter
    local frontmatter
    frontmatter=$(echo "$prompt_body" | awk '
    /^---$/ { in_frontmatter = !in_frontmatter; next }
    in_frontmatter { print }
    /^---$/ { exit }
    ')

    # Parse rag_sources from frontmatter
    if [[ -n "$frontmatter" ]]; then
        echo "$frontmatter" | grep "rag_sources:" | sed 's/.*rag_sources:\s*\[\([^]]*\)\].*/\1/' | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
    fi
}

# --- RAG Source Injection Functions ---
inject_rag_sources() {
    local prompt_body="$1"
    local rag_sources="$2"

    log "info" "Injecting RAG sources: $rag_sources"

    # Create context section if it doesn't exist
    if ! echo "$prompt_body" | grep -q "## Context Engineering"; then
        prompt_body=$(echo "$prompt_body" | sed '/## Instructions/a\
\
## Context Engineering\
- **RAG Sources**: '"$rag_sources"'\
')
    else
        # Add RAG sources to existing context section
        prompt_body=$(echo "$prompt_body" | sed '/## Context Engineering/a\
- **RAG Sources**: '"$rag_sources"'\
')
    fi

    echo "$prompt_body"
}

# --- Variable Substitution Functions ---
substitute_variables() {
    local content="$1"

    # Date variables
    content=$(echo "$content" | sed "s/{{date}}/$(date +%Y-%m-%d)/g")
    content=$(echo "$content" | sed "s/{{time}}/$(date +%H:%M:%S)/g")
    content=$(echo "$content" | sed "s/{{timestamp}}/$(date +%Y%m%d-%H%M%S)/g")

    # Project variables
    content=$(echo "$content" | sed "s/{{project}}/DgtlEnv/g")
    content=$(echo "$content" | sed "s/{{user}}/$(whoami)/g")

    # Environment variables
    content=$(echo "$content" | sed "s|{{pwd}}|$(pwd)|g")

    echo "$content"
}

# --- Output Functions ---
output_result() {
    local content="$1"
    local prompt_name="$2"

    if [[ $DRY_RUN -eq 1 ]]; then
        echo "--- 📋 Dry Run: Final Prompt Output ---"
        echo "$content"
        echo "------------------------------------"
        echo "✨ Dry run complete. Nothing copied to clipboard."
        log "info" "Dry run completed for: $prompt_name"
    else
        echo "$content" | pbcopy
        echo "🚀 Prompt Router: Successfully prepared '$prompt_name'."
        echo "📋 The final prompt has been copied to your clipboard."
        log "info" "Prompt copied to clipboard: $prompt_name"
    fi
}

# --- Utility Functions ---
list_available_prompts() {
    echo "📋 Available Prompts:"
    find "$PROMPTS_DIR" -name "*.md" | grep -v README | sort | while read -r file; do
        basename=$(basename "$file" .md)
        echo "  • $basename"
    done
}

search_prompts() {
    local search_term="$1"
    echo "🔍 Searching for prompts containing: '$search_term'"
    find "$PROMPTS_DIR" -name "*.md" | grep -v README | grep -i "$search_term" | while read -r file; do
        basename=$(basename "$file" .md)
        echo "  • $basename"
    done
}

show_help() {
    echo "DgtlEnv Prompt Router v2.0.0"
    echo ""
    echo "Usage:"
    echo "  $0 [-d|--dry-run] <prompt-alias>"
    echo "  $0 --list"
    echo "  $0 --search <term>"
    echo "  $0 --chain <prompt1> <prompt2> [prompt3...]"
    echo "  $0 --help"
    echo ""
    echo "Options:"
    echo "  -d, --dry-run   Print the final prompt to terminal instead of copying"
    echo "  -v, --verbose   Enable verbose logging"
    echo "  --list          List all available prompts"
    echo "  --search <term> Search prompts by term"
    echo "  --chain <prompts> Execute multiple prompts in sequence"
    echo "  --help, -h      Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 diagnose-ci"
    echo "  $0 --dry-run readme-shortening"
    echo "  $0 --search docker"
    echo "  $0 --chain diagnose-ci git-commit-push"
}

# --- Main Processing Function ---
process_prompt() {
    local alias="$1"
    local mode="${2:-single}"

    log "info" "Processing prompt: $alias (mode: $mode)"

    # Validate input
    if ! validate_input "$alias"; then
        return 1
    fi

    # Find the latest prompt file
    local latest_prompt_file
    latest_prompt_file=$(find_latest_prompt "$alias" "$PROMPTS_DIR")
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    # Read the prompt content
    local prompt_body
    prompt_body=$(cat "$latest_prompt_file")

    # Inject context
    local final_prompt
    final_prompt=$(inject_context "$prompt_body")

    # Output the result based on mode
    if [[ "$mode" == "single" ]]; then
        local prompt_name
        prompt_name=$(basename "$latest_prompt_file" .md)
        output_result "$final_prompt" "$prompt_name"
    else
        echo "$final_prompt"
    fi

    return 0
}

# --- Chain Processing Function ---
process_chain() {
    local prompts=("$@")
    local chain_result=""

    log "info" "Processing prompt chain: ${prompts[*]}"

    for prompt in "${prompts[@]}"; do
        log "info" "Processing chain prompt: $prompt"
        local result
        result=$(process_prompt "$prompt" "chain")
        if [[ $? -eq 0 ]]; then
            chain_result="${chain_result}${result}\n\n---\n\n"
        else
            log "error" "Failed to process prompt in chain: $prompt"
            return 1
        fi
    done

    echo "$chain_result"
}

# --- Main Function ---
main() {
    # Parse arguments
    parse_arguments "$@"

    # Process the prompt
    if process_prompt "$PROMPT_ALIAS"; then
        log "info" "Prompt processing completed successfully"
    else
        log "error" "Prompt processing failed"
        exit 1
    fi
}

# --- Script Execution ---
main "$@"
