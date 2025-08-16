# Logging Organization and Error Handling

**Status:** PLANNING
**Priority:** Medium
**Created:** 2025-07-27
**Category:** Infrastructure

## Issue

The current logging system has inconsistent log locations and no organization by process type. Some scripts log to `$HOME/Library/Logs/` while others use `$PROJECT_ROOT/logs/`.

### Current State
- ✅ `migrate-todo-items.sh` → `$PROJECT_ROOT/logs/`
- ✅ `pdf-watcher.sh` → `$PROJECT_ROOT/logs/`
- ❌ `swap-ssd-health.sh` → `$HOME/Library/Logs/` (inconsistent)
- ❌ `docker-optimize.sh` → `$HOME/Library/Logs/` (inconsistent)
- ❌ No process-specific log directories
- ❌ No automatic log rotation or cleanup

## Required Actions

### 1. Create Process-Specific Log Directories
- [ ] Create `logs/migration/` for todo migration logs
- [ ] Create `logs/monitoring/` for system monitoring logs
- [ ] Create `logs/backup/` for backup operation logs
- [ ] Create `logs/docker/` for Docker optimization logs
- [ ] Create `logs/scripts/` for general script logs

### 2. Update Script Log Paths
- [ ] Update `swap-ssd-health.sh` to use `$PROJECT_ROOT/logs/monitoring/`
- [ ] Update `docker-optimize.sh` to use `$PROJECT_ROOT/logs/docker/`
- [ ] Update `migrate-todo-items.sh` to use `$PROJECT_ROOT/logs/migration/`
- [ ] Update `pdf-watcher.sh` to use `$PROJECT_ROOT/logs/backup/`

### 3. Implement Log Rotation
- [ ] Create log rotation script
- [ ] Set up automatic cleanup for old logs
- [ ] Implement log compression for archives
- [ ] Add log retention policies

### 4. Improve Error Handling
- [ ] Exclude non-applicable directories from README checks
- [ ] Add better error messages for missing directories
- [ ] Create log directory validation
- [ ] Add log file integrity checks

## Implementation Plan

### Phase 1: Directory Structure
```bash
# Create process-specific log directories
mkdir -p logs/migration/
mkdir -p logs/monitoring/
mkdir -p logs/backup/
mkdir -p logs/docker/
mkdir -p logs/scripts/

# Create README files for each directory
touch logs/migration/README.md
touch logs/monitoring/README.md
touch logs/backup/README.md
touch logs/docker/README.md
touch logs/scripts/README.md
```

### Phase 2: Script Updates
```bash
# Update log paths in scripts
# swap-ssd-health.sh: LOG_FILE="$PROJECT_ROOT/logs/monitoring/swap-ssd-health.log"
# docker-optimize.sh: LOG_FILE="$PROJECT_ROOT/logs/docker/docker-optimize.log"
# migrate-todo-items.sh: LOG_FILE="$PROJECT_ROOT/logs/migration/todo-migration-$(date +%Y%m%d_%H%M%S).log"
# pdf-watcher.sh: LOG_FILE="$PROJECT_ROOT/logs/backup/pdf-watcher.log"
```

### Phase 3: Log Rotation
```bash
# Create log rotation script
# Implement automatic cleanup
# Add compression for archives
```

### Phase 4: Error Handling
```bash
# Update enforce-organization-standards.sh
# Add log directory validation
# Improve error messages
```

## Success Criteria

- [ ] All scripts log to `$PROJECT_ROOT/logs/` with process-specific subdirectories
- [ ] Log rotation and cleanup working automatically
- [ ] No false errors for non-applicable directories
- [ ] Clear error messages for missing log directories
- [ ] Log file integrity validation working

## Related Files

- `scripts/enforce-organization-standards.sh` - Add log directory validation
- `ops/monitoring/swap-ssd-health.sh` - Update log path
- `ops/docker/docker-optimize.sh` - Update log path
- `scripts/migrate-todo-items.sh` - Update log path
- `ops/backup/pdf-watcher.sh` - Update log path

## Notes

This will improve log organization, make debugging easier, and ensure consistent logging across all scripts. The process-specific directories will make it easier to find relevant logs and implement proper rotation policies.

**Impact:** Medium (infrastructure improvement)
**Effort:** Medium (multiple script updates + new directories)
**Dependencies:** None

