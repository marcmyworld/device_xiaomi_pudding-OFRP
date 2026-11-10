#!/system/bin/sh

LOGMSG() {
    # 1. Standard recovery log (/tmp/recovery.log)
    echo "I:$@" >> /tmp/recovery.log
    # 2. Android logcat (adb logcat -s OrangeFox)
    log -p i -t "OrangeFox" "$@" 2>/dev/null
    # 3. Kernel log (adb shell dmesg)
    echo "<6>[OrangeFox] $@" > /dev/kmsg 2>/dev/null
}

LOGMSG "[DEBUG] --- post_rom_flash_completion start ---"

# Orangefox persistence
if [ -s /tmp/fox_backup.img ]; then
    LOGMSG "[DEBUG] Found OrangeFox backup image in RAM; restoring to recovery partitions..."
    for slot in _a _b; do
        target="/dev/block/bootdevice/by-name/recovery${slot}"
        if [ -e "$target" ]; then
            LOGMSG "[DEBUG] Restoring OrangeFox recovery to slot${slot}..."
            if dd if="/tmp/fox_backup.img" of="$target" bs=1M; then
                sync
                LOGMSG "[DEBUG] Slot${slot} recovery restored successfully."
            else
                LOGMSG "[DEBUG] Failed to restore recovery to slot${slot}!"
            fi
        else
            LOGMSG "[DEBUG] Recovery partition not found for slot${slot}, skipping restore."
        fi
    done
    rm -f /tmp/fox_backup.img
    LOGMSG "[DEBUG] OrangeFox persistence restored successfully."
else
    LOGMSG "[DEBUG] No OrangeFox backup image found in RAM; skipping restore."
fi

LOGMSG "[DEBUG] --- post_rom_flash_completion end ---"
