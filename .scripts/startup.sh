#!/bin/bash

sleep 3

if ! pgrep kabmat > /dev/null; then
  hyprctl dispatch togglespecialworkspace
  hyprctl dispatch exec 'wezterm start --class "wezterm kabmat" bash -c "sleep 0.2 && kabmat"'
  sleep 2
  hyprctl dispatch togglespecialworkspace
fi

hyprctl dispatch exec '[workspace 1 silent] wezterm start --class "wezterm"'
hyprctl dispatch exec '[workspace 2 silent] wezterm start --class "wezterm"'
hyprctl dispatch exec '[workspace 3 silent] brave'
hyprctl dispatch exec '[workspace 5 silent] /opt/FreeTube/freetube --ozone-platform-hint=wayland'
hyprctl dispatch exec '[workspace 7 silent] virt-manager'
hyprctl dispatch exec '[workspace 8 silent] thunderbird'
