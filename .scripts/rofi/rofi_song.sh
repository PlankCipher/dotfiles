#!/bin/sh

# Select a song to play through rofi

NEXT_SONG="$(mpc listall | while read -r SONG_FILENAME; do echo ${SONG_FILENAME%.*}; done | rofi -dmenu -p 'Play' -i)"

# Avoid playing next song if the previous
# command exited with a non zero exit code
# in case rofi was closed without choosing anything
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  exit $EXIT_CODE
fi

# Get next song's position in the playlist
# (if exists) and play it
POSITION=1
mpc listall | while read -r SONG_FILENAME; do
  SONG_FILENAME="${SONG_FILENAME%.*}"
  if [[ "$SONG_FILENAME" == "$NEXT_SONG" ]]; then
    mpc play $POSITION && sigdwmblocks 6
    break
  else
    POSITION=$((POSITION + 1))
  fi
done
