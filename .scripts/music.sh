#!/bin/sh

CURRENT=$(mpc current | sed 's/\.mp3//')
CURRENT_TRUNC=$(echo "$CURRENT" | cut -c -11 | sed 's/ $//')

if [[ "$CURRENT_TRUNC" != "$CURRENT" ]]; then
  CURRENT="$CURRENT_TRUNC..."
fi

STATUS=$(mpc | awk 'NR==2 { print $1 }' | sed -E 's/\[|\]//g')
if [[ "$STATUS" == "playing" ]]; then
  echo -e "\x10\x0b $CURRENT"
else
  echo -e "\x10\x0b \x11$CURRENT\x0b"
fi
