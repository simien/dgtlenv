# scripts/

This directory contains utility scripts for project management, setup, maintenance, and organization standards enforcement.

## Scripts

### Pre-Release Sanitizer
- **`pre-release-sanitizer.sh`** - Comprehensive security and personal information sanitization before public releases

### GitHub Setup
- **`setup-github.sh`** - Automated GitHub repository setup and configuration

### Release Management
- **`create-release.sh`** - Automated release creation with version management and CI/CD integration

### Cursor Settings Sync
- **`sync-cursor-settings.sh`** - Synchronize Cursor IDE settings across environments

### Organization Standards Enforcement
- **`enforce-organization-standards.sh`** - Check and enforce directory organization standards and todo quality control with smart migration detection

### Todo Migration
- **`migrate-todo-items.sh`** - ✅ **FIXED** - Migrate non-completed todo items from completed files to appropriate active/planning todo files with comprehensive reporting

### ASCII Style Converter
- **`ascii-style-converter.sh`** - Convert and generate ASCII art and visual elements

### Project Name Management
- **`update-project-name.sh`** - Update project naming references and validate consistency

## Usage

### Pre-Release Sanitizer

The sanitizer automatically checks for and fixes personal information, credentials, and file permission issues before public releases.

```bash
# Check for issues without fixing (dry run)
./scripts/pre-release-sanitizer.sh --dry-run

# Check and automatically fix issues
./scripts/pre-release-sanitizer.sh --fix

# Show help
./scripts/pre-release-sanitizer.sh --help
```

**What it checks:**
- Personal information (usernames, email addresses, phone numbers)
- Credentials (API keys, passwords, tokens)
- File permissions (overly permissive files)
- Absolute paths with personal information

**What it fixes:**
- Replaces absolute paths with relative paths
- Sanitizes personal information in documentation
- Fixes file permissions for security
- Generates detailed reports

### GitHub Setup

```bash
# Setup GitHub repository with best practices
./scripts/setup-github.sh -r https://github.com/username/repository.git
```

### Release Management

```bash
# Create a new release
./scripts/create-release.sh 1.1.0 "Add new features"

# Show help
./scripts/create-release.sh

# The script will:
# - Validate version format
# - Run pre-release security checks
# - Update CHANGELOG.md
# - Create and push git tag
# - Trigger GitHub Actions release workflow
```

### Cursor Settings Sync

```bash
# Sync Cursor IDE settings
./scripts/sync-cursor-settings.sh
```

### Organization Standards Enforcement

Check and enforce directory organization standards across the project:

```bash
# Check for violations
./scripts/enforce-organization-standards.sh

# Attempt automatic fixes
./scripts/enforce-organization-standards.sh --fix

# The script checks for:
# - Backup files (.bak, .backup)
# - System files (.DS_Store)
# - Scattered files in root directories
# - Missing README files
# - Required directory structure
# - Todo quality control (completed todos must be fully checked)
# - Dynamic symbol usage with proper outcome communication

### Todo Migration

Migrates non-completed todo items from completed files to appropriate active/planning todo files:

```bash
# Test migration without making changes (dry run)
./scripts/migrate-todo-items.sh --dry-run

# Run actual migration
./scripts/migrate-todo-items.sh

# Run with detailed output
./scripts/migrate-todo-items.sh --verbose
```

**What it does:**
- Scans completed todo files for dynamic symbols
- Categorizes items based on content keywords
- Creates appropriate target todo files
- Migrates items to active/ or planning/ directories
- Updates README files with new counts
- Maintains timestamps and source references
- Adds migration notes to completed files for audit trail
- Generates comprehensive migration reports in `logs/` directory
- Provides real-time progress tracking
- Handles errors gracefully with clean execution
```

### ASCII Style Converter

Generate ASCII art and visual elements for documentation:

```bash
# Show examples
./scripts/ascii-style-converter.sh examples

# Generate styled logo
./scripts/ascii-style-converter.sh logo styled

# Create system dashboard
./scripts/ascii-style-converter.sh dashboard

# Create performance chart
./scripts/ascii-style-converter.sh chart
```

### Project Name Management

Update and validate project naming consistency:

```bash
# Show current configuration
./scripts/update-project-name.sh config

# Validate naming consistency
./scripts/update-project-name.sh validate

# Create naming guidelines
./scripts/update-project-name.sh guidelines
```

## Pre-Release Workflow

Before any public release, run the sanitizer:

```bash
# 1. Check for issues
./scripts/pre-release-sanitizer.sh --dry-run

# 2. Fix issues automatically
./scripts/pre-release-sanitizer.sh --fix

# 3. Verify fixes
./scripts/pre-release-sanitizer.sh --dry-run

# 4. Review generated report
cat logs/sanitization-report-*.md
```

## Organization Standards Workflow

Regular maintenance to ensure clean organization:

```bash
# 1. Check for violations
./scripts/enforce-organization-standards.sh

# 2. Fix violations automatically
./scripts/enforce-organization-standards.sh --fix

# 3. Verify clean state
./scripts/enforce-organization-standards.sh
```

## Security Features

- **Automated Detection:** Scans for common personal information patterns
- **Safe Fixes:** Uses dry-run mode to preview changes
- **Comprehensive Coverage:** Checks all file types and locations
- **Detailed Reporting:** Generates detailed sanitization reports

## Organization Features

- **Standards Enforcement:** Automated checking of directory organization
- **Clean Structure:** Ensures files are in appropriate directories
- **Backup Management:** Removes unnecessary backup files
- **README Validation:** Ensures all directories have proper documentation
- **Todo Quality Control:** Validates completed todos and dynamic symbol usage
- **Smart Migration Detection:** Recognizes already-migrated items vs items needing migration
- **Outcome Communication:** Ensures non-completed tasks have proper status communication

## Related Documentation

- See `../docs/workflows/cleanup-and-reorganization-standards.md` for detailed standards
- See `../docs/workflows/release-management-guide.md` for release process
- See `../docs/style/` for ASCII style system documentation

---

**Last Updated:** 2025-07-27 (Migration Script Fixed)
**Maintainer:** Simien Antonis-Parr
