# How to Identify and Disable Unused or Resource-Heavy Extensions in Cursor IDE

## Step-by-Step Guide

### 1. Open the Extensions Sidebar
- Press `Cmd + Shift + X` or click the Extensions icon in the Activity Bar on the left.

### 2. Review Installed Extensions
- The sidebar lists all installed extensions.
- Look for extensions you don’t use regularly or don’t recognize.

### 3. Identify Resource-Heavy Extensions
- Common heavy extensions include:
  - Language servers for languages you don’t use
  - Docker, Python, or Java packs (if not needed)
  - Live Share, Prettier, or large linters
- Unsure? Right-click an extension and select **Extension Settings** to review its features and resource usage (if available).

### 4. Disable Unused Extensions
- Right-click the extension you want to disable.
- Select **Disable** (for workspace or globally).
- Disabled extensions appear grayed out in the list.

### 5. (Optional) Uninstall Extensions
- For extensions you never use, right-click and select **Uninstall**.

### 6. Restart Cursor IDE
- After disabling or uninstalling extensions, restart Cursor IDE to ensure changes take effect.

### 7. (Optional) Monitor Performance
- If Cursor IDE is still slow, try disabling more extensions and restart again.
- You can always re-enable extensions later if needed.

## Pro Tips
- Keep only the extensions you use regularly.
- Enable/disable extensions per workspace if you work on different project types.
- Periodically review your extensions list to keep your environment lean. 