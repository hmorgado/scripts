#!/bin/bash

DEVICE_LIST=(XHC0 XHC1 GPP3 GPP4 LID0)

for device in "${DEVICE_LIST[@]}"; do
    echo "$(date) - INFO - Checking $device"
        if acpitool -w | grep "$device" | grep -q enabled; then
                echo "$(date) - WARN - Disabling $device..."
                echo $device > /proc/acpi/wakeup
        else
                echo "$(date) - INFO - Device $device already disabled"
        fi
done

exit 0
