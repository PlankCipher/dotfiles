#!/bin/sh

set_timeout () {
  killall swayidle

  LOCK_TIMEOUT_SECS=$1

  swayidle -w \
    timeout $LOCK_TIMEOUT_SECS 'swaylock -f -e -F -L -K -r --font "LigaSFMono" --bs-hl-color eb6f92 --separator-color 00000000 --key-hl-color 9ccfd8 --inside-color 1d1b2c --ring-color 3a4454 --text-color e0def4 --inside-clear-color 4f413d --ring-clear-color f6c177 --text-clear "Cleared" --text-clear-color e0def4 --inside-ver-color 25364a --ring-ver-color 3e8fb0 --text-ver "Verifying" --text-ver-color e0def4 --inside-wrong-color 4c2e43 --ring-wrong-color eb6f92 --text-wrong "Wrong" --text-wrong-color e0def4 -i ~/.config/hypr/lockscreen.png --effect-blur 10x4 --indicator --indicator-radius 90' \
    timeout $((LOCK_TIMEOUT_SECS + 90)) 'hyprctl dispatch dpms off' \
      resume 'hyprctl dispatch dpms on' \
    before-sleep 'swaylock -f -e -F -L -K -r --font "LigaSFMono" --bs-hl-color eb6f92 --separator-color 00000000 --key-hl-color 9ccfd8 --inside-color 1d1b2c --ring-color 3a4454 --text-color e0def4 --inside-clear-color 4f413d --ring-clear-color f6c177 --text-clear "Cleared" --text-clear-color e0def4 --inside-ver-color 25364a --ring-ver-color 3e8fb0 --text-ver "Verifying" --text-ver-color e0def4 --inside-wrong-color 4c2e43 --ring-wrong-color eb6f92 --text-wrong "Wrong" --text-wrong-color e0def4 -i ~/.config/hypr/lockscreen.png --effect-blur 10x4 --indicator --indicator-radius 90' &

  eww update screen-timeout="$(( $LOCK_TIMEOUT_SECS / 60 ))m"
}

pgrep swayidle > /dev/null

# If the previous command exited with a non-zero
# exit code, then no swayidle process is running
if [[ $? -ne 0 ]]; then
  set_timeout 60
else
  TIMEOUT=$(ps xo args | grep swayidle | grep -v grep | cut -d ' ' -f 4)

  case $TIMEOUT in
    60)
      set_timeout 300
      ;;

    300)
      set_timeout 600
      ;;

    600)
      set_timeout 1800
      ;;

    1800|*)
      killall swayidle
      eww update screen-timeout="Off"
      ;;
  esac
fi
