# scripts/

This directory contains utility scripts for project management, setup, and maintenance.

## Scripts

### Pre-Release Sanitizer
- **`pre-release-sanitizer.sh`** - Comprehensive security and personal information sanitization before public releases

### GitHub Setup
- **`setup-github.sh`** - Automated GitHub repository setup and configuration

### Release Management
- **`create-release.sh`** - Automated release creation with version management and CI/CD integration

### Cursor Settings Sync
- **`sync-cursor-settings.sh`** - Synchronize Cursor IDE settings across environments

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

## Security Features

- **Automated Detection:** Scans for common personal information patterns
- **Safe Fixes:** Uses dry-run mode to preview changes
- **Comprehensive Reports:** Generates detailed sanitization reports
- **File Permissions:** Ensures proper file permissions for security
- **Credential Scanning:** Detects potential credential leaks

## Integration

The sanitizer can be integrated into CI/CD pipelines or run manually before releases. It's designed to be safe and non-destructive, with comprehensive reporting.

---

**Last Updated:** 2025-07-25
**Maintainer:** Simien Antonis-Parr
