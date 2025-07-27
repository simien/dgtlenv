# Migration Report Generation Bug - Investigation Log

**Status:** 🚧 **OPEN**
**Date:** 2025-07-27
**Maintainer:** Simien Antonis-Parr

---

## 🐞 Bug Summary

- The todo migration script (`scripts/migrate-todo-items.sh`) is supposed to generate a migration report in the `logs/` directory (e.g., `logs/migration-report-YYYYMMDD_HHMMSS.md`).
- The report is **not being created** because the script is exiting early after processing only the first file with dynamic symbols (`typography-rhythm-todo.md`).
- Only a subset of files in `todos/completed/` are processed; the script stops after the first migration.

---

## 🔍 Investigation Findings

- **Expected Behavior:**
  - The script should process all `*-todo.md` files in `todos/completed/`.
  - After processing, it should generate a comprehensive migration report in `logs/`.
- **Actual Behavior:**
  - The script processes only the first few files (typically up to `typography-rhythm-todo.md`) and then stops.
  - No migration report is generated in `logs/`.
  - No error messages are shown; the script simply halts.
- **Confirmed by:**
  - Multiple runs with verbose/debug output
  - Log file and tail output
  - Manual file checks in `logs/`

---

## 🛠️ Hypothesis

- The script likely contains a bug where a `return` or `exit` in a function (such as `process_completed_file`) is halting the main loop prematurely.
- The use of `return` in a subshell or function called from a loop may be causing the parent shell to exit the loop.
- The `find ... -print0 | while ...` pattern may be affected by this, especially in Bash.

---

## 📝 Next Steps

- Refactor the script to ensure that all files are processed and the report is always generated.
- Replace any `return` statements in functions with proper value passing (e.g., via variables or echo) and avoid using `exit` except in the main script body.
- Add additional debug output to confirm loop completion.
- Test after each change to confirm the report is generated.

---

## 📂 Related Files

- `scripts/migrate-todo-items.sh`
- `logs/`

---

## 🕒 Status

- **Bug is open and pending fix.**
- This document is saved for future debugging and resolution.

---

**Last updated:** 2025-07-27
