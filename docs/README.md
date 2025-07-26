# docs/

This directory contains comprehensive documentation for the DigitalEnv project, including optimization guides, PDF conversion documentation, and setup instructions.

## Structure
- `guides/` — Step-by-step guides and tutorials
- `incoming/` — PDF drop zone and conversion documentation
- `setup/` — Setup and configuration guides
- `optimization-summary.md` — System optimization documentation
- `pdf-conversion-and-metrics-system.md` — PDF conversion system guide
- `cursor-ide-disable-extensions.md` — Cursor IDE optimization guide

## Documentation Categories

### System Optimization
- **`optimization-summary.md`** — Comprehensive system optimization guide
- **`cursor-ide-disable-extensions.md`** — Cursor IDE performance optimization
- **`cursor_system_optimization_prompt.md`** — System optimization prompt template

### PDF Management
- **`pdf-conversion-and-metrics-system.md`** — PDF to markdown conversion system
- **`pdf-incoming-workflow.md`** — PDF processing workflow documentation
- **`incoming/`** — PDF drop zone and conversion status

### Setup and Configuration
- **`setup/github-setup.md`** — GitHub repository setup guide
- **`guides/`** — Step-by-step tutorials and guides

### Hardware Documentation
- **`sap-mbp-hardware.md`** — MacBook Pro hardware specifications
- **`sap-mbp-systemsoftware.md`** — System software documentation
- **`MacBookPro-Retina-15-inch-Mid2015-Technical Specifications-AppleSupport.md`** — Technical specifications

## Usage

### PDF Conversion Workflow
```bash
# Add PDF to incoming directory
cp document.pdf docs/incoming/

# Convert to markdown
./ops/backup/simple-pdf-converter.sh convert docs/incoming/document.pdf

# Check conversion status
./ops/backup/simple-pdf-converter.sh dashboard
```

### Documentation Updates
```bash
# Update optimization documentation
./metrics/system-metrics-tracker.sh compare

# Generate new documentation
./docs/setup/github-setup.md

# Review documentation structure
find docs/ -name "*.md" -type f
```

## Integration

### Pre-Release Workflow
Documentation is automatically sanitized during pre-release:
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

## Maintenance

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

## Related Files

### Configuration
- `config/cursor-settings.json` — Cursor IDE settings
- `ops/templates/` — Configuration templates

### Scripts
- `ops/backup/simple-pdf-converter.sh` — PDF conversion
- `scripts/pre-release-sanitizer.sh` — Documentation sanitization

### Metrics
- `metrics/pdf-processing-dashboard.md` — PDF conversion tracking
- `metrics/comprehensive-dashboard.sh` — System performance

---

**Last Updated:** 2025-07-25
**Maintainer:** DigitalEnv Contributors
