#!/bin/sh

EMOJI=$(awk -F '\t' '{ print $1 " " $4 " (" $5 ") [" $2 " / " $3 "]"}' $HOME/.scripts/rofi/rofi_emoji/all_emojis.txt | rofi -dmenu -i -p 'Emoji')

EXIT_CODE=$?
if [[ $EXIT_CODE -ne 0 ]]; then
  exit $EXIT_CODE
fi

EMOJI=$(echo -n "$EMOJI" | awk '{ print $1 }')
echo -n "$EMOJI" | wl-copy
notify-send -a 'rofi_emoji' "$EMOJI was copied to your clipboard"
