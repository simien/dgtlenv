#!/bin/bash

# Swap & SSD Health Check Script for MacBook Pro 2015
# Run this script periodically to monitor system health

LOG_FILE="$HOME/Library/Logs/swap-ssd-health.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== Swap & SSD Health Check - $DATE ===" | tee -a "$LOG_FILE"

# Check Swap Usage
echo "--- Swap Usage ---" | tee -a "$LOG_FILE"
SWAP_INFO=$(sysctl vm.swapusage 2>/dev/null)
echo "$SWAP_INFO" | tee -a "$LOG_FILE"

# Extract swap usage values
TOTAL_SWAP=$(echo "$SWAP_INFO" | grep 'total' | awk '{print $4}' | sed 's/M//' | sed 's/\..*//')
USED_SWAP=$(echo "$SWAP_INFO" | grep 'used' | awk '{print $4}' | sed 's/M//' | sed 's/\..*//')

# Check if swap usage is high (>50% of total)
if [ ! -z "$TOTAL_SWAP" ] && [ ! -z "$USED_SWAP" ]; then
    SWAP_PERCENT=$((USED_SWAP * 100 / TOTAL_SWAP))
    if [ $SWAP_PERCENT -gt 50 ]; then
        echo "⚠️  WARNING: High swap usage detected ($SWAP_PERCENT%)" | tee -a "$LOG_FILE"
        echo "   Consider closing unused apps or adding more RAM" | tee -a "$LOG_FILE"
    else
        echo "✅ Swap usage is normal ($SWAP_PERCENT%)" | tee -a "$LOG_FILE"
    fi
fi

# Check Pageouts (indicates active swapping)
echo "--- Pageouts (Active Swapping) ---" | tee -a "$LOG_FILE"
PAGEOUTS=$(vm_stat | grep 'pageouts' | awk '{print $2}' | sed 's/\.//')
if [ ! -z "$PAGEOUTS" ] && [ $PAGEOUTS -gt 0 ]; then
    echo "⚠️  WARNING: Active swapping detected ($PAGEOUTS pageouts)" | tee -a "$LOG_FILE"
    echo "   System is using disk as virtual memory" | tee -a "$LOG_FILE"
else
    echo "✅ No active swapping detected" | tee -a "$LOG_FILE"
fi

# Check SSD SMART Status
echo "--- SSD Health ---" | tee -a "$LOG_FILE"

# Basic SMART status
SMART_STATUS=$(diskutil info disk0 | grep 'SMART Status' | awk '{print $3}')
echo "SMART Status: $SMART_STATUS" | tee -a "$LOG_FILE"

if [ "$SMART_STATUS" != "Verified" ]; then
    echo "⚠️  WARNING: SSD SMART status is not verified" | tee -a "$LOG_FILE"
else
    echo "✅ SSD SMART status is verified" | tee -a "$LOG_FILE"
fi

# Detailed SSD health (if smartctl is available)
if command -v smartctl &> /dev/null; then
    echo "--- Detailed SSD Health ---" | tee -a "$LOG_FILE"
    
    # Get SSD wear indicators
    SMART_OUTPUT=$(sudo smartctl -a disk0 2>/dev/null)
    
    # Check for wear leveling count
    WEAR_COUNT=$(echo "$SMART_OUTPUT" | grep 'Wear_Leveling_Count' | awk '{print $10}')
    if [ ! -z "$WEAR_COUNT" ]; then
        echo "Wear Leveling Count: $WEAR_COUNT" | tee -a "$LOG_FILE"
        if [ $WEAR_COUNT -lt 10 ]; then
            echo "⚠️  WARNING: SSD wear leveling count is low" | tee -a "$LOG_FILE"
        fi
    fi
    
    # Check for reallocated sectors
    REALLOCATED=$(echo "$SMART_OUTPUT" | grep 'Reallocated_Sector_Ct' | awk '{print $10}')
    if [ ! -z "$REALLOCATED" ] && [ $REALLOCATED -gt 0 ]; then
        echo "⚠️  WARNING: Reallocated sectors detected ($REALLOCATED)" | tee -a "$LOG_FILE"
    fi
    
    # Check media wearout indicator
    MEDIA_WEAR=$(echo "$SMART_OUTPUT" | grep 'Media_Wearout_Indicator' | awk '{print $10}')
    if [ ! -z "$MEDIA_WEAR" ]; then
        echo "Media Wearout Indicator: $MEDIA_WEAR" | tee -a "$LOG_FILE"
        if [ $MEDIA_WEAR -lt 10 ]; then
            echo "⚠️  WARNING: SSD media wearout indicator is low" | tee -a "$LOG_FILE"
        fi
    fi
else
    echo "smartctl not available - install with: brew install smartmontools" | tee -a "$LOG_FILE"
fi

echo "--- End of Health Check ---" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Optional: Send notification if warnings were found
if grep -q "WARNING" "$LOG_FILE"; then
    # Send macOS notification
    osascript -e 'display notification "System health issues detected. Check logs for details." with title "Swap & SSD Health Check"'
fi 