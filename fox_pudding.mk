#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#


# --------------------------------------------------------------------------
# Display, Notch, and GUI Layout
# --------------------------------------------------------------------------
# Calculate the screen height using (aspect ratio numerator * 120)
OF_SCREEN_H := 2352
OF_STATUS_H := 160

# Add hide notch option in settings
OF_HIDE_NOTCH := 1

# Horizontal indent (padding) to avoid rounded corner clipping
OF_STATUS_INDENT_LEFT := 80
OF_STATUS_INDENT_RIGHT := 80

# Status bar clock alignment options: 0 = left, right and center | 1 = left and right | 2 = left only
OF_CLOCK_POS := 1

# Enable button instead of swipe up gesture in lockscreen
OF_USE_LOCKSCREEN_BUTTON := 1

# Maximum visible items in options listboxes before enabling scrolling
OF_OPTIONS_LIST_NUM := 8

# Set 1 if has a notification/charging led
OF_USE_GREEN_LED := 0

# Set Default Timezone
OF_DEFAULT_TIMEZONE := IST-5:30;IST


# --------------------------------------------------------------------------
# Flashlight (Torch) Integration
# --------------------------------------------------------------------------
OF_FL_PATH1 := /sys/class/leds/white:flash-1
OF_FL_PATH2 := /sys/class/leds/yellow:flash-0


# --------------------------------------------------------------------------
# Data Formatting
# --------------------------------------------------------------------------
# Ensure userdata is always formatted as F2FS
OF_FORCE_DATA_FORMAT_F2FS := 1

# Force kernel-native F2FS casefolding on emulated storage
OF_FORCE_CASEFOLDING := 1

# Wipe metadata encryption key slot after formatting data to cleanly re-initialize FBE
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Unbind /sdcard before formatting F2FS userdata to prevent busy-mount failures
OF_UNBIND_SDCARD_F2FS := 1


# --------------------------------------------------------------------------
# Partition, Storage, and File System Safety
# --------------------------------------------------------------------------
# Device partition architecture: A/B device equipped with dedicated recovery partitions
OF_AB_DEVICE_WITH_RECOVERY_PARTITION := 1

# Enable AIDL BootControl HAL for Virtual A/B OTA slot switching
OF_USE_AIDL_BOOT_CONTROL := 1

# Enable native Android 'dmctl' (Device Mapper control) instead of legacy 'dmsetup'
# Used to delete /dev/block/mapper/userdata before formatting to avoid busy-device errors
# Useful for devices with dynamic partitions
OF_USE_DMCTL := 1

# Explicitly unmount /sdcard before rebooting to prevent F2FS dirty unmount / corruption
OF_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1

# Total byte size of the dynamic super partition group (13,421,772,800 bytes)
OF_DYNAMIC_FULL_SIZE := 13421772800

# Prevent SurfaceFlinger reload after decrypting FBE userdata
# Essential on Android 15/16/HyperOS to avoid the black-screen / screen timeout freeze bug
OF_NO_RELOAD_AFTER_DECRYPTION := 1

# Bypass Treble compatibility zip check errors on custom ROM flashing
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1

# Workaround for TWRP backup/restore bugs on modern Android versions
OF_WORKAROUND_BACKUP_BUG := 1

# Quick backup default selection list
OF_QUICK_BACKUP_LIST := /boot;/init_boot;/vendor_boot;

# Enable FRP (Factory Reset Protection) partition wiping addon
OF_ENABLE_FRP_ADDON := 1

# Enable all partition management and maintenance tools in recovery
OF_ENABLE_ALL_PARTITION_TOOLS := 1

# Display detailed debug information when formatting file systems
OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO := 1

# Force OrangeFox to use prebuilt kernel rather than trying to build inline
OF_FORCE_PREBUILT_KERNEL := 1

# Use LZ4 compression for fast ramdisk unpacking/repacking
OF_USE_LZ4_COMPRESSION := 1

# Enable filesystem compression support (F2FS / EROFS)
OF_ENABLE_FS_COMPRESSION := 1

# Default vibration durations in ms [button,keyboard,action]
OF_VIBRATION_DEFAULTS := 10,10,160
