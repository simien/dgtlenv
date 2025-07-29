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

### **Todo Quality Control Standards**
- ✅ **Completed todos** must have ALL checkboxes marked `[x]`
- ✅ **Completed todos** must show "✅ COMPLETED" status
- ✅ **Completed todos** must include completion date
- ✅ **No completed todo** can have unchecked `[ ]` boxes
- ✅ **Dynamic symbols** with required outcome communication:
  - `[x]` - Completed
  - `[-]` - Future/Optional → Must append: `[-] Original task - Future/Optional: [reason or target todo]`
  - `[~]` - In Progress → Must append: `[~] Original task - In Progress: [current status]`
  - `[>]` - Deferred/Moved → Must append: `[>] Original task - Deferred to: [target todo file]` or `[>] Original task - Moved to: [target todo file]`
  - `[!]` - Blocked → Must append: `[!] Original task - Blocked: [reason or dependency]`
  - `[?]` - Cancelled → Must append: `[?] Original task - Cancelled: [reason]`

### **Todo Migration Workflow**
- ✅ **Future/Optional tasks** must be moved to `todos/planning/` or `todos/active/`
- ✅ **In Progress tasks** must be moved to `todos/active/`
- ✅ **Deferred tasks** must be moved to the specified target todo file
- ✅ **Blocked tasks** must be moved to `todos/active/` with blocker documentation
- ✅ **Cancelled tasks** can remain in completed with cancellation reason
- ✅ **Migration must include timestamps** and source file reference
- ✅ **Target todo files** must follow naming conventions: `[category]-[purpose]-todo.md`

### **Migration Process**
```bash
# Run migration script
./scripts/migrate-todo-items.sh

# Check what would be migrated
./scripts/migrate-todo-items.sh --dry-run

# Review migration results
cat logs/todo-migration-*.log

# Check organization standards (now with smart migration detection)
./scripts/enforce-organization-standards.sh
```

### **Migration Rules**
- **[-] Future/Optional** → Moved to `todos/planning/[category]-todo.md`
- **[~] In Progress** → Moved to `todos/active/[category]-todo.md`
- **[>] Deferred** → Moved to `todos/active/[category]-todo.md`
- **[!] Blocked** → Moved to `todos/active/[category]-todo.md`
- **[?] Cancelled** → Remains in completed with migration note

### **Smart Migration Detection**
The enforcement script now semantically detects migration status:
- **Items with migration notes** → Recognized as already migrated (PASS)
- **Items without migration notes** → Flagged for migration (WARNING)
- **Maintains audit trail** → Migration notes preserve historical context

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
- ✅ **Include todo metrics validation** in environment checks
- ✅ **Maintain ASCII progress charts** in todo documentation

## 🎯 **Issue Resolution Approach**

### **For All Infrastructure Improvements**
**Always start by creating a todo item for any infrastructure improvements, process enhancements, system organization, quality control issues, or documentation gaps.**

#### **The Correct Process:**
1. **Create a todo** - Document the issue in `todos/active/`
2. **Define the problem** - Clearly describe current state and issues
3. **Plan the solution** - Break down into phases with success criteria
4. **Follow project standards** - Integrate with existing validation frameworks
5. **Schedule implementation** - Allow proper resource allocation and prioritization

#### **Why This Approach:**
- ✅ **Maintains consistency** with existing workflow
- ✅ **Ensures proper documentation** and tracking
- ✅ **Enables structured planning** and quality control
- ✅ **Integrates with migration** and validation systems
- ✅ **Allows for proper resource management** and scheduling

#### **Examples of Issues That Require Todos:**
- Logging system organization
- Directory structure improvements
- Script path updates
- Documentation gaps
- Quality control enhancements
- Process workflow improvements
- Todo metrics dashboard updates
- ASCII progress chart maintenance

**Next Review:** Monthly standards review and update as needed

---

**Last Updated:** 2025-07-27
**Maintainer:** Simien Antonis-Parr
**Status:** ✅ ACTIVE STANDARDS
