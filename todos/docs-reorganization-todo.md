# Docs Directory Reorganization Todo

**Date:** 2025-07-27
**Status:** ✅ COMPLETE
**Priority:** HIGH
**Approach:** Option 1 - Comprehensive Reorganization

---

## 🎯 **Overview**

Reorganize the `docs/` directory following best practices for documentation organization. This will improve discoverability, maintainability, and create a professional structure.

---

## 📋 **Phase 1: Create New Directories**

### **New Directory Structure**
- [ ] Create `docs/style/` - Style guides and branding
- [ ] Create `docs/reports/` - Project reports and assessments
- [ ] Create `docs/workflows/` - Process documentation
- [ ] Create `docs/setup/hardware-specs/` - Hardware documentation

### **README Files**
- [ ] Create `docs/style/README.md`
- [ ] Create `docs/reports/README.md`
- [ ] Create `docs/workflows/README.md`
- [ ] Create `docs/setup/hardware-specs/README.md`

---

## 📋 **Phase 2: Move Files by Group**

### **Group 1: Style & Branding → `docs/style/`**
- [ ] Move `ascii-style-guide.md`
- [ ] Move `naming-guidelines.md`
- [ ] Move `unified-style-system.md`
- [ ] Move `style-system-implementation-summary.md`

### **Group 2: Hardware Documentation → `docs/setup/hardware-specs/`**
- [ ] Move `sap-mbp-hardware.md`
- [ ] Move `sap-mbp-systemsoftware.md`
- [ ] Move `MacBookPro-Retina-15-inch-Mid2015-Technical Specifications-AppleSupport.md`

### **Group 3: Project Reports → `docs/reports/`**
- [ ] Move `quality-control-report.md`
- [ ] Move `folder-structure-assessment.md`
- [ ] Move `folder-structure-improvements-summary.md`
- [ ] Move `root-directory-cleanup-report.md`
- [ ] Move `readme-optimization-summary.md`

### **Group 4: Workflow Documentation → `docs/workflows/`**
- [ ] Move `pdf-conversion-and-metrics-system.md`
- [ ] Move `pdf-incoming-workflow.md`
- [ ] Move `release-management-guide.md`

### **Group 5: System Optimization → Consolidate**
- [ ] Create `docs/guides/system-optimization.md` (combined guide)
- [ ] Merge content from `cursor-ide-disable-extensions.md`
- [ ] Merge content from `cursor_system_optimization_prompt.md`
- [ ] Merge content from `optimization-summary.md`
- [ ] Remove original files after merge

---

## 📋 **Phase 3: Cleanup**

### **Remove Backup Files**
- [ ] Remove `*.bak` files from docs root
- [ ] Remove `*.bak` files from subdirectories
- [ ] Verify no backup files remain

### **Update References**
- [ ] Update main `docs/README.md` with new structure
- [ ] Update any internal links in moved files
- [ ] Update any cross-references between files

---

## 📋 **Phase 4: Verification**

### **Structure Verification**
- [ ] Verify all files moved to correct locations
- [ ] Verify all README files created and populated
- [ ] Verify no broken links or references
- [ ] Verify backup files removed

### **Functionality Testing**
- [ ] Test all documentation links work
- [ ] Verify PDF conversion workflow still functions
- [ ] Test any scripts that reference docs files
- [ ] Verify development history remains intact

---

## 📋 **Phase 5: Documentation Updates**

### **Update Main README**
- [ ] Update `docs/README.md` with new structure
- [ ] Add navigation guide for new organization
- [ ] Update directory descriptions

### **Update Related Documentation**
- [ ] Update any scripts that reference docs files
- [ ] Update any external references
- [ ] Update project documentation if needed

---

## 🎯 **Expected Outcome**

### **New Structure**
```
docs/
├── README.md                                    # Main docs index
├── guides/                                      # Step-by-step tutorials
│   ├── README.md
│   ├── cursor-vscode-settings-sync.md
│   └── system-optimization.md                   # NEW: Combined guide
├── setup/                                       # Installation & configuration
│   ├── README.md
│   ├── github-setup.md
│   └── hardware-specs/                         # NEW: Hardware documentation
│       ├── README.md
│       ├── macbook-pro-2015-specs.md
│       ├── sap-mbp-hardware.md
│       └── sap-mbp-systemsoftware.md
├── style/                                       # NEW: Style and branding
│   ├── README.md
│   ├── ascii-style-guide.md
│   ├── naming-guidelines.md
│   ├── unified-style-system.md
│   └── style-system-implementation-summary.md
├── reports/                                     # NEW: Project reports
│   ├── README.md
│   ├── quality-control-report.md
│   ├── optimization-summary.md
│   ├── folder-structure-assessment.md
│   ├── folder-structure-improvements-summary.md
│   └── root-directory-cleanup-report.md
├── workflows/                                   # NEW: Process documentation
│   ├── README.md
│   ├── pdf-conversion-and-metrics-system.md
│   ├── pdf-incoming-workflow.md
│   └── release-management-guide.md
├── development-history/                         # EXISTING: Development tracking
│   ├── README.md
│   ├── chat-transcripts/
│   ├── decision-log/
│   └── project-evolution/
└── incoming/                                    # EXISTING: PDF drop zone
    ├── README.md
    └── [PDF files]
```

### **Benefits**
- ✅ **Improved discoverability** - Logical grouping
- ✅ **Better maintainability** - Related files together
- ✅ **Professional organization** - Industry standards
- ✅ **Reduced clutter** - Backup files removed
- ✅ **Scalable structure** - Ready for future growth

---

## 🚨 **Risk Mitigation**

### **Backup Strategy**
- [ ] Create backup of current docs structure before starting
- [ ] Commit current state to git before reorganization
- [ ] Test each phase before proceeding to next

### **Rollback Plan**
- [ ] Keep git history for easy rollback
- [ ] Document original file locations
- [ ] Test functionality after each phase

---

**Estimated Time:** 2-3 hours
**Priority:** HIGH
**Dependencies:** None
**Status:** ✅ COMPLETE
