#!/bin/bash

CURRENT_ZOOM=$(hyprctl getoption misc:cursor_zoom_factor | grep float | cut -d ' ' -f 2)

case $1 in
  in)
    hyprctl keyword misc:cursor_zoom_factor $(echo "$CURRENT_ZOOM + 0.5" | bc)
    ;;

  out)
    if (( $(echo "$CURRENT_ZOOM > 1" | bc) )); then
      hyprctl keyword misc:cursor_zoom_factor $(echo "$CURRENT_ZOOM - 0.5" | bc)
    fi
    ;;
esac
