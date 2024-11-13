#!/usr/bin/env bash

# Auto USB Drive Mount/Unmount Script
# Hardcoded values
DEVICE="/dev/sdc"
UUID="54206E3D206E2668"
LABEL="SAMSUNG"
MOUNT_POINT="/mnt/external_drive"
LOG_FILE="/var/log/usb_drive_operations.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to check if the drive is mounted
is_mounted() {
    mountpoint -q "$MOUNT_POINT"
}

# Function to mount the drive
mount_drive() {
    log_message "Attempting to mount drive..."
    
    # Power up the drive
    if hdparm -C "$DEVICE" | grep -q "standby"; then
        log_message "Powering up drive..."
        hdparm -S 0 "$DEVICE"
    fi

    # Create mount point if it doesn't exist
    mkdir -p "$MOUNT_POINT"

    # Attempt to mount by UUID
    if mount -U "$UUID" "$MOUNT_POINT"; then
        log_message "Drive mounted successfully at $MOUNT_POINT"
    else
        log_message "Failed to mount by UUID. Attempting to mount by LABEL..."
        if mount -L "$LABEL" "$MOUNT_POINT"; then
            log_message "Drive mounted successfully at $MOUNT_POINT"
        else
            log_message "Failed to mount drive. Please check the device."
            return 1
        fi
    fi
}

# Function to unmount the drive
unmount_drive() {
    log_message "Attempting to unmount drive..."
    if umount "$MOUNT_POINT"; then
        log_message "Drive unmounted successfully"
        # Power down the drive
        log_message "Powering down drive..."
        hdparm -y "$DEVICE"
        log_message "Drive operation completed successfully"
    else
        log_message "Failed to unmount drive. It might be in use."
        return 1
    fi
}

# Main script logic
if is_mounted; then
    unmount_drive
else
    mount_drive
fi
