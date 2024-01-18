#!/bin/sh

CPU_FAN=$(echo "scale=1; $(sensors | grep 'Processor Fan' | awk '{ print $3 }') / 1000" | bc)
GPU_FAN=$(echo "scale=1; $(sensors | grep 'Video Fan' | awk '{ print $3 }') / 1000" | bc)
BOOSTED=false

# Gameshift mode (fans at BOOST speed)
if (( $(echo "$CPU_FAN >= 5" | bc) )) && (( $(echo "$GPU_FAN >= 5" | bc) )); then
  BOOSTED=true
fi

get_status () {
  echo "$CPU_FAN $GPU_FAN"
}

toggle () {
  if $BOOSTED; then
    sudo dell-g5se-fanctl.py
  else
    sudo killall dell-g5se-fanctl.py
    sudo dell-g5se-fanctl -b
  fi
}

case $1 in
  toggle)
    toggle
    ;;

  *)
    get_status
    ;;
esac
