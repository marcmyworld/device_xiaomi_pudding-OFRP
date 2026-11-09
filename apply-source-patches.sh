#!/bin/bash
#
# Copyright (C) 2026 The OrangeFox Recovery Project
#
# Device-specific source patches for Xiaomi 17 (pudding)
#

set -e

# Detect the Android build top directory
if [ -n "$ANDROID_BUILD_TOP" ] && [ -d "$ANDROID_BUILD_TOP/bootable/recovery" ]; then
	TOP_DIR="$ANDROID_BUILD_TOP"
else
	# Resolve top relative to script: device/xiaomi/pudding/../../.. -> root
	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
	TOP_DIR="$(cd "$SCRIPT_DIR/../../.." 2>/dev/null && pwd)"
fi

if [ ! -d "$TOP_DIR/bootable/recovery" ]; then
	if [ -d "$PWD/bootable/recovery" ]; then
		TOP_DIR="$PWD"
	else
		echo "[pudding] Error: Cannot locate Android build top directory (bootable/recovery not found)." >&2
		exit 1
	fi
fi

# =============================================================================
# Patch: Set default haptic vibration duration to 15ms in bootable/recovery
#
# Context:
# Xiaomi 17 uses an ultra-high efficiency LRA actuator with fast rise time (5-8ms).
# The stock TWRP/OrangeFox default of 40ms forces continuous sinusoidal driving
# past the peak, creating unwanted actuator rattle/endstop collisions.
# A 15ms default pulse provides an affirmative, solid physical "thud" with zero
# acoustic rattle when paired with 192_hapticsVideo_RTP.bin.
# =============================================================================
DATA_CPP="$TOP_DIR/bootable/recovery/data.cpp"
if [ -f "$DATA_CPP" ]; then
	if grep -q 'mPersist.SetValue("tw_button_vibrate", "40");' "$DATA_CPP"; then
		sed -i 's/mPersist.SetValue("tw_button_vibrate", "40");/mPersist.SetValue("tw_button_vibrate", "15");/' "$DATA_CPP"
		sed -i 's/mPersist.SetValue("tw_keyboard_vibrate", "40");/mPersist.SetValue("tw_keyboard_vibrate", "15");/' "$DATA_CPP"
		touch "$DATA_CPP"
		echo "[pudding] Default vibration duration patched: 40ms -> 15ms in bootable/recovery/data.cpp"
	elif grep -q 'mPersist.SetValue("tw_button_vibrate", "15");' "$DATA_CPP"; then
		echo "[pudding] Default vibration duration already set to 15ms in bootable/recovery/data.cpp"
	else
		echo "[pudding] Notice: tw_button_vibrate in data.cpp is not set to 40ms; leaving current value intact."
	fi
else
	echo "[pudding] Warning: $DATA_CPP not found, skipping vibration patch." >&2
fi
