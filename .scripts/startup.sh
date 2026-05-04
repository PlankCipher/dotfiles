#!/bin/bash

sleep 3

if ! pgrep kabmat > /dev/null; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special()'

    KABMAT_CMD='wezterm start --class "wezterm kabmat" bash -c "sleep 0.2 && kabmat"'
    hyprctl dispatch "hl.dsp.exec_cmd('$KABMAT_CMD')"

    sleep 2
    hyprctl dispatch 'hl.dsp.workspace.toggle_special()'
fi

hyprctl dispatch 'hl.dsp.exec_cmd("wezterm start --class wezterm",                                     { workspace = "1 silent" })'
hyprctl dispatch 'hl.dsp.exec_cmd("wezterm start --class wezterm",                                     { workspace = "2 silent" })'
hyprctl dispatch 'hl.dsp.exec_cmd("brave",                                                             { workspace = "3 silent" })'
hyprctl dispatch 'hl.dsp.exec_cmd("/opt/FreeTube/freetube --ozone-platform-hint=wayland --new-window", { workspace = "5 silent" })'
hyprctl dispatch 'hl.dsp.exec_cmd("virt-manager",                                                      { workspace = "7 silent" })'
hyprctl dispatch 'hl.dsp.exec_cmd("thunderbird",                                                       { workspace = "8 silent" })'
