# Incoming PDFs

Drop PDF files in this folder to automatically convert them to Markdown.

## How it works:
1. Place any PDF file in this folder
2. The PDF watcher will detect the new file
3. Convert it to Markdown and place the `.md` file in the root of `docs/`
4. The original PDF remains in this folder as backup

## Usage:
- Simply drag and drop PDF files here
- The conversion happens automatically
- Check the root of `docs/` for the converted Markdown files

## Notes:
- PDFs that already have newer `.md` files will be skipped
- The watcher runs via `ops/backup/pdf-watcher.sh`
- Conversion logs are stored in `logs/pdf-watcher.log` 