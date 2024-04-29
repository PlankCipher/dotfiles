#!/bin/bash

ICONS=("" "" "" "" "" "" "" "" "")

get_workspaces () {
  ACTIVE_WORKSPACE=$(hyprctl activeworkspace | head -n 1 | cut -d ' ' -f 3)

  if [[ $ACTIVE_WORKSPACE -gt 0 ]]; then
    WORKSPACES="["

    for WORKSPACE in $(hyprctl workspaces | grep -i 'workspace id' | cut -d ' ' -f 3 | sort -n); do
      if [[ $WORKSPACE -gt 0 ]]; then
        CLASS=$([[ $WORKSPACE == $ACTIVE_WORKSPACE ]] && echo 'workspace--active' || echo '')

        WORKSPACES+=$(printf '{"id":"%s","class":"%s","icon":"%s"},' "$WORKSPACE" "$CLASS" "${ICONS[$WORKSPACE - 1]}")
      fi
    done

    WORKSPACES="${WORKSPACES::-1}]"
    echo $WORKSPACES
  fi
}

get_workspaces

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | \
  while read -r EVENT; do
    case $EVENT in
      workspace*|createworkspace*|destroyworkspace*|moveworkspace*|focusedmon*|monitorremoved*|monitoradded*)
        get_workspaces
        ;;
    esac
  done
