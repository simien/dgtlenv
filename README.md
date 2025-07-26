# DigitalEnv - Digital Environment Management

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-12.7.6%20Monterey-blue.svg)](https://www.apple.com/macos/)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-brightgreen.svg)](https://github.com/simien/dgtlenv)

**Device:** MacBook Pro (Retina, 15-inch, Mid 2015)  
**OS:** macOS 12.7.6 Monterey  
**Status:** ✅ **OPTIMIZED & MONITORED**

---

## 🎯 Project Overview

DigitalEnv is a comprehensive digital environment management system that optimizes development workflows, monitors system performance, and provides automated tools for document management and metrics tracking.

### Key Features:
- ✅ **System Optimization:** Cursor IDE, Docker, and system performance tuning
- ✅ **PDF Management:** Automated PDF to markdown conversion with file watching
- ✅ **Metrics Tracking:** Visual dashboards showing before/after improvements
- ✅ **Health Monitoring:** Real-time system performance and health checks
- ✅ **Automated Maintenance:** Cleanup scripts and optimization tools

---

## 📊 Current System Status

### System Performance
- **Memory Usage:** 34% ✅ (Target: < 80%)
- **CPU Usage:** 14% ✅ (Target: < 70%)
- **Disk Usage:** 21% ✅ (Target: < 85%)
- **PDF Conversion:** 100% ✅ (3/3 files converted)

### Optimization Status
- ✅ Cursor IDE performance optimization
- ✅ System monitoring setup (Stats, htop)
- ✅ Docker/Colima resource management
- ✅ Automated cleanup scripts
- ✅ PDF to markdown conversion system
- ✅ Comprehensive metrics tracking

---

## 🛠️ Quick Start

### Essential Commands
```bash
# System health check
./ops/monitoring/swap-ssd-health.sh

# Convert all PDFs to markdown
./ops/backup/simple-pdf-converter.sh all

# Generate performance dashboard
./metrics/comprehensive-dashboard.sh dashboard

# Start PDF file watcher
./ops/backup/pdf-watcher.sh watch

# Track system improvements
./metrics/system-metrics-tracker.sh baseline
./metrics/system-metrics-tracker.sh current
./metrics/system-metrics-tracker.sh compare
```

### Real-time Status
```bash
./metrics/comprehensive-dashboard.sh status
```

---

## 📁 Project Structure

```
DigitalEnv/
├── docs/                           # Documentation
│   ├── converted/                  # Converted PDF files
│   ├── optimization-summary.md     # System optimization guide
│   └── pdf-conversion-and-metrics-system.md
├── metrics/                        # Performance tracking
│   ├── dashboards/                 # Visual dashboards
│   ├── system-metrics-tracker.sh   # Metrics collection
│   └── comprehensive-dashboard.sh  # Main dashboard
├── ops/                           # Operations scripts
│   ├── backup/                    # Backup and conversion
│   ├── cleanup/                   # System cleanup
│   ├── docker/                    # Docker optimization
│   └── monitoring/                # Health monitoring
└── todos/                         # Task management
```

---

## 📈 Visual Metrics Examples

### System Performance
```
Memory Usage: 34%
██████████░░░░░░░░░░░░░░░░░░░░
✅ Memory Status: 34%

CPU Usage: 14%
████░░░░░░░░░░░░░░░░░░░░░░░░░░
✅ CPU Status: 14%

Disk Usage: 21%
██████░░░░░░░░░░░░░░░░░░░░░░░░
✅ Disk Status: 21%
```

### PDF Conversion Progress
```
Conversion Rate: 100%
██████████████████████████████
```

---

## 🔄 Workflow Examples

### Complete Optimization Workflow
```bash
# 1. Capture baseline metrics
./metrics/system-metrics-tracker.sh baseline

# 2. Run optimizations
# ... optimization steps ...

# 3. Capture current metrics
./metrics/system-metrics-tracker.sh current

# 4. Generate comparison report
./metrics/system-metrics-tracker.sh compare

# 5. View comprehensive dashboard
./metrics/comprehensive-dashboard.sh dashboard
```

### PDF Management Workflow
```bash
# 1. Convert existing PDFs
./ops/backup/simple-pdf-converter.sh all

# 2. Start automatic watcher
./ops/backup/pdf-watcher.sh watch

# 3. Add new PDF to docs/ directory
# (Automatically converted)

# 4. Check conversion status
./ops/backup/simple-pdf-converter.sh dashboard
```

---

## 📋 Available Scripts

### System Monitoring
- **`./ops/monitoring/swap-ssd-health.sh`** - System health check
- **`./ops/monitoring/top-hogs.sh`** - Resource monitoring

### PDF Management
- **`./ops/backup/simple-pdf-converter.sh`** - PDF to markdown conversion
- **`./ops/backup/pdf-watcher.sh`** - Automatic file watching
- **`./ops/backup/create-digitalenv-backup.sh`** - Project backup

### Metrics Tracking
- **`./metrics/system-metrics-tracker.sh`** - Performance tracking
- **`./metrics/comprehensive-dashboard.sh`** - Visual dashboards

### System Optimization
- **`./ops/docker/docker-optimize.sh`** - Docker resource management
- **`./ops/cleanup/brew-cleanup.sh`** - Homebrew cleanup
- **`./ops/cleanup/docker-cleanup.sh`** - Docker cleanup

---

## 🎯 Performance Targets

### System Health
- **Memory Usage:** < 80% (Current: 34% ✅)
- **CPU Usage:** < 70% (Current: 14% ✅)
- **Disk Usage:** < 85% (Current: 21% ✅)
- **Swap Activity:** Minimal (Current: 0 ✅)

### PDF Conversion
- **Conversion Rate:** 100% (Current: 100% ✅)
- **Processing Time:** < 30 seconds per file
- **Error Rate:** < 5%

---

## 📊 Dashboard Locations

- **Comprehensive Dashboard:** `metrics/dashboards/comprehensive-dashboard.md`
- **PDF Processing Dashboard:** `metrics/pdf-processing-dashboard.md`
- **Before/After Comparison:** `metrics/dashboards/before-after-comparison.md`
- **Progress Chart:** `metrics/dashboards/progress-chart.md`

---

## 🔧 Troubleshooting

### Common Issues
```bash
# PDF conversion fails
brew install jq
./ops/backup/simple-pdf-converter.sh convert docs/file.pdf

# Metrics collection errors
sudo ./metrics/system-metrics-tracker.sh current

# Dashboard not updating
./metrics/comprehensive-dashboard.sh update
```

### Manual PDF Conversion
1. Open PDF in Preview
2. Select all text (Cmd+A)
3. Copy text (Cmd+C)
4. Paste into corresponding .md file
5. Format as markdown

---

## 📈 Improvement Tracking

The system provides comprehensive before/after comparison tracking:

### Before Optimization
- High memory usage and swap activity
- Unoptimized Cursor IDE settings
- No systematic resource monitoring
- Unmanaged Docker resource usage

### After Optimization
- ✅ Comprehensive system monitoring
- ✅ Optimized Cursor IDE performance
- ✅ Automated health checks
- ✅ Docker resource management
- ✅ SSD health monitoring
- ✅ PDF conversion automation

---

## ✅ System Status

**Overall Status:** ✅ **OPERATIONAL**  
**System Health:** ✅ **GOOD**  
**PDF Conversion:** ✅ **COMPLETE**  
**Metrics Tracking:** ✅ **ACTIVE**  

**Last Updated:** 2025-07-25 23:13:08  
**Next Maintenance:** Weekly system health check recommended

---

## 📚 Documentation

- **System Optimization:** `docs/optimization-summary.md`
- **PDF Conversion System:** `docs/pdf-conversion-and-metrics-system.md`
- **Cursor IDE Optimization:** `docs/cursor-ide-disable-extensions.md`
- **Contributing Guidelines:** `CONTRIBUTING.md`
- **Security Policy:** `security.md`
- **Changelog:** `CHANGELOG.md`
- **GitHub Setup Guide:** `github-setup.md`
- **Security Audit Report:** `security-audit-report.md`
- **Security Verification:** `security-verification-complete.md`

For detailed information about the PDF conversion and metrics tracking system, see: `docs/pdf-conversion-and-metrics-system.md`

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on how to:

- Report bugs and request features
- Submit pull requests
- Follow our coding standards
- Test your changes

## 🔒 Security

If you discover a security vulnerability, please report it privately. See our [Security Policy](SECURITY.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🏷️ Naming Conventions

This project follows consistent naming conventions for maintainability and clarity:

### 📁 Directories
- **kebab-case:** `docs/`, `metrics/`, `ops/`, `scripts/`, `todos/`
- **Descriptive names:** `system-metrics`, `pdf-converter`, `docker-optimize`

### 📄 Files
- **Documentation:** kebab-case (e.g., `github-setup.md`, `security-audit-report.md`)
- **Scripts:** kebab-case with `.sh` extension (e.g., `setup-github.sh`, `swap-ssd-health.sh`)
- **Configuration:** kebab-case with type suffix (e.g., `cursor-settings-performance.json`)
- **Standard files:** Conventional names (e.g., `README.md`, `LICENSE`, `CHANGELOG.md`)

### 🔧 Scripts
- **Monitoring scripts:** `*-health.sh`, `*-monitor.sh`
- **Cleanup scripts:** `*-cleanup.sh`
- **Optimization scripts:** `*-optimize.sh`
- **Conversion scripts:** `*-converter.sh`
- **Backup scripts:** `*-backup.sh`

### 📊 Variables and Functions
- **Shell variables:** UPPER_SNAKE_CASE (e.g., `SYSTEM_STATUS`, `PDF_COUNT`)
- **Shell functions:** snake_case (e.g., `check_system_health()`, `convert_pdf_to_markdown()`)
- **Configuration keys:** kebab-case (e.g., `system-status`, `pdf-count`)

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=simien/dgtlenv&type=Date)](https://star-history.com/#simien/dgtlenv&Date) 