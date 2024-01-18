#!/bin/bash

APPNAME=$1
SUMMARY=$2
BODY=$3
ICON=$4
URGENCY=$5

NOTIFICATION_JSON="$(jo -B -- -s appname="$APPNAME" -s summary="$SUMMARY" -s body="$BODY" -s urgency="$URGENCY")"

BRACKETS_REMOVED_NOTIFICATIONS="$(eww get notifications | sed 's/^\[\(.*\)\]$/\1/')"
NEW_NOTIFICATIONS=""
if [[ "$BRACKETS_REMOVED_NOTIFICATIONS" == "" ]]; then
  NEW_NOTIFICATIONS="[$NOTIFICATION_JSON]"
else
  NEW_NOTIFICATIONS="[$NOTIFICATION_JSON,$BRACKETS_REMOVED_NOTIFICATIONS]"
fi

for i in $(seq 0 $(( $(echo "$NEW_NOTIFICATIONS" | jq '. | length') - 1 ))); do
  NEW_NOTIFICATIONS="$(echo "$NEW_NOTIFICATIONS" | jq --compact-output "$(printf '.[%s] |= (. += {"id": "%s"})' "$i" "$i")")"
done

eww update notifications="$NEW_NOTIFICATIONS"

if ! (eww active-windows | grep control_center > /dev/null); then
  eww open control_center
fi
