#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
	echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

LOGMSG "Pruning historic recovery logs..."
/sbin/prune_historic_logs.sh 10 2>/dev/null

LOGMSG "---$SCRIPT_NAME end---"
exit 0
