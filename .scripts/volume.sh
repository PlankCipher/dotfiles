#!/bin/bash

get_volume () {
  VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

  VOLUME=$(echo "$VOLUME_INFO" | awk '{print ($2 * 100)}')
  ICON=""
  CLASS="volume"

  if (echo "$VOLUME_INFO" | grep MUTED > /dev/null); then
    ICON=""
    CLASS="off"
    VOLUME="muted"
  elif [[ $VOLUME -gt 66 ]]; then
    ICON=""
  elif [[ $VOLUME -gt 33 ]]; then
    ICON=""
  else
    ICON=""
  fi

  printf '{"class": "%s", "icon": "%s", "text": "%s"}\n' "$CLASS" "$ICON" "$VOLUME"
}

get_mic () {
  if (wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep MUTED > /dev/null); then
    echo 'Off'
  else
    echo 'On'
  fi
}

case $1 in
  volume)
    get_volume

    pactl subscribe | \
      while read -r EVENT; do
        if [[ "$EVENT" == "Event 'change' on sink "* ]]; then
          get_volume
        fi
      done
    ;;

  mic)
    get_mic

    pactl subscribe | \
      while read -r EVENT; do
        if [[ "$EVENT" == "Event 'change' on source "* ]]; then
          get_mic
        fi
      done
    ;;

  change-volume)
    DIRECTION=$2

    if [[ "$DIRECTION" == "up" ]]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
    else
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
    fi
    ;;
esac
