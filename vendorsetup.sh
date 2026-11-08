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

FDEVICE="pudding"

fox_get_target_device() {
local script_path="${BASH_SOURCE[0]}"
   [ -n "$ZSH_VERSION" ] && script_path="${(%):-%x}"
local chkdev=$(echo "$script_path" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep -E "BASH_ARGV|zsh_eval_context" | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" ] || [ "$1" = "$FDEVICE" ] || echo "$1" | grep -qw "$FDEVICE"; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ] || echo "$1" | grep -qw "$FDEVICE"; then
	export LC_ALL="C"

	# Architecture: Seamless Virtual A/B device
	export FOX_AB_DEVICE=1
	export FOX_VIRTUAL_AB_DEVICE=1

	# Command-line tools: Use prebuilt standalone binaries for recovery operations
	export FOX_USE_BUSYBOX_BINARY=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_GREP_BINARY=1
	export FOX_USE_DATE_BINARY=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_FSCK_EROFS_BINARY=1
	export FOX_USE_PATCHELF_BINARY=1

	# GUI & Packages
	export FOX_VANILLA_BUILD=1
	export FOX_DELETE_AROMAFM=1
	export FOX_ALLOW_EARLY_SETTINGS_LOAD=1
	export FOX_USE_UPDATED_MAGISKBOOT=1
	export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1

	# Storage paths for OrangeFox configuration and backups
	export FOX_SETTINGS_ROOT_DIRECTORY=/data/recovery
	export FOX_MISCELLANEOUS_ROOT_DIRECTORY=/sdcard

	# Target devices for flashable zip assertion verification
	export TARGET_DEVICE_ALT="pudding,pudding_global,pudding_in"
	export FOX_TARGET_DEVICES="$TARGET_DEVICE_ALT"

	# Include API 36 prebuilts (keystore2_v36 and libc++_v36.so)
	# Required for KeyMint V4 AIDL decryption on Android 16/17 under a fox_14.1 tree
	export FOX_ADD_API_V36_PREBUILTS=2

	# Root solutions support
	export FOX_ENABLE_KERNELSU_SUPPORT=1
	export FOX_ENABLE_KERNELSU_NEXT_SUPPORT=1
	export FOX_ENABLE_SUKISU_SUPPORT=1

	# Build metadata
	export FOX_BUILD_TYPE=Beta
	export FOX_MAINTAINER_PATCH_VERSION=1

	# Additional configurations
	export FOX_NO_BLANK_DT2W=1
fi
