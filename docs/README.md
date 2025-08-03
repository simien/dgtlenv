# docs/

This directory contains comprehensive documentation for the DgtlEnv project, organized by category for easy navigation and maintenance. Documentation focuses on **environment optimization** and **environment management** tools.

## 📁 Directory Structure

> **Sophisticated organization** - A refined structure for comprehensive documentation

```
docs/
├── README.md                                    # This file - main documentation index
├── development-history/                         # Development tracking and history
│   ├── README.md                               # Development history overview
│   ├── chat-transcripts/                       # Exported chat conversations
│   ├── decision-log/                           # Key decisions and rationale
│   └── project-evolution/                      # Project development timeline
├── guides/                                      # Step-by-step tutorials and guides
│   └── README.md                               # Guides overview
├── incoming/                                    # PDF drop zone and conversion
│   └── README.md                               # Incoming workflow
├── reports/                                     # Project reports and assessments
│   └── README.md                               # Reports overview
├── setup/                                       # Installation and configuration
│   ├── README.md                               # Setup overview
│   ├── github-setup.md                         # GitHub repository setup
│   └── hardware-specs/                         # Hardware specifications
│       └── README.md                           # Hardware overview
├── style/                                       # Style guides and branding
│   └── README.md                               # Style overview
└── workflows/                                   # Process documentation
    └── README.md                               # Workflows overview
```

## 📋 Documentation Categories

> **Refined categorization** - Sophisticated organization for optimal navigation

### 🎯 Guides (`guides/`)
> **Performance refinement** - Step-by-step tutorials and practical guides for environment optimization

- **Environment Optimization** - Comprehensive optimization strategies for your Mac
- **Cursor/VS Code Settings** - IDE configuration and sync
- **Development Workflows** - Best practices and procedures

### ⚙️ Setup (`setup/`)
> **Configuration management** - Installation, configuration, and hardware documentation for proper environment setup

- **GitHub Setup** - Repository configuration and management
- **Hardware Specifications** - System specs and capabilities
- **Installation Guides** - Setup procedures and requirements

### 🎨 Style (`style/`)
> **Visual sophistication** - Visual design, branding, and formatting standards for consistent project presentation

- **ASCII Style Guide** - Visual elements and art
- **Naming Guidelines** - File and directory conventions
- **Unified Style System** - Comprehensive design standards

### 📊 Reports (`reports/`)
> **Performance insights** - Project assessments, analysis, and performance tracking for informed decision-making

- **Structure Assessments** - Directory organization analysis
- **Optimization Reports** - Performance improvement tracking
- **Quality Control** - Standards and compliance reports

### 🔄 Workflows (`workflows/`)
> **Environment orchestration** - Process documentation and operational procedures for efficient environment management

- **PDF Management** - Conversion and processing workflows
- **Release Management** - Version control and distribution
- **Operational Procedures** - Day-to-day processes
- **Environment Management** - Organization standards and todo quality validation
- **Todo Migration** - Automated migration of non-completed todo items
- **Prompt Management** - Contextual prompt routing and quality control

### 📚 Development History (`development-history/`)
> **Knowledge preservation** - Project evolution and decision tracking for maintaining context and knowledge

- **Chat Transcripts** - Development conversations
- **Decision Log** - Key decisions and rationale
- **Project Evolution** - Development timeline and milestones

### 🧠 Contextual Systems (`prompt-system-overview.md`)
> **Sophisticated orchestration** - Advanced contextual prompt management and automation

- **Prompt System Overview** - Comprehensive prompt management documentation
- **Router Architecture** - Semantic prompt routing and discovery
- **Quality Control** - Validation and analytics systems

## 🚀 Quick Navigation

> **Contextual navigation** - Sophisticated pathways for different user types

### For New Users
1. **Start with** `guides/computer-optimization-quick-reference.md` for environment optimization
2. **Review** `setup/hardware-specs/` for system requirements
3. **Follow** `workflows/` for operational procedures

### For Developers
1. **Check** `style/` for coding standards
2. **Review** `reports/` for project status
3. **Reference** `development-history/` for context

### For Operations
1. **Use** `workflows/` for process procedures
2. **Monitor** `reports/` for performance metrics
3. **Follow** `guides/` for troubleshooting
4. **Leverage** prompt system for contextual automation

## 📋 Usage Examples

> **Practical orchestration** - Sophisticated workflows for common tasks

### PDF Conversion Workflow
> **Document orchestration** - Automated PDF processing and conversion workflow

```bash
# Add PDF to incoming directory
cp document.pdf docs/incoming/

# Convert to markdown
./ops/backup/simple-pdf-converter.sh convert docs/incoming/document.pdf

# Check conversion status
./ops/backup/simple-pdf-converter.sh dashboard
```

### System Optimization
> **Performance refinement** - Comprehensive system optimization and health monitoring

```bash
# Apply optimization settings
./scripts/sync-cursor-settings.sh

# Run health checks
./ops/monitoring/swap-ssd-health.sh

# Check system performance
./metrics/comprehensive-dashboard.sh status
```

### Documentation Updates
> **Knowledge management** - Automated documentation generation and maintenance

```bash
# Update optimization documentation
./metrics/system-metrics-tracker.sh compare

# Generate new documentation
./docs/setup/github-setup.md

# Review documentation structure
find docs/ -name "*.md" -type f
```

### Prompt System Management
> **Contextual orchestration** - Advanced prompt management and analytics

```bash
# Run prompt analytics
./scripts/prompt-analytics.sh

# Validate all prompts
./scripts/validate-prompts.sh

# Use prompt router
./ops/run-prompt.sh "diagnose ci"

# Enhanced router with logging
./ops/run-prompt-enhanced.sh diagnose-ci

# Version management tools
./scripts/check-outdated-prompts.sh --dry-run
./scripts/check-outdated-prompts.sh --archive
```

## 🔗 Integration

### Pre-Release Workflow
Documentation is automatically sanitized during pre-release to ensure quality and security:

```bash
# Sanitize documentation
./scripts/pre-release-sanitizer.sh --fix

# Verify sanitization
./scripts/pre-release-sanitizer.sh --dry-run

# Review changes
git diff docs/
```

### Security Considerations
- All documentation is sanitized before release
- Personal information is removed automatically
- Paths are converted to relative references
- Examples are made generic and reusable

## 📈 Maintenance

### Regular Tasks
- Update optimization documentation monthly
- Review PDF conversion documentation quarterly
- Sanitize documentation before releases
- Update setup guides as needed

### Documentation Standards
- Use clear, concise language
- Include practical examples
- Provide step-by-step instructions
- Include troubleshooting sections
- Follow markdown best practices

## 🔗 Related Files

### Configuration
- `config/cursor-settings.json` — Cursor IDE settings
- `ops/templates/` — Configuration templates

### Scripts
- `ops/backup/simple-pdf-converter.sh` — PDF conversion
- `scripts/pre-release-sanitizer.sh` — Documentation sanitization
- `scripts/sync-cursor-settings.sh` — Settings synchronization

### Metrics
- `metrics/pdf-processing-dashboard.md` — PDF conversion tracking
- `metrics/comprehensive-dashboard.sh` — System performance

---

**Last Updated:** 2025-07-27
**Maintainer:** Simien Antonis-Parr
**Status:** ✅ Reorganized and optimized

## 📁 Contents

### **Files**

### **Subdirectories**
- `development-history/` - [Description of contents]
- `setup/` - [Description of contents]
- `workflows/` - [Description of contents]
- `style/` - [Description of contents]
- `guides/` - [Description of contents]
- `incoming/` - [Description of contents]
- `reports/` - [Description of contents]

## 🚀 Quick Start

```bash
# Example commands for this directory
# command1
# command2
```
