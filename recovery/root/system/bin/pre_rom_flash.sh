#!/system/bin/sh

LOGMSG() {
    # 1. Standard recovery log (/tmp/recovery.log)
    echo "I:$@" >> /tmp/recovery.log
    # 2. Android logcat (adb logcat -s OrangeFox)
    log -p i -t "OrangeFox" "$@" 2>/dev/null
    # 3. Kernel log (adb shell dmesg)
    echo "<6>[OrangeFox] $@" > /dev/kmsg 2>/dev/null
}

LOGMSG "[DEBUG] --- pre_rom_flash start ---"

# Set SPL date
LOGMSG "[DEBUG] Resetting SPL date to prevent rollback assertion..."
resetprop ro.build.version.security_patch 2023-12-31


# Wipe stale ota metadata
OTA_DIR="/metadata/ota"
mount /metadata 2>/dev/null

if [ -d "$OTA_DIR" ]; then
    LOGMSG "[DEBUG] Wiping stale OTA metadata ($OTA_DIR)..."
    rm -rf "$OTA_DIR" 2>/dev/null
    LOGMSG "[DEBUG] Stale OTA metadata wiped successfully."
else
    LOGMSG "[DEBUG] No stale OTA metadata found."
fi


# Orangefox persistence
slot="$(getprop ro.boot.slot_suffix)"
if [ -z "$slot" ]; then
    LOGMSG "[DEBUG] Unable to detect active boot slot; skipping recovery backup."
else
    LOGMSG "[DEBUG] Active boot slot: $slot"
    LOGMSG "[DEBUG] Backing up OrangeFox recovery to /tmp/fox_backup.img..."
    if [ -e "/dev/block/bootdevice/by-name/recovery${slot}" ]; then
        if dd if="/dev/block/bootdevice/by-name/recovery${slot}" of="/tmp/fox_backup.img" bs=1M; then
            sync
            LOGMSG "[DEBUG] OrangeFox recovery backed up successfully."
        else
            LOGMSG "[DEBUG] Failed to backup OrangeFox recovery!"
        fi
    else
        LOGMSG "[DEBUG] Recovery partition not found; skipping backup."
    fi
fi

LOGMSG "[DEBUG] --- pre_rom_flash end ---"
