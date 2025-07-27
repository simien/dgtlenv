# Cleanup & Reorganization Standards

**Date:** 2025-07-27
**Status:** ✅ ACTIVE STANDARDS
**Purpose:** Ensure consistent organization and cleanup processes

---

## 🎯 **Core Principles**

### **1. Directory Organization Standards**
- **No files in root directories** unless they are README files or essential configuration
- **Logical grouping** by content type and purpose
- **Consistent naming** conventions across all directories
- **README files** in every directory explaining purpose and contents

### **2. File Placement Rules**
- **Documentation files** → `docs/` with appropriate subdirectories
- **Reports and assessments** → `docs/reports/`
- **Process documentation** → `docs/workflows/`
- **Setup guides** → `docs/setup/`
- **Style guides** → `docs/style/`
- **Hardware specs** → `docs/setup/hardware-specs/`
- **Development history** → `docs/development-history/`

### **3. Cleanup Process Standards**
- **Backup files** → `config/backups/` or remove entirely
- **System files** (`.DS_Store`) → Remove completely
- **Temporary files** → Remove completely
- **Duplicate content** → Consolidate or remove

---

## 📋 **Process Checklist**

### **Before Starting Any Reorganization**
- [ ] **Create backup** of current state
- [ ] **Commit current state** to git
- [ ] **Document the plan** in a todo file
- [ ] **Review existing structure** to understand current organization
- [ ] **Identify target directories** for moved files

### **During Reorganization**
- [ ] **Create new directories** first
- [ ] **Add README files** to new directories
- [ ] **Move files by logical groups** (not one by one)
- [ ] **Test functionality** after each group
- [ ] **Update cross-references** and links
- [ ] **Remove backup files** and system files

### **After Reorganization**
- [ ] **Verify all functionality** works correctly
- [ ] **Update main README** files with new structure
- [ ] **Test all scripts** and workflows
- [ ] **Commit changes** with descriptive messages
- [ ] **Create summary report** in appropriate directory

---

## 📁 **Directory Structure Standards**

### **Required Directories**
```
docs/
├── README.md                                    # Main docs index
├── guides/                                      # Step-by-step tutorials
│   ├── README.md                               # Guides overview
│   └── [tutorial files]
├── setup/                                       # Installation & configuration
│   ├── README.md                               # Setup overview
│   ├── github-setup.md                         # GitHub setup
│   └── hardware-specs/                         # Hardware documentation
│       ├── README.md                           # Hardware overview
│       └── [hardware spec files]
├── style/                                       # Style guides and branding
│   ├── README.md                               # Style overview
│   └── [style guide files]
├── reports/                                     # Project reports and assessments
│   ├── README.md                               # Reports overview
│   └── [report files]
├── workflows/                                   # Process documentation
│   ├── README.md                               # Workflows overview
│   └── [workflow files]
├── development-history/                         # Development tracking
│   ├── README.md                               # Development history overview
│   ├── chat-transcripts/                       # Exported conversations
│   ├── decision-log/                           # Key decisions
│   └── project-evolution/                      # Development timeline
└── incoming/                                    # PDF drop zone
    ├── README.md                               # Incoming workflow
    └── [PDF files]
```

### **Prohibited in Root Directories**
- ❌ **Backup files** (`.bak`, `.backup`)
- ❌ **System files** (`.DS_Store`)
- ❌ **Temporary files**
- ❌ **Scattered documentation** (should be in appropriate subdirectories)
- ❌ **Process summaries** (should be in `docs/reports/`)

---

## 🔧 **Implementation Standards**

### **File Movement Process**
```bash
# 1. Create new directories
mkdir -p docs/new-category

# 2. Create README for new directory
touch docs/new-category/README.md

# 3. Move files by group
mv docs/file1.md docs/new-category/
mv docs/file2.md docs/new-category/

# 4. Remove backup files
find docs/ -name "*.bak" -delete

# 5. Test functionality
./scripts/test-workflow.sh

# 6. Commit changes
git add . && git commit -m "Reorganize docs: move files to new-category"
```

### **Summary Report Standards**
- **Location:** `docs/reports/[process-name]-summary.md`
- **Content:** Before/after comparison, changes made, verification results
- **Format:** Consistent with other report files
- **Status:** Include completion status and next steps

### **README File Standards**
- **Purpose:** Explain directory contents and usage
- **Structure:** Contents, purpose, usage, related documentation
- **Links:** Cross-references to related directories
- **Maintainer:** Include maintainer information

---

## 🚨 **Quality Control**

### **Pre-Reorganization Checks**
- [ ] **Backup current state** to git
- [ ] **Document the plan** in a todo file
- [ ] **Review existing structure** to avoid conflicts
- [ ] **Test current functionality** to establish baseline

### **During Reorganization Checks**
- [ ] **Test after each group** of file movements
- [ ] **Verify links work** after file moves
- [ ] **Check script functionality** that references moved files
- [ ] **Update cross-references** as you go

### **Post-Reorganization Checks**
- [ ] **Run all tests** to verify functionality
- [ ] **Check all links** in documentation
- [ ] **Verify scripts work** with new file locations
- [ ] **Update any hardcoded paths** in scripts

---

## 📊 **Success Metrics**

### **Organization Quality**
- ✅ **No files in root** except README and essential config
- ✅ **Logical grouping** by content type
- ✅ **Consistent naming** across directories
- ✅ **Comprehensive README files** in every directory

### **Functionality Verification**
- ✅ **All scripts work** with new file locations
- ✅ **All links work** in documentation
- ✅ **No broken references** or paths
- ✅ **Clean git status** with organized commits

### **Documentation Quality**
- ✅ **Clear navigation** through README files
- ✅ **Consistent formatting** across all files
- ✅ **Updated cross-references** and links
- ✅ **Comprehensive summaries** in reports directory

---

## 🔄 **Ongoing Maintenance**

### **Weekly Tasks**
- [ ] **Remove any new backup files** that appear
- [ ] **Clean up system files** (`.DS_Store`)
- [ ] **Verify new files** are in correct directories
- [ ] **Update README files** if new content is added

### **Monthly Tasks**
- [ ] **Review directory structure** for consistency
- [ ] **Check for scattered files** that need organization
- [ ] **Update this standards document** if needed
- [ ] **Verify all links** are still working

### **Pre-Release Tasks**
- [ ] **Run full cleanup check** using these standards
- [ ] **Verify organization** follows all guidelines
- [ ] **Update documentation** if structure changes
- [ ] **Test all functionality** with current organization

---

## 🎯 **Example: Correct Process**

### **Scenario:** Reorganizing documentation files

#### **1. Planning Phase**
```bash
# Create todo for the process
edit_file todos/docs-reorganization-todo.md
# Document the plan, phases, and expected outcomes
```

#### **2. Preparation Phase**
```bash
# Backup current state
git add . && git commit -m "Backup: Current state before reorganization"

# Create new directories
mkdir -p docs/new-category
touch docs/new-category/README.md
```

#### **3. Execution Phase**
```bash
# Move files by logical groups
mv docs/file1.md docs/new-category/
mv docs/file2.md docs/new-category/

# Remove backup files
find docs/ -name "*.bak" -delete

# Update README files
edit_file docs/new-category/README.md
```

#### **4. Verification Phase**
```bash
# Test functionality
./scripts/test-workflow.sh

# Verify links work
grep -r "file1.md" docs/ --include="*.md"
```

#### **5. Documentation Phase**
```bash
# Create summary in reports directory
edit_file docs/reports/reorganization-summary.md

# Update main README
edit_file docs/README.md

# Commit changes
git add . && git commit -m "Complete reorganization: move files to new-category"
```

---

## ✅ **Standards Compliance**

This document ensures that all future cleanup and reorganization processes:
- ✅ **Follow consistent patterns** and procedures
- ✅ **Maintain clean organization** in all directories
- ✅ **Preserve functionality** during reorganization
- ✅ **Create proper documentation** for all changes
- ✅ **Use appropriate file locations** for different content types

**Next Review:** Monthly standards review and update as needed

---

**Last Updated:** 2025-07-27
**Maintainer:** Simien Antonis-Parr
**Status:** ✅ ACTIVE STANDARDS
