# DgtlEnv Prompts

This directory contains structured prompts for the DgtlEnv project, organized by category and following established standards for consistency and maintainability.

## Overview

The prompts system provides standardized, reusable prompts for various project tasks and workflows. Each prompt follows the established template format and includes comprehensive documentation for effective use.

## Directory Structure

```
prompts/
├── README.md                           # This file
├── prompt-format-template-v1.0.0.md   # Standard template for creating prompts
└── categories/
    ├── system-optimization/            # System performance and optimization prompts
    ├── documentation-generation/        # Documentation and content creation prompts
    ├── workflow-management/            # Task management and workflow prompts
    ├── code-analysis/                  # Script execution and code analysis prompts
    └── meta-prompts/                   # Self-referential and utility prompts
```

## Prompt Categories

### System Optimization
Prompts focused on system performance, Docker optimization, IDE management, and resource utilization.

### Documentation Generation
Prompts for creating, updating, and maintaining project documentation with visual enhancements and comprehensive synchronization.

### Workflow Management
Prompts for todo list creation, quality control enforcement, and Git operations for effective project management.

### Code Analysis
Prompts for script execution, testing, and verification to ensure code quality and functionality.

### Meta-Prompts
Prompts for conversation summarization, development history export, and other utility functions.

## Usage Guidelines

1. **Template Compliance**: All prompts follow the `prompt-format-template-v1.0.0.md` structure
2. **Version Control**: Use semantic versioning for prompt updates
3. **Model Compatibility**: Include appropriate model compatibility lists
4. **Documentation**: Maintain clear instructions and expected outputs
5. **Standards**: Follow DgtlEnv naming conventions (kebab-case, ASCII style)

## 📊 Current System Analytics (July 28, 2025)

### Quality Control Results
- **Validation Status**: ✅ All prompts passed validation (24/24)
- **Template Compliance**: 100% ✅
- **Metadata Completeness**: 100% ✅
- **Version Consistency**: 100% ✅
- **File Naming Standards**: 100% ✅

### System Metrics
- **Total Prompts**: 24
- **Categories**: 5
- **Average Lines per Prompt**: 79
- **Total Lines**: 1,909
- **Success Rate**: 100%

### Category Distribution
```
code-analysis               5 (20%)
documentation-generation    5 (20%)
meta-prompts                3 (12%)
system-optimization         5 (20%)
workflow-management         6 (25%)
```

### Most Complex Prompts (by line count)
- `create-technical-tutorial-v1.0.0.md` - 82 lines
- `write-cleanup-script-v1.0.0.md` - 80 lines
- `update-documentation-ascii-visuals-v1.0.0.md` - 80 lines
- `refactor-code-v1.0.0.md` - 80 lines
- `persona-linux-terminal-v1.0.0.md` - 80 lines

### Quality Assurance
- **Validation Script**: `./scripts/validate-prompts.sh`
- **Analytics Script**: `./scripts/prompt-analytics.sh`
- **Enhanced Router**: `./ops/run-prompt-enhanced.sh`
- **Configuration**: `config/prompt-router-config.json`

## Prompt Format

Each prompt includes:
- Structured metadata with version and compatibility information
- System message defining the assistant's role and expertise
- Context engineering for project-specific information
- Clear instructions and input/output specifications
- Diagnostic framework for systematic problem-solving
- Integration standards and compliance requirements

## Contributing

When creating new prompts:
1. Use the template as a foundation
2. Follow established naming conventions
3. Include comprehensive documentation
4. Test with appropriate model compatibility
5. Update this README if adding new categories

## Standards Compliance

- **Naming**: kebab-case for all files and directories
- **Formatting**: ASCII style for consistency
- **Documentation**: Clear, actionable instructions
- **Integration**: Proper links to project components
- **Maintenance**: Regular updates and version control
