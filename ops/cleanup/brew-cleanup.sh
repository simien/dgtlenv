#!/bin/bash
# Homebrew Cleanup Script for macOS
# Frees up disk space by removing old versions, cache, and unneeded packages

set -e

echo "[brew-cleanup] Cleaning up Homebrew..."
brew cleanup
brew autoremove

echo "[brew-cleanup] Homebrew cleanup complete." 