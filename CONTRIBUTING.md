# Contributing to **DgtlEnv**

Thank you for your interest in contributing to DgtlEnv! This document provides guidelines and best practices for contributing to this digital environment management system.

## 🎯 Project Overview

DgtlEnv is a comprehensive digital environment management system designed for macOS development environments, specifically optimized for MacBook Pro (Retina, 15-inch, Mid 2015) running macOS 12.7.6 Monterey.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Directory Structure](#directory-structure)
- [Naming Conventions](#naming-conventions)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing Guidelines](#testing-guidelines)
- [Documentation Standards](#documentation-standards)
- [Performance Considerations](#performance-considerations)

## 🤝 Code of Conduct

### Our Standards

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

### Our Responsibilities

- Project maintainers are responsible for clarifying standards of acceptable behavior
- Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, and other contributions that are not aligned with this Code of Conduct

## 🚀 Getting Started

### Prerequisites

- macOS 12.7.6 Monterey or later
- Git 2.30.0 or later
- Shell access (zsh/bash)
- Basic understanding of shell scripting
- Docker Desktop (optional, for containerized operations)

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/DgtlEnv.git
cd DgtlEnv
   ```
3. Add the upstream repository:
   ```bash
   git remote add upstream https://github.com/simien/DgtlEnv.git
   ```

## 🛠️ Development Setup

### Environment Setup

1. **System Requirements Check:**
   ```bash
   ./ops/monitoring/swap-ssd-health.sh
   ```

2. **Install Dependencies:**
   ```bash
   # Install Homebrew if not already installed
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

   # Install required tools
   brew install jq htop stats
   ```

3. **Verify Setup:**
   ```bash
   ./metrics/comprehensive-dashboard.sh status
   ```

### Development Workflow

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes following the conventions below**

3. **Test your changes:**
   ```bash
   # Run system health check
   ./ops/monitoring/swap-ssd-health.sh

   # Generate metrics dashboard
   ./metrics/comprehensive-dashboard.sh dashboard
   ```

4. **Commit your changes using conventional commits**

5. **Push and create a pull request**

## 📁 Directory Structure

```
DgtlEnv/
├── docs/                           # Documentation
│   ├── converted/                  # Converted PDF files
│   │   └── README.md              # Conversion status and metadata
│   ├── optimization-summary.md     # System optimization guide
│   ├── pdf-conversion-and-metrics-system.md
│   └── README.md                  # Documentation index
├── logs/                          # Application logs
│   └── .gitkeep                   # Keep directory in git
├── metrics/                       # Performance tracking
│   ├── dashboards/                # Visual dashboards
│   │   └── README.md             # Dashboard documentation
│   ├── system-metrics-tracker.sh  # Metrics collection
│   ├── comprehensive-dashboard.sh # Main dashboard
│   └── README.md                 # Metrics documentation
├── ops/                          # Operations scripts
│   ├── backup/                   # Backup and conversion
│   │   ├── create-digitalenv-backup.sh
│   │   ├── pdf-to-markdown-converter.sh
│   │   ├── pdf-watcher.sh
│   │   ├── simple-pdf-converter.sh
│   │   └── README.md
│   ├── cleanup/                  # System cleanup
│   │   ├── brew-cleanup.sh
│   │   ├── docker-cleanup.sh
│   │   └── README.md
│   ├── docker/                   # Docker optimization
│   │   ├── docker-optimize.sh
│   │   └── README.md
│   ├── monitoring/               # Health monitoring
│   │   ├── swap-ssd-health.sh
│   │   ├── top-hogs.sh
│   │   └── README.md
│   ├── templates/                # Configuration templates
│   │   ├── cursor-settings-performance.json
│   │   ├── docker-compose-resource-limits-example.yml
│   │   ├── optimization-summary-template.md
│   │   └── README.md
│   └── README.md                 # Operations documentation
├── todos/                        # Task management
│   ├── optimization-todo.md
│   └── README.md
├── .gitignore                    # Git ignore rules
├── CONTRIBUTING.md               # This file
├── LICENSE                       # Project license
├── README.md                     # Project overview
└── SECURITY.md                   # Security policy
```

## 🏷️ Naming Conventions

### Files and Directories

- **Directories:** Use kebab-case (e.g., `system-metrics`, `pdf-converter`)
- **Scripts:** Use kebab-case with descriptive names (e.g., `swap-ssd-health.sh`, `pdf-to-markdown-converter.sh`)
- **Documentation:** Use kebab-case (e.g., `optimization-summary.md`, `pdf-conversion-and-metrics-system.md`)
- **Templates:** Use descriptive names with type suffix (e.g., `cursor-settings-performance.json`)

### Script Naming

- **Monitoring scripts:** `*-health.sh`, `*-monitor.sh`
- **Cleanup scripts:** `*-cleanup.sh`
- **Optimization scripts:** `*-optimize.sh`
- **Conversion scripts:** `*-converter.sh`
- **Backup scripts:** `*-backup.sh`

### Variables and Functions

- **Shell variables:** UPPER_SNAKE_CASE (e.g., `SYSTEM_STATUS`, `PDF_COUNT`)
- **Shell functions:** snake_case (e.g., `check_system_health()`, `convert_pdf_to_markdown()`)
- **Configuration keys:** kebab-case (e.g., `system-status`, `pdf-count`)

## 📝 Commit Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- **feat:** A new feature
- **fix:** A bug fix
- **docs:** Documentation only changes
- **style:** Changes that do not affect the meaning of the code
- **refactor:** A code change that neither fixes a bug nor adds a feature
- **perf:** A code change that improves performance
- **test:** Adding missing tests or correcting existing tests
- **chore:** Changes to the build process or auxiliary tools

### Examples

```bash
feat(monitoring): add swap usage monitoring to health check
fix(converter): resolve PDF conversion error for large files
docs(readme): update system requirements and setup instructions
perf(dashboard): optimize metrics collection for better performance
refactor(cleanup): restructure Docker cleanup script for better maintainability
```

### Commit Message Best Practices

1. **Use imperative mood:** "add" not "added" or "adds"
2. **Don't capitalize the first letter**
3. **No dot (.) at the end**
4. **Keep it under 50 characters for the subject line**
5. **Use the body to explain what and why vs. how**

## 🔄 Pull Request Process

### Before Submitting

1. **Ensure your code follows the project's style guidelines**
2. **Add tests for new functionality**
3. **Update documentation as needed**
4. **Run the full test suite**
5. **Check that your changes don't break existing functionality**

### Pull Request Template

```markdown
## Description
Brief description of the changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Ran system health check: `./ops/monitoring/swap-ssd-health.sh`
- [ ] Generated metrics dashboard: `./metrics/comprehensive-dashboard.sh dashboard`
- [ ] Tested on macOS 12.7.6 Monterey
- [ ] Verified no performance regression

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules

## Performance Impact
- [ ] No performance impact
- [ ] Performance improvement
- [ ] Performance regression (explain below)

## Additional Notes
Any additional information or context for the reviewers.
```

## 🧪 Testing Guidelines

### Manual Testing

1. **System Health Check:**
   ```bash
   ./ops/monitoring/swap-ssd-health.sh
   ```

2. **Performance Testing:**
   ```bash
   ./metrics/system-metrics-tracker.sh baseline
   # Run your changes
   ./metrics/system-metrics-tracker.sh current
   ./metrics/system-metrics-tracker.sh compare
   ```

3. **PDF Conversion Testing:**
   ```bash
   ./ops/backup/simple-pdf-converter.sh convert docs/test.pdf
   ```

4. **Pre-Release Security Testing:**
   ```bash
   ./scripts/pre-release-sanitizer.sh --dry-run
   ./scripts/pre-release-sanitizer.sh --fix
   ./scripts/pre-release-sanitizer.sh --dry-run
   ```

### Automated Testing

- All scripts should include error handling
- Scripts should validate inputs and provide meaningful error messages
- Performance-critical scripts should include timing measurements

### Test Coverage

- **Shell scripts:** Test with different input scenarios
- **Documentation:** Verify all links and code examples work
- **Performance:** Ensure no regression in system performance
- **Security:** Run pre-release sanitizer before commits
- **Personal Information:** Verify no personal data in releases

## 📚 Documentation Standards

### README Files

Every directory should have a `README.md` file that includes:

1. **Purpose:** What this directory contains and why
2. **Usage:** How to use the scripts/tools in this directory
3. **Examples:** Practical examples of common use cases
4. **Dependencies:** Any external dependencies or requirements
5. **Troubleshooting:** Common issues and solutions

### Code Documentation

- **Shell scripts:** Include header comments with purpose, usage, and examples
- **Functions:** Document parameters, return values, and side effects
- **Complex logic:** Add inline comments explaining the reasoning

### Example Script Header

```bash
#!/bin/bash
#
# Script Name: system-health-check.sh
# Description: Performs comprehensive system health check including memory, CPU, disk, and swap usage
# Author: Simien Antonis-Parr
# Date: 2025-07-28
# Version: 1.0.0
#
# Usage:
#   ./system-health-check.sh [options]
#
# Options:
#   -v, --verbose    Enable verbose output
#   -q, --quiet      Suppress all output except errors
#   -h, --help       Show this help message
#
# Examples:
#   ./system-health-check.sh
#   ./system-health-check.sh --verbose
#   ./system-health-check.sh --quiet
#
# Dependencies:
#   - jq (for JSON parsing)
#   - htop (for process monitoring)
#
# Exit Codes:
#   0 - Success
#   1 - System health issues detected
#   2 - Invalid arguments
#   3 - Missing dependencies
```

## ⚡ Performance Considerations

### Script Performance

- **Minimize external calls:** Batch operations where possible
- **Use efficient data structures:** Prefer arrays over repeated string operations
- **Implement caching:** Cache expensive operations when appropriate
- **Profile scripts:** Use `time` command to measure performance

### System Impact

- **Monitor resource usage:** Ensure scripts don't consume excessive CPU/memory
- **Implement timeouts:** Prevent scripts from running indefinitely
- **Use appropriate scheduling:** Run heavy operations during low-usage periods

### Optimization Guidelines

1. **Measure first:** Profile existing code before optimizing
2. **Optimize bottlenecks:** Focus on the slowest parts
3. **Test thoroughly:** Ensure optimizations don't introduce bugs
4. **Document changes:** Explain why optimizations were made

## 🔒 Security Guidelines

### Script Security

- **Validate inputs:** Always validate and sanitize user inputs
- **Use absolute paths:** Avoid relying on PATH for security-critical operations
- **Implement proper permissions:** Use appropriate file permissions
- **Avoid command injection:** Use parameterized commands

### Data Handling

- **Sensitive data:** Never commit sensitive information (API keys, passwords)
- **Logging:** Avoid logging sensitive information
- **File permissions:** Use appropriate file permissions for sensitive files

### Pre-Release Security

- **Run sanitizer:** Always run pre-release sanitizer before commits
- **Personal information:** Ensure no personal data in public releases
- **Security scanning:** Use automated security checks
- **Documentation review:** Verify all documentation is sanitized

## 🤝 Getting Help

### Communication Channels

- **Issues:** Use GitHub Issues for bug reports and feature requests
- **Discussions:** Use GitHub Discussions for questions and general discussion
- **Security:** Use GitHub Security Advisories for security issues

### Before Asking for Help

1. **Check existing documentation:** Review README files and documentation
2. **Search existing issues:** Look for similar problems or requests
3. **Reproduce the issue:** Ensure you can consistently reproduce the problem
4. **Provide context:** Include system information, error messages, and steps to reproduce

## 📄 License

By contributing to DgtlEnv, you agree that your contributions will be licensed under the same license as the project.

## 🙏 Acknowledgments

Thank you for contributing to DgtlEnv! Your contributions help make digital environment management more efficient and accessible for developers worldwide.

---

**Last Updated:** 2025-07-25
**Version:** 1.0.0
