#!/bin/bash

# ##############################################################################
# DgtlEnv Enhanced Prompt Router v2.0.0
#
# Advanced prompt routing with configuration support, logging, and extensible features
#
# Usage:
#   ./ops/run-prompt-enhanced.sh <prompt-alias>
#   ./ops/run-prompt-enhanced.sh --config <config-file>
#   ./ops/run-prompt-enhanced.sh --chain <prompt1> <prompt2>
#
# Example:
#   ./ops/run-prompt-enhanced.sh diagnose-ci
#   ./ops/run-prompt-enhanced.sh --chain diagnose-ci generate-report
# ##############################################################################

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="${PROJECT_ROOT}/config/prompt-router-config.json"
LOG_FILE="${PROJECT_ROOT}/logs/prompt-router.log"

# --- Load Configuration ---
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        PROMPTS_DIR=$(jq -r '.prompts_directory' "$CONFIG_FILE")
        OUTPUT_CLIPBOARD=$(jq -r '.output_methods.clipboard' "$CONFIG_FILE")
        OUTPUT_FILE=$(jq -r '.output_methods.file' "$CONFIG_FILE")
        OUTPUT_STDOUT=$(jq -r '.output_methods.stdout' "$CONFIG_FILE")
        LOGGING_ENABLED=$(jq -r '.logging.enabled' "$CONFIG_FILE")
        LOG_LEVEL=$(jq -r '.logging.level' "$CONFIG_FILE")
    else
        # Fallback defaults
        PROMPTS_DIR="prompts/categories"
        OUTPUT_CLIPBOARD=true
        OUTPUT_FILE=false
        OUTPUT_STDOUT=false
        LOGGING_ENABLED=true
        LOG_LEVEL="info"
    fi
}

# --- Logging Functions ---
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    if [[ "$LOGGING_ENABLED" == "true" ]]; then
        echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    fi

    if [[ "$level" == "error" ]] || [[ "$level" == "warn" ]] || [[ "$LOG_LEVEL" == "debug" ]]; then
        echo "$message" >&2
    fi
}

# --- Output Functions ---
output_prompt() {
    local content="$1"
    local prompt_name="$2"

    if [[ "$OUTPUT_CLIPBOARD" == "true" ]]; then
        echo "$content" | pbcopy
        log "info" "Prompt copied to clipboard: $prompt_name"
    fi

    if [[ "$OUTPUT_FILE" == "true" ]]; then
        local output_file="prompts/generated/${prompt_name}-$(date +%Y%m%d-%H%M%S).md"
        mkdir -p "$(dirname "$output_file")"
        echo "$content" > "$output_file"
        log "info" "Prompt saved to file: $output_file"
    fi

    if [[ "$OUTPUT_STDOUT" == "true" ]]; then
        echo "$content"
    fi
}

# --- Alias Resolution ---
resolve_alias() {
    local input="$1"

    if [[ -f "$CONFIG_FILE" ]]; then
        # Check configured aliases first
        local resolved=$(jq -r --arg input "$input" '.aliases | to_entries[] | select(.value[] | contains($input)) | .key' "$CONFIG_FILE" | head -1)
        if [[ -n "$resolved" ]]; then
            echo "$resolved"
            return 0
        fi
    fi

    # Fallback to fuzzy matching
    echo "$input"
}

# --- Variable Substitution ---
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

# --- Chain Processing ---
process_chain() {
    local prompts=("$@")
    local chain_result=""

    for prompt in "${prompts[@]}"; do
        log "info" "Processing chain prompt: $prompt"
        local result=$(process_single_prompt "$prompt" "chain")
        chain_result="${chain_result}${result}\n\n---\n\n"
    done

    echo "$chain_result"
}

# --- Single Prompt Processing ---
process_single_prompt() {
    local prompt_alias="$1"
    local mode="${2:-single}"

    log "info" "Processing prompt: $prompt_alias (mode: $mode)"

    # Resolve alias
    local resolved_alias=$(resolve_alias "$prompt_alias")
    log "debug" "Resolved alias: $prompt_alias -> $resolved_alias"

    # Normalize the alias
    local normalized_alias=$(echo "$resolved_alias" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

    # Find the latest prompt file
    local latest_prompt_file=$(find "$PROMPTS_DIR" -type f -name "${normalized_alias}-*.md" | sort -V | tail -n 1)

    if [[ -z "$latest_prompt_file" ]]; then
        log "debug" "No exact match found, trying fuzzy search for: $resolved_alias"

        # Fuzzy matching
        latest_prompt_file=$(find "$PROMPTS_DIR" -name "*.md" | grep -v README | while read -r file; do
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
        done | sort -V | tail -n 1)
    fi

    if [[ -z "$latest_prompt_file" ]]; then
        log "error" "No prompt files found for alias: $prompt_alias"
        return 1
    fi

    log "info" "Found prompt file: $latest_prompt_file"

    # Read and process the prompt
    local prompt_body=$(cat "$latest_prompt_file")

    # Handle includes
    while IFS= read -r line; do
        if [[ "$line" == *"{{include:"* ]]; then
            local file_to_include=$(echo "$line" | sed -n 's/.*{{include:\([^}]*\)}}.*/\1/p')

            if [[ -f "$file_to_include" ]]; then
                local included_content=$(cat "$file_to_include")
                prompt_body=$(echo "$prompt_body" | sed "s|{{include:${file_to_include}}}|${included_content}|")
                log "debug" "Injected context from: $file_to_include"
            else
                log "warn" "Could not find file to include: $file_to_include"
            fi
        fi
    done <<< "$prompt_body"

    # Substitute variables
    prompt_body=$(substitute_variables "$prompt_body")

    if [[ "$mode" == "single" ]]; then
        output_prompt "$prompt_body" "$(basename "$latest_prompt_file" .md)"
    else
        echo "$prompt_body"
    fi
}

# --- Main Function ---
main() {
    # Load configuration
    load_config

    # Create log directory
    mkdir -p "$(dirname "$LOG_FILE")"

    log "info" "Prompt Router started"

    # Handle special commands
    case "$1" in
        "--config")
            if [[ -n "$2" ]]; then
                CONFIG_FILE="$2"
                load_config
                log "info" "Using custom config: $CONFIG_FILE"
            fi
            shift 2
            ;;
        "--chain")
            shift
            if [[ $# -lt 2 ]]; then
                log "error" "Chain mode requires at least 2 prompts"
                exit 1
            fi
            local chain_result=$(process_chain "$@")
            output_prompt "$chain_result" "chain-result"
            exit 0
            ;;
        "--list")
            echo "📋 Available Prompts:"
            find "$PROMPTS_DIR" -name "*.md" | grep -v README | sort | while read -r file; do
                basename=$(basename "$file" .md)
                echo "  • $basename"
            done
            exit 0
            ;;
        "--search")
            local search_term="$2"
            if [[ -z "$search_term" ]]; then
                log "error" "No search term provided"
                exit 1
            fi
            echo "🔍 Searching for prompts containing: '$search_term'"
            find "$PROMPTS_DIR" -name "*.md" | grep -v README | grep -i "$search_term" | while read -r file; do
                basename=$(basename "$file" .md)
                echo "  • $basename"
            done
            exit 0
            ;;
        "--help"|"-h")
            echo "DgtlEnv Enhanced Prompt Router v2.0.0"
            echo ""
            echo "Usage:"
            echo "  $0 <prompt-alias>                    # Run single prompt"
            echo "  $0 --chain <prompt1> <prompt2>      # Chain multiple prompts"
            echo "  $0 --config <config-file>           # Use custom config"
            echo "  $0 --list                           # List all prompts"
            echo "  $0 --search <term>                  # Search prompts"
            echo "  $0 --help                           # Show this help"
            echo ""
            echo "Examples:"
            echo "  $0 diagnose-ci"
            echo "  $0 'diagnose ci'"
            echo "  $0 --chain diagnose-ci generate-report"
            exit 0
            ;;
    esac

    # Process single prompt
    if [[ -z "$1" ]]; then
        log "error" "No prompt alias provided"
        echo "❌ Error: No prompt alias provided."
        echo "Use '$0 --help' for usage information."
        exit 1
    fi

    if process_single_prompt "$1"; then
        log "info" "Prompt processing completed successfully"
        echo "🚀 Enhanced Prompt Router: Successfully processed '$1'"
        echo "📋 The final prompt has been copied to your clipboard."
    else
        log "error" "Prompt processing failed"
        exit 1
    fi
}

# --- Script Execution ---
main "$@"
