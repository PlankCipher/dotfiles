#!/bin/bash

hyprctl switchxkblayout all next

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
