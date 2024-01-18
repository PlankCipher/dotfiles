#!/bin/bash

NOTIFICATION_ID=$1

NEW_NOTIFICATIONS="$(eww get notifications | jq --compact-output "del(.[$NOTIFICATION_ID])")"

for i in $(seq 0 $(( $(echo "$NEW_NOTIFICATIONS" | jq '. | length') - 1 ))); do
  NEW_NOTIFICATIONS="$(echo $NEW_NOTIFICATIONS | jq --compact-output "$(printf '.[%s] |= (. += {"id": "%s"})' "$i" "$i")")"
done

eww update notifications="$NEW_NOTIFICATIONS"
