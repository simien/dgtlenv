# ops/

This directory contains automation scripts, monitoring tools, and configuration templates for system optimization, development, and maintenance.

## Structure
- `backup/` — Backup scripts for DgtlEnv project
- `cleanup/` — Cleanup scripts (Homebrew, Docker, system)
- `monitoring/` — Monitoring and resource tracking scripts
- `docker/` — Docker-specific utility scripts and Colima setup
- `templates/` — Configuration and best-practice examples

## Usage
- Scripts are designed for macOS 12.7.6 Monterey on MacBook Pro 2015.
- Make scripts executable: `chmod +x scriptname.sh`
- Run scripts from the project root or specify the full path.

## Templates
- `templates/cursor-settings-performance.json` — Optimized Cursor IDE settings
- `templates/docker-compose-resource-limits-example.yml` — Example for adding resource limits to your docker-compose.yml
- `templates/optimization-summary-template.md` — Template for documenting optimization results

## Script Index

### Monitoring Scripts
- `monitoring/swap-ssd-health.sh` — Comprehensive system health monitoring (swap usage, SSD health)
- `monitoring/top-hogs.sh` — Quick resource usage overview
- `monitoring/README.md` — Detailed monitoring guide

### Docker Optimization
- `docker/docker-optimize.sh` — Docker cleanup and Colima setup automation
- `docker/README.md` — Complete Docker/Colima optimization guide

### Backup Scripts
- `backup/create-dgtlenv-backup.sh` — Creates timestamped zip backup of entire project
- `backup/simple-pdf-converter.sh` — PDF to markdown conversion with file watching
- `backup/pdf-watcher.sh` — Automatic PDF conversion monitoring
- `backup/README.md` — Backup procedures and best practices

### Cleanup Scripts
- `cleanup/brew-cleanup.sh` — Homebrew cache and package cleanup
- `cleanup/docker-cleanup.sh` — Docker resource cleanup
- `cleanup/README.md` — Cleanup procedures and best practices

## Optimization Summary

For comprehensive documentation of optimization results, use:
- `templates/optimization-summary-template.md` — Template for documenting optimization projects
- `docs/optimization-summary.md` — Completed optimization summary (example)

## Cursor IDE Performance Optimization (macOS)

To optimize Cursor IDE for your MacBook Pro 2015 (macOS 12.7.6 Monterey):

1. **Open Settings**: Press `Cmd + ,` or use the gear icon in the lower left.
2. **Search for File Watcher**:
   - Set `files.watcherExclude` to exclude large folders (e.g., node_modules, build, .git, Dropbox sync folders).
   - Example:
     ```json
     "files.watcherExclude": {
       "**/node_modules/*": true,
       "**/build/*": true,
       "**/.git/objects/**": true,
       "**/.dropbox/**": true
     }
     ```
3. **Increase TypeScript Server Memory**:
   - Add or update:
     ```json
     "typescript.tsserver.maxTsServerMemory": 2048
     ```
   - (You may lower this if you have 8GB RAM, e.g., 1024)
4. **Optimize for Large Files**:
   - Set:
     ```json
     "files.maxMemoryForLargeFilesMB": 64,
     "editor.largeFileOptimizations": true
     ```
5. **Disable Unused Extensions**:
   - Go to Extensions (`Cmd+Shift+X`), right-click and disable any you don't use.
6. **Restart Cursor IDE** after making changes.

For a ready-to-use settings.json snippet, see `templates/cursor-settings-performance.json`.

## System Monitoring Setup

### Installed Tools
- **Stats** (v2.11.48) — Menu bar system monitor
- **htop** (v3.4.1) — Advanced process monitoring
- **smartmontools** (v7.5) — SSD health monitoring

### Health Monitoring
- Run weekly: `./monitoring/swap-ssd-health.sh`
- Check menu bar: Stats app for real-time metrics
- Process monitoring: `sudo htop`

### Output Locations
- Health logs: `~/Library/Logs/swap-ssd-health.log`
- Docker logs: `~/Library/Logs/docker-optimize.log`

## Docker/Colima Optimization

### Resource Management
- Container limits: 2 CPU, 2GB RAM per container
- Regular cleanup: `./docker/docker-optimize.sh`
- Colima setup: Lighter alternative to Docker Desktop

### Migration Options
- Keep Docker Desktop with optimized settings
- Switch to Colima for lighter footprint
- Hybrid approach for specific workflows

See `docker/README.md` for complete setup and optimization guide.

## Maintenance Schedule

### Weekly
- System health check: `./monitoring/swap-ssd-health.sh`
- Review Stats menu bar for trends
- Check htop for resource hogs: `sudo htop`

### Monthly
- Docker optimization: `./docker/docker-optimize.sh`
- System cleanup: `./cleanup/brew-cleanup.sh` and `./cleanup/docker-cleanup.sh`
- Project backup: `./backup/create-digitalenv-backup.sh`
- Review log files in `~/Library/Logs/`

### Pre-Release
- Security sanitization: `./scripts/pre-release-sanitizer.sh --fix`
- Verify sanitization: `./scripts/pre-release-sanitizer.sh --dry-run`
- Review generated report: `cat logs/sanitization-report-*.md`

### Quarterly
- Review and update optimization scripts
- Check for new versions of monitoring tools
- Assess SSD health trends
- Adjust resource limits based on usage patterns
- Update security patterns in sanitizer
