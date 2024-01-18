#!/bin/bash

get_music () {
  STATE=$(mpc status '%state%')

  CLASS="off"
  TEXT="stopped"
  COVER="stopped"

  if [[ "$STATE" != "stopped" ]]; then
    TEXT="$(mpc -f '%title%' current)"
    COVER="$(basename "$(mpc -f '%file%' current)" '.mp3').jpg"
    CLASS="$([[ "$STATE" == "playing" ]] && echo 'music' || echo 'off')"
  fi

  printf '{"class": "%s", "text": "%s", "cover": "%s"}\n' "$CLASS" "$TEXT" "$COVER"
}

get_music

mpc idleloop database update player | \
  while read -r EVENT; do
    get_music
  done
