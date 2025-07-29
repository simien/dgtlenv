# **DgtlEnv** - Digital Environment Optimization

> **Make your Mac run better** - A comprehensive macOS development environment optimization toolkit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-12.7.6%20Monterey-blue.svg)](https://www.apple.com/macos/)
[![System Status](https://img.shields.io/badge/System%20Status-Optimized-brightgreen.svg)](https://github.com/simien/DgtlEnv)
[![Memory Usage](https://img.shields.io/badge/Memory%20Usage-40%25-green.svg)](https://github.com/simien/DgtlEnv)
[![CPU Usage](https://img.shields.io/badge/CPU%20Usage-22%25-green.svg)](https://github.com/simien/DgtlEnv)

**Device:** MacBook Pro (Retina, 15-inch, Mid 2015)
**OS:** macOS 12.7.6 Monterey
**Status:** ✅ **OPTIMIZED & MONITORED**
**Last Updated:** July 27, 2025

---

## 🎯 What is DgtlEnv?

> **Digital Environment Optimization** - A refined toolkit that transforms your MacBook into a high-performance development machine

**DgtlEnv** is a **digital environment optimization toolkit** that transforms your MacBook into a high-performance development machine. Built as a shell script toolkit for maximum simplicity and extensibility.

### 🖥️ **Primary Focus: Environment Optimization**
> **Performance refinement** - Tools that directly improve your Mac's performance

- 🏥 **System Health Monitoring** - Prevents slowdowns and data loss
- 🧹 **System Cleanup** - Frees up disk space and memory
- 🐳 **Docker Optimization** - Prevents resource hogging
- 💻 **IDE Performance** - Optimizes Cursor IDE for faster development
- 📊 **Performance Tracking** - Shows real-time improvements

### 📁 **Secondary Focus: Environment Management**
> **Environment orchestration** - Tools that help manage the development environment

- 📄 **PDF Management** - Automated document conversion
- 🔒 **Security & Release** - Pre-release sanitization
- 📋 **Todo Management** - Quality control and organization
- 🧠 **Contextual Workflows** - Structured prompts for optimization and automation
- 🧪 **Comprehensive Testing** - Interactive and automated validation suite

---

## 🚀 Quick Start

### Installation
```bash
git clone https://github.com/simien/DgtlEnv.git
cd DgtlEnv
chmod +x ops/monitoring/swap-ssd-health.sh
./ops/monitoring/swap-ssd-health.sh
```

### 🖥️ Essential Environment Optimization Commands
> **Performance enhancement** - Start here to improve your Mac's performance

```bash
# 🏥 System Health Check (Prevents slowdowns & data loss)
./ops/monitoring/swap-ssd-health.sh

# 🧹 System Cleanup (Frees up disk space)
./ops/cleanup/brew-cleanup.sh
./ops/cleanup/docker-cleanup.sh

# 🐳 Docker Optimization (Prevents resource hogging)
./ops/docker/docker-optimize.sh

# 💻 Cursor IDE Optimization (Faster performance)
./scripts/sync-cursor-settings.sh

# 📊 Performance Tracking (Shows improvements)
./metrics/system-metrics-tracker.sh baseline
./metrics/system-metrics-tracker.sh current
./metrics/system-metrics-tracker.sh compare

# 📈 Real-time System Dashboard
./metrics/comprehensive-dashboard.sh dashboard
```

### 📁 Environment Management Commands
> **Environment orchestration** - For managing the development environment

```bash
# 📄 PDF Management
./ops/backup/simple-pdf-converter.sh all
./ops/backup/pdf-watcher.sh watch

# 🔒 Security & Release Management
./scripts/pre-release-sanitizer.sh --dry-run
./scripts/create-release.sh

# 📋 Todo Management & Quality Control
./scripts/enforce-organization-standards.sh
./scripts/migrate-todo-items.sh

# 🧪 Comprehensive Testing
./tests/quick-test.sh
./tests/quick-test.sh --non-interactive
```

---

## 📊 Current System Status

> **Performance metrics** - Real-time system optimization status

```
Memory Usage: 40% ✅ (Target: < 80%)
██████████░░░░░░░░░░░░░░░░░░░░
✅ Memory Status: Excellent

CPU Usage: 22% ✅ (Target: < 70%)
████████░░░░░░░░░░░░░░░░░░░░░░
✅ CPU Status: Optimal

Disk Usage: 21% ✅ (Target: < 85%)
██████░░░░░░░░░░░░░░░░░░░░░░░░
✅ Disk Status: Healthy
```

**📖 See [docs/guides/computer-optimization-quick-reference.md](docs/guides/computer-optimization-quick-reference.md) for detailed environment optimization guide**

---

## 📁 Project Structure

```
DgtlEnv/
├── 🖥️ ops/                        # 🎯 COMPUTER OPTIMIZATION (Main focus)
│   ├── monitoring/                # System health & performance monitoring
│   ├── cleanup/                   # System cleanup & maintenance
│   ├── docker/                    # Docker resource optimization
│   └── backup/                    # Backup and conversion tools
├── 📊 metrics/                    # Performance tracking & dashboards
│   ├── dashboards/                # Visual performance dashboards
│   ├── data/                      # Raw metrics storage
│   └── reports/                   # Generated performance reports
├── 📁 scripts/                    # 📋 PROJECT MANAGEMENT (Secondary)
│   ├── sync-cursor-settings.sh   # IDE optimization (computer tool)
│   └── [other project tools]     # Environment management tools
├── 📚 docs/                       # Documentation
├── 🔒 security/                   # Security policies
├── ⚙️ config/                     # Configuration files
├── 📋 todos/                      # Task management & quality control
└── 📝 logs/                       # Application logs
```

**🎯 Focus Areas:**
- **🖥️ Environment Optimization:** `ops/` and `metrics/` directories contain tools that directly improve your Mac's performance
- **📁 Environment Management:** `scripts/` directory contains tools that help manage the development environment

---

## 📋 Available Scripts

### 🖥️ Environment Optimization (System Performance)
**Tools that directly improve your Mac's performance:**

#### System Health & Monitoring
- **`./ops/monitoring/swap-ssd-health.sh`** - 🏥 System health check (Prevents slowdowns & data loss)
- **`./ops/monitoring/top-hogs.sh`** - 📊 Resource monitoring (Identifies performance bottlenecks)

#### System Cleanup & Maintenance
- **`./ops/cleanup/brew-cleanup.sh`** - 🧹 Homebrew cleanup (Frees up disk space)
- **`./ops/cleanup/docker-cleanup.sh`** - 🐳 Docker cleanup (Reduces memory & disk usage)

#### Docker Optimization
- **`./ops/docker/docker-optimize.sh`** - 🐳 Docker resource management (Prevents resource hogging)

#### IDE Performance
- **`./scripts/sync-cursor-settings.sh`** - 💻 Cursor IDE optimization (Faster performance, reduced memory usage)

#### Performance Tracking
- **`./metrics/system-metrics-tracker.sh`** - 📊 Performance tracking (Shows before/after improvements)
- **`./metrics/comprehensive-dashboard.sh`** - 📈 Visual dashboards (Real-time system status)

### 📁 Environment Management (Project Tools)
**Tools that help manage the development environment:**

#### PDF Management
- **`./ops/backup/simple-pdf-converter.sh`** - 📄 PDF to markdown conversion
- **`./ops/backup/pdf-watcher.sh`** - 👁️ Automatic file watching
- **`./ops/backup/create-digitalenv-backup.sh`** - 💾 Project backup

#### Security & Release Management
- **`./scripts/pre-release-sanitizer.sh`** - 🔒 Security sanitization
- **`./scripts/create-release.sh`** - 🚀 Release management
- **`./scripts/setup-github.sh`** - 📦 GitHub repository setup

#### Todo Management & Quality Control
- **`./scripts/migrate-todo-items.sh`** - ✅ **FIXED** - Automated todo migration with comprehensive reporting
- **`./scripts/enforce-organization-standards.sh`** - 📋 Organization standards enforcement

**📖 See [ops/README.md](ops/README.md) for detailed operations documentation**

---

## 🧠 Contextual Prompt Management System

> **Sophisticated prompt orchestration** - A refined system for contextual routing and quality control

### 🎯 Prompt Router Features
- **Natural Language Support** - Type `"diagnose ci"` instead of remembering exact filenames
- **Fuzzy Matching** - Contextual prompt discovery with semantic suggestions
- **Context Injection** - Dynamic file inclusion with `{{include:path/to/file}}`
- **Version Management** - Automatic latest version selection with semantic versioning
- **Quality Control** - Comprehensive validation and analytics
- **Automated Version Management** - Outdated version detection and archiving

### 📊 Current Prompt Analytics (July 28, 2025)
```
📊 Prompt Structure Analysis
==========================
Total prompts: 24 (active)
Archived prompts: 1 (properly managed)
Total categories: 5

Prompts by category:
  code-analysis               5 (20%)
  documentation-generation    5 (20%)
  meta-prompts                3 (12%)
  system-optimization         5 (20%)
  workflow-management         6 (25%)

📈 Quality Metrics
=================
Template Compliance: 100% ✅
Metadata Completeness: 100% ✅
Version Consistency: 100% ✅
File Naming Standards: 100% ✅
Validation Success Rate: 100% ✅
Outdated Version Management: 100% ✅

📦 Version Management
====================
Active prompts: 24 (clean, current versions only)
Archived prompts: 1 (outdated version)
Outdated versions: 0 (all handled)
Archive system: 100% operational
```

### 🚀 Quick Prompt Usage
```bash
# Basic prompt routing
./ops/run-prompt.sh "diagnose ci"
./ops/run-prompt.sh "find bugs"
./ops/run-prompt.sh "create todo"

# Enhanced router with logging
./ops/run-prompt-enhanced.sh diagnose-ci
./ops/run-prompt-enhanced.sh --chain diagnose-ci generate-report

# Version management tools
./scripts/check-outdated-prompts.sh --dry-run
./scripts/check-outdated-prompts.sh --archive

# Analytics and validation
./scripts/prompt-analytics.sh
./scripts/validate-prompts.sh
```

**📖 See [prompts/README.md](prompts/README.md) for detailed prompt system documentation**

**📚 See [docs/prompt-system-overview.md](docs/prompt-system-overview.md) for comprehensive system architecture and advanced features**

---

## 🔄 Complete Optimization Workflow

> **Sophisticated orchestration** - A refined workflow for comprehensive optimization

```bash
# 1. Capture baseline metrics
./metrics/system-metrics-tracker.sh baseline

# 2. Run optimizations
./ops/monitoring/swap-ssd-health.sh
./ops/cleanup/brew-cleanup.sh
./ops/cleanup/docker-cleanup.sh
./ops/docker/docker-optimize.sh
./scripts/sync-cursor-settings.sh

# 3. Capture current metrics
./metrics/system-metrics-tracker.sh current

# 4. Generate comparison report
./metrics/system-metrics-tracker.sh compare

# 5. View comprehensive dashboard
./metrics/comprehensive-dashboard.sh dashboard
```

**📖 See [docs/guides/computer-optimization-quick-reference.md](docs/guides/computer-optimization-quick-reference.md) for detailed environment optimization guide**

---

## 📚 Documentation

### 🖥️ Environment Optimization
- **[Environment Optimization Quick Reference](docs/guides/computer-optimization-quick-reference.md)** - Complete environment optimization guide with cards and workflows
- **[System Optimization Summary](docs/reports/readme-optimization-summary.md)** - Detailed optimization results and improvements
- **[Cursor IDE Optimization](ops/README.md#cursor-ide-performance-optimization-macos)** - IDE performance tuning guide

### 📁 Environment Management
- **[PDF Conversion System](docs/workflows/pdf-conversion-and-metrics-system.md)** - Document management workflow
- **[Todo Migration Workflow](docs/workflows/todo-migration-workflow.md)** - Quality control and organization
- **[Release Management Guide](docs/workflows/release-management-guide.md)** - Security and release processes

### 📊 Performance & Metrics
- **[Metrics & Monitoring](metrics/README.md)** - Performance tracking and dashboards
- **[Operations Documentation](ops/README.md)** - Environment optimization tools
- **[Scripts Documentation](scripts/README.md)** - Environment management tools
- **[Test Suite](tests/README.md)** - Comprehensive validation and testing with interactive and automated modes

### 🧠 Contextual Workflows
- **[Prompts System](prompts/README.md)** - Structured AI prompts for system optimization, documentation, and workflow management
- **[System Optimization Prompts](prompts/categories/system-optimization/)** - Performance tuning and resource management
- **[Documentation Generation](prompts/categories/documentation-generation/)** - Content creation and visual enhancements
- **[Workflow Management](prompts/categories/workflow-management/)** - Task organization and quality control
- **[Code Analysis](prompts/categories/code-analysis/)** - Script execution and verification
- **[Meta-Prompts](prompts/categories/meta-prompts/)** - Conversation management and utilities

### 🔧 Setup & Configuration
- **[GitHub Setup Guide](docs/setup/github-setup.md)** - Repository configuration
- **[Contributing Guidelines](CONTRIBUTING.md)** - Development standards
- **[Security Policies](security/README.md)** - Security and audit information

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 🔒 Security

If you discover a security vulnerability, please report it privately. See our [Security Policy](SECURITY.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Contact Information

**Name:** Simien Antonis-Parr
**Email:** simienap@gmail.com
**Website:** [simienap.com](https://www.simienap.com/)
**GitHub:** [simien](https://github.com/simien)
