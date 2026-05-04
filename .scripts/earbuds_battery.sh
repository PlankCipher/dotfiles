#!/bin/bash

UPOWER_EARBUDS_PATH=/org/freedesktop/UPower/devices/headset_dev_5C_DC_49_01_81_E2
EARBUDS_BAT_LOW=15

EARBUDS_BATTERY=""
EARBUDS_CLASS=""

if upower -i $UPOWER_EARBUDS_PATH | head -n 1 | grep '(null)' > /dev/null; then
  EARBUDS_BATTERY="N/A"
  EARBUDS_CLASS="off"
else
  EARBUDS_PERC="$(upower -i $UPOWER_EARBUDS_PATH | grep percentage | awk '{print $2}' | tr -d '%')"

  EARBUDS_BATTERY="$EARBUDS_PERC%"

  if [[ $EARBUDS_PERC -le $EARBUDS_BAT_LOW ]]; then
    EARBUDS_CLASS="blink"
    notify-send -a 'Earbuds' "Low battery ($EARBUDS_BATTERY)."
  fi
fi

printf '{"battery": "%s", "class": "%s"}' "$EARBUDS_BATTERY" "$EARBUDS_CLASS"
