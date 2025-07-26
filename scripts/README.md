# Scripts Directory

This directory contains utility scripts for managing and maintaining the DigitalEnv project.

## 📁 Directory Overview

The `scripts/` directory contains automation and utility scripts that help with:
- GitHub repository setup and management
- Project initialization and configuration
- Development workflow automation
- Maintenance and cleanup tasks

## 🛠️ Available Scripts

### GitHub Setup Script

**File:** `setup-github.sh`

**Description:** Initialize DigitalEnv GitHub repository with best practices including Git setup, remote configuration, branch protection, and GitHub Actions workflow setup.

**Usage:**
```bash
# Basic setup
./scripts/setup-github.sh -r https://github.com/simien/dgtlenv.git

# Setup with custom branch
./scripts/setup-github.sh -r https://github.com/simien/dgtlenv.git -b develop

# Force setup (overwrite existing configuration)
./scripts/setup-github.sh -r https://github.com/simien/dgtlenv.git -f

# Show help
./scripts/setup-github.sh -h
```

**Features:**
- ✅ Git repository initialization
- ✅ Remote repository setup
- ✅ Branch protection configuration
- ✅ GitHub Actions workflow setup
- ✅ Issue and PR templates
- ✅ Repository settings
- ✅ Comprehensive verification

**Requirements:**
- Git must be installed
- GitHub repository must exist
- User must have push access to the repository

**Exit Codes:**
- `0` - Success
- `1` - Invalid arguments
- `2` - Git not initialized
- `3` - Remote already exists
- `4` - Setup failed

## 🔧 Script Development Guidelines

### Script Structure

All scripts in this directory should follow this structure:

```bash
#!/bin/bash
#
# Script Name: script-name.sh
# Description: Brief description of what the script does
# Author: DigitalEnv Contributors
# Date: YYYY-MM-DD
# Version: X.Y.Z
#
# Usage:
#   ./script-name.sh [options]
#
# Options:
#   -o, --option    Option description
#   -h, --help      Show this help message
#
# Examples:
#   ./script-name.sh
#   ./script-name.sh --option value
#
# Dependencies:
#   - dependency1
#   - dependency2
#
# Exit Codes:
#   0 - Success
#   1 - Error
#   2 - Invalid arguments
```

### Best Practices

1. **Error Handling:**
   - Use `set -euo pipefail` for strict error handling
   - Implement proper error messages and exit codes
   - Use trap for cleanup on errors

2. **Input Validation:**
   - Validate all user inputs
   - Check for required dependencies
   - Verify file and directory existence

3. **Documentation:**
   - Include comprehensive help text
   - Document all options and examples
   - Explain exit codes and error conditions

4. **Security:**
   - Use parameterized commands
   - Validate file paths
   - Avoid command injection vulnerabilities

5. **Performance:**
   - Minimize external calls
   - Use efficient data structures
   - Implement appropriate timeouts

### Script Naming Conventions

- **Setup scripts:** `setup-*.sh`
- **Configuration scripts:** `config-*.sh`
- **Maintenance scripts:** `maintain-*.sh`
- **Utility scripts:** `util-*.sh`
- **Test scripts:** `test-*.sh`

### Testing Scripts

Before committing new scripts:

1. **Syntax Check:**
   ```bash
   bash -n script-name.sh
   ```

2. **ShellCheck:**
   ```bash
   shellcheck script-name.sh
   ```

3. **Manual Testing:**
   - Test with various input scenarios
   - Verify error handling
   - Check performance impact

## 📋 Script Categories

### Setup and Configuration
- `setup-github.sh` - GitHub repository initialization

### Maintenance and Cleanup
- (Future scripts for project maintenance)

### Development Workflow
- (Future scripts for development automation)

### Testing and Validation
- (Future scripts for testing and validation)

## 🔄 Integration with Main Project

Scripts in this directory integrate with the main DigitalEnv project:

- **GitHub Actions:** Scripts are tested in CI/CD workflows
- **Documentation:** Scripts are documented in main README
- **Dependencies:** Scripts use project-wide dependencies
- **Standards:** Scripts follow project coding standards

## 🚀 Adding New Scripts

To add a new script:

1. **Create the script file** with proper header documentation
2. **Add to this README** with usage examples
3. **Update main project README** if it's a user-facing script
4. **Add to CI/CD workflow** for testing
5. **Test thoroughly** before committing

### Template for New Scripts

```bash
#!/bin/bash
#
# Script Name: new-script.sh
# Description: Brief description of the script's purpose
# Author: DigitalEnv Contributors
# Date: $(date +%Y-%m-%d)
# Version: 1.0.0
#
# Usage:
#   ./scripts/new-script.sh [options]
#
# Options:
#   -o, --option    Option description
#   -h, --help      Show this help message
#
# Examples:
#   ./scripts/new-script.sh
#   ./scripts/new-script.sh --option value
#
# Dependencies:
#   - dependency1
#   - dependency2
#
# Exit Codes:
#   0 - Success
#   1 - Error
#   2 - Invalid arguments

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date +'%Y-%m-%d %H:%M:%S')] ${message}${NC}"
}

# Function to show help
show_help() {
    cat << EOF
Script Name: new-script.sh

Description: Brief description of what the script does

Usage: $0 [options]

Options:
    -o, --option VALUE    Option description
    -h, --help           Show this help message

Examples:
    $0
    $0 --option value

Requirements:
    - dependency1
    - dependency2
EOF
}

# Main function
main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -o|--option)
                OPTION="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                print_status "$RED" "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # Main script logic here
    print_status "$BLUE" "Starting script execution..."
    
    # Your script logic here
    
    print_status "$GREEN" "Script completed successfully!"
}

# Run main function
main "$@"
```

## 📚 Related Documentation

- **Main Project:** See root `README.md` for project overview
- **Contributing:** See `CONTRIBUTING.md` for contribution guidelines
- **Security:** See `SECURITY.md` for security policies
- **Changelog:** See `CHANGELOG.md` for version history

## 🤝 Contributing

When adding or modifying scripts:

1. Follow the established naming conventions
2. Include comprehensive documentation
3. Add proper error handling
4. Test thoroughly before committing
5. Update this README with new script information

## 📄 License

Scripts in this directory are part of the DigitalEnv project and are licensed under the MIT License.

---

**Last Updated:** 2025-07-25  
**Version:** 1.0.0 