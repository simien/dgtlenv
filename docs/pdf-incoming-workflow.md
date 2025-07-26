# PDF Incoming Workflow

This document explains the automated PDF-to-Markdown conversion workflow using the `docs/incoming/` folder.

## Overview

The system now uses a dedicated `incoming` folder for PDF processing:

- **Drop Zone**: `docs/incoming/` - Place PDFs here for conversion
- **Output**: `docs/` - Converted Markdown files appear here
- **Backup**: Original PDFs remain in `incoming/` folder

## How It Works

### 1. Drop PDFs in Incoming Folder
```bash
# Simply drag and drop PDF files into:
docs/incoming/
```

### 2. Automatic Conversion
The PDF watcher (`ops/backup/pdf-watcher.sh`) monitors the incoming folder and:
- Detects new or modified PDF files
- Converts them to Markdown using `pdftotext`
- Places the `.md` files in the root of `docs/`
- Skips PDFs that already have newer `.md` files

### 3. File Organization
```
docs/
├── incoming/           # Drop PDFs here
│   ├── README.md      # Instructions
│   └── *.pdf          # Original PDFs (backup)
├── *.md               # Converted Markdown files
└── *.pdf              # Any existing PDFs in docs root
```

## Usage

### Start the Watcher
```bash
# From project root
./ops/backup/pdf-watcher.sh watch
```

### Manual Conversion
```bash
# Convert all PDFs in incoming folder
./ops/backup/pdf-to-markdown-converter.sh all

# Convert specific PDF
./ops/backup/pdf-to-markdown-converter.sh convert docs/incoming/example.pdf
```

### Check Status
```bash
# Show watcher status and recent activity
./ops/backup/pdf-watcher.sh status
```

### Stop Watcher
```bash
# Stop the file watcher
./ops/backup/pdf-watcher.sh stop
```

## Migration from Old System

If you have existing converted files in `docs/converted/`, run:

```bash
# Move existing converted files to docs root
./ops/backup/move-converted-files.sh
```

This will:
- Move all `.md` files from `docs/converted/` to `docs/`
- Skip files that already exist in docs root
- Optionally remove the empty `converted` directory

## Features

### Smart Skipping
- PDFs with newer `.md` files are automatically skipped
- Prevents unnecessary re-conversion
- Saves processing time and resources

### Metadata Preservation
Each converted Markdown file includes:
- Original PDF filename
- File size
- Page count (if available)
- Conversion timestamp
- Status indicator

### Logging
- All conversion activity is logged to `logs/pdf-watcher.log`
- Includes timestamps and success/failure status
- Useful for troubleshooting and monitoring

### Metrics Tracking
- Conversion statistics stored in `metrics/pdf-conversion-metrics.json`
- Dashboard available at `metrics/pdf-processing-dashboard.md`
- Tracks total conversions and processing history

## Troubleshooting

### Common Issues

1. **Watcher not detecting files**
   - Ensure `fswatch` is installed: `brew install fswatch`
   - Check watcher status: `./ops/backup/pdf-watcher.sh status`

2. **Conversion fails**
   - Install `pdftotext`: `brew install poppler`
   - Check log file: `logs/pdf-watcher.log`

3. **Files not moving**
   - Ensure scripts are executable: `chmod +x ops/backup/*.sh`
   - Check file permissions and disk space

### Manual Fallback
If automatic conversion fails, use the simple converter:
```bash
./ops/backup/simple-pdf-converter.sh all
```

This creates placeholder files that can be manually edited.

## Best Practices

1. **Keep incoming folder organized**
   - Remove processed PDFs periodically
   - Use descriptive filenames

2. **Monitor disk space**
   - Original PDFs remain in incoming folder
   - Consider archiving old PDFs

3. **Regular maintenance**
   - Check logs for errors
   - Update metrics dashboard
   - Clean up old backup files

4. **Backup strategy**
   - Use `./ops/backup/create-digitalenv-backup.sh` before major changes
   - Keep backups of important converted documents

## Integration with Optimization System

This workflow integrates with the DigitalEnv optimization system:

- **Resource monitoring**: Uses `ops/monitoring/top-hogs.sh` to track conversion impact
- **Cleanup integration**: Works with `ops/cleanup/` scripts for maintenance
- **Backup integration**: Includes converted files in project backups
- **Documentation**: Tracks conversion history in optimization summaries 