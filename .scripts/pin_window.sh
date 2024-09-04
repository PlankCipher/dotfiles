#!/bin/bash

if [[ -z "$(hyprctl clients | grep 'pinned: 1')" ]]; then
  hyprctl --batch 'dispatch setfloating active ; dispatch resizeactive exact 240 135 ; dispatch moveactive exact 1665 930 ; dispatch pin active'
else
  if [[ -z "$(hyprctl clients | grep 'at: 1665,930')" ]]; then
    hyprctl dispatch movewindowpixel exact 1665 930,floating
  else
    hyprctl dispatch movewindowpixel exact 1930 930,floating
  fi
fi
