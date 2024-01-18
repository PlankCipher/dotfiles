#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

ICON=""
CLASS=""

if [[ "$STATUS" == "Full" ]]; then
  ICON=""
  CLASS="blink"
elif [[ "$STATUS" == "Charging" ]]; then
  ICON=""

  if [[ $CAPACITY -ge 97 ]]; then
    CLASS="blink"
    notify-send -a 'Battery' 'Battery almost full'
  fi
else
  if [[ $CAPACITY -ge 80 ]]; then
    ICON=""
  elif [[ $CAPACITY -ge 60 ]]; then
    ICON=""
  elif [[ $CAPACITY -ge 40 ]]; then
    ICON=""
  elif [[ $CAPACITY -ge 20 ]]; then
    ICON=""
  else
    ICON=""
  fi

  if [[ $CAPACITY -le 15 ]]; then
    CLASS="blink"
    notify-send -a 'Battery' 'Battery low'
  fi
fi

printf '{"icon": "%s", "capacity": "%s", "class": "%s"}' "$ICON" "$CAPACITY" "$CLASS"
