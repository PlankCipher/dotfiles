#!/bin/bash

KEYBOARDS=$(hyprctl devices | grep -A 1 'Keyboard at' | grep -vE '^\s+Keyboard at|^--' | sed 's/^\s*//')

BATCH_COMMAND=""

for KEYBOARD in $KEYBOARDS; do
  BATCH_COMMAND+="switchxkblayout $KEYBOARD next ; "
done

hyprctl --batch "$BATCH_COMMAND"

KEYBOARD_LAYOUT=$(hyprctl devices | sed -n '/^Keyboards:/,/^Tablets:/ p' | grep 'active keymap:' | head -n 1 | cut -d ' ' -f 3-)

case $KEYBOARD_LAYOUT in
  Arabic*)
    KEYBOARD_LAYOUT="ara"
    ;;

  English*)
    KEYBOARD_LAYOUT="en"
    ;;

  *)
    KEYBOARD_LAYOUT="unknown"
    ;;
esac

eww update keyboard=$KEYBOARD_LAYOUT
