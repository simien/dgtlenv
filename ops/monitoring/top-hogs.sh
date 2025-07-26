#!/bin/bash
# Top Resource Hogs Script for macOS
# Shows top CPU and memory consuming processes

set -e

echo "[top-hogs] Top 10 CPU-consuming processes:"
ps aux | sort -nrk 3 | head -n 11

echo "\n[top-hogs] Top 10 Memory-consuming processes:"
ps aux | sort -nrk 4 | head -n 11 