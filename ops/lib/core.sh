#!/bin/bash

# ##############################################################################
# DgtlEnv Core Prompt Library
#
# Provides the core prompt processing logic, including discovery, context
# engineering, and variable substitution.
# ##############################################################################

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
    final_body=$(echo "$final_body" | substitute_variables)

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
    local content
    content=$(cat) # Read from stdin

    # Use a more robust Python script for substitutions to avoid complex sed commands
    local python_sub_script="${UTILS_DIR}/substitute_vars.py"
    if [[ -f "$python_sub_script" ]] && command -v python3 >/dev/null 2>&1; then
        echo "$content" | python3 "$python_sub_script"
        return
    fi

    log "warn" "Python substitution script not found or python3 not available. Falling back to basic sed."
    # Fallback to chained sed commands
    echo "$content" | sed "s/{{date}}/$(date +%Y-%m-%d)/g" \
                    | sed "s/{{time}}/$(date +%H:%M:%S)/g" \
                    | sed "s/{{timestamp}}/$(date +%Y%m%d-%H%M%S)/g" \
                    | sed "s/{{project}}/DgtlEnv/g" \
                    | sed "s/{{user}}/$(whoami)/g" \
                    | sed "s|{{pwd}}|$(pwd)|g"
}
