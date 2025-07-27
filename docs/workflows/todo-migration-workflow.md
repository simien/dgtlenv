# Todo Migration Workflow - **DgtlEnv**

**Status:** ✅ Implemented
**Last Updated:** 2025-07-27
**Maintainer:** Simien Antonis-Parr

---

## 🎯 Overview

The Todo Migration Workflow ensures that non-completed todo items with dynamic symbols are properly moved from completed files to appropriate active or planning todo files, maintaining proper organization and traceability.

## 📋 Problem Statement

When todo items are marked with dynamic symbols ([-], [~], [>], [!], [?]) in completed files, they represent tasks that are not actually completed. These items need to be:

1. **Identified** in completed todo files
2. **Categorized** based on content and symbol type
3. **Migrated** to appropriate active or planning todo files
4. **Tracked** with timestamps and source references
5. **Organized** following naming conventions

## 🔧 Solution

### Automated Migration Script

The `scripts/migrate-todo-items.sh` script provides automated migration of non-completed todo items:

```bash
# Run migration
./scripts/migrate-todo-items.sh

# Dry run to see what would be migrated
./scripts/migrate-todo-items.sh --dry-run

# Verbose output for debugging
./scripts/migrate-todo-items.sh --verbose
```

### Migration Rules

| Dynamic Symbol | Status | Target Directory | Target File Pattern |
|----------------|--------|------------------|-------------------|
| `[-]` | Future/Optional | `todos/planning/` | `[category]-todo.md` |
| `[~]` | In Progress | `todos/active/` | `[category]-todo.md` |
| `[>]` | Deferred | `todos/active/` | `[category]-todo.md` |
| `[!]` | Blocked | `todos/active/` | `[category]-todo.md` |
| `[?]` | Cancelled | `todos/completed/` | Remains with migration note |

### Content Categorization

The script automatically categorizes items based on keywords:

| Category | Keywords | Example Files |
|----------|----------|---------------|
| `documentation` | documentation, README, guide | `documentation-todo.md` |
| `security` | security, audit, vulnerability | `security-todo.md` |
| `funding` | funding, sponsor, donation | `funding-todo.md` |
| `release` | release, version, deploy | `release-todo.md` |
| `optimization` | optimization, performance, monitoring | `optimization-todo.md` |
| `github` | github, repository, setup | `github-todo.md` |
| `feature` | feature, enhancement, improvement | `feature-todo.md` |
| `testing` | testing, test, validation | `testing-todo.md` |
| `community` | community, contributor, social | `community-todo.md` |
| `general` | default for unmatched content | `general-todo.md` |

## 🚀 Workflow Process

### Step 1: Identify Items for Migration

The script scans all completed todo files for dynamic symbols:

```bash
# Find files with dynamic symbols
grep -r "\[[-~>!?]\]" todos/completed/
```

### Step 2: Categorize and Target

For each item found:

1. **Extract** the original task description
2. **Determine** category based on content keywords
3. **Select** target directory based on symbol type
4. **Create** or update target todo file

### Step 3: Migrate Items

```bash
# Example migration
Original: [-] Add advanced feature - Future/Optional: Will be implemented in v2.0
Target: todos/planning/feature-todo.md
Result: [-] Add advanced feature - Future/Optional: Migrated from typography-rhythm-todo.md - 2025-07-27 14:30:00
```

### Step 4: Update Source Files

Source files are updated with migration notes:

```markdown
# Before migration
- [-] Add advanced feature - Future/Optional: Will be implemented in v2.0

# After migration
- [-] Add advanced feature - Future/Optional: Will be implemented in v2.0 (MIGRATED: 2025-07-27 14:30:00)
```

### Step 5: Update Documentation

README files are automatically updated with new counts:

```bash
# Update active README
sed -i "s/Currently Active Tasks (4)/Currently Active Tasks ($new_count)/" todos/active/README.md

# Update planning README
sed -i "s/Planning and Strategy Tasks (2)/Planning and Strategy Tasks ($new_count)/" todos/planning/README.md
```

## 📊 Migration Examples

### Example 1: Documentation Task

**Source:** `todos/completed/typography-rhythm-todo.md`
```markdown
- [-] Update documentation - Future/Optional: Will be addressed in future documentation updates
```

**Target:** `todos/planning/documentation-todo.md`
```markdown
# Documentation Todo - **DgtlEnv**

**Created:** 2025-07-27 14:30:00
**Source:** Migrated from typography-rhythm-todo.md
**Status:** 🔄 IN PROGRESS

---

## 📋 Documentation Tasks

### Migrated Items
*Items migrated from completed todos with dynamic symbols*

- [-] Update documentation - Future/Optional: Migrated from typography-rhythm-todo.md - 2025-07-27 14:30:00
```

### Example 2: Security Task

**Source:** `todos/completed/pre-release-workflow-todo.md`
```markdown
- [!] Advanced pattern matching - Blocked: Waiting for security review
```

**Target:** `todos/active/security-todo.md`
```markdown
# Security Todo - **DgtlEnv**

**Created:** 2025-07-27 14:30:00
**Source:** Migrated from pre-release-workflow-todo.md
**Status:** 🔄 IN PROGRESS

---

## 📋 Security Tasks

### Migrated Items
*Items migrated from completed todos with dynamic symbols*

- [!] Advanced pattern matching - Blocked: Migrated from pre-release-workflow-todo.md - 2025-07-27 14:30:00
```

## 🔍 Quality Control

### Pre-Migration Checks

The enforcement script checks for items that should be migrated:

```bash
# Check for dynamic symbols in completed files
# Enhanced with smart migration detection
```
./scripts/enforce-organization-standards.sh
```

### Post-Migration Validation

After migration, verify:

1. **Items moved** to appropriate directories
2. **Source files** updated with migration notes
3. **README files** updated with new counts
4. **Log files** created for audit trail

## 📈 Benefits

### Organization
- **Clean completed files** - Only truly completed items remain
- **Proper categorization** - Items organized by content and status
- **Clear traceability** - Source and timestamp tracking

### Workflow Integration
- **Automated process** - No manual file moving required
- **Consistent naming** - Follows established conventions
- **Documentation updates** - README files automatically updated

### Quality Assurance
- **Validation checks** - Enforcement script identifies migration needs
- **Audit trail** - Log files track all migrations
- **Source tracking** - Original file references maintained
- **Smart detection** - Enhanced enforcement script recognizes already-migrated items

## 🛠️ Usage

### Regular Maintenance

Run migration as part of regular maintenance:

```bash
# Weekly todo review
./scripts/migrate-todo-items.sh

# Check for items needing migration
./scripts/enforce-organization-standards.sh
```

### Pre-Release Workflow

Include migration in pre-release checks:

```bash
# Pre-release workflow
./scripts/pre-release-sanitizer.sh --fix
./scripts/enforce-organization-standards.sh
./scripts/migrate-todo-items.sh
./scripts/enforce-organization-standards.sh  # Verify cleanup
```

### Troubleshooting

If migration issues occur:

```bash
# Check migration log
cat logs/todo-migration-*.log

# Dry run to see what would happen
./scripts/migrate-todo-items.sh --dry-run

# Verbose output for debugging
./scripts/migrate-todo-items.sh --verbose
```

## 📋 Best Practices

### Before Migration
1. **Review** completed files for dynamic symbols
2. **Validate** that items are truly non-completed
3. **Check** target directories exist
4. **Backup** important files

### During Migration
1. **Use dry run** first to preview changes
2. **Review** categorization accuracy
3. **Verify** target file creation
4. **Check** README updates

### After Migration
1. **Validate** items moved correctly
2. **Review** source file updates
3. **Check** README file counts
4. **Test** enforcement script with smart migration detection

## 🔗 Related Documentation

- **Organization Standards:** `docs/workflows/cleanup-and-reorganization-standards.md`
- **Enforcement Script:** `scripts/enforce-organization-standards.sh`
- **Migration Script:** `scripts/migrate-todo-items.sh`
- **Todo Templates:** `todos/templates/todo-template.md`
- **Main Todos:** `todos/README.md`

---

**Status:** ✅ **IMPLEMENTED AND TESTED**
**Next Action:** Run migration on existing completed files
