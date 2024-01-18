#!/bin/bash

killall swaybg

WALLS_NUM=$(ls $HOME/.config/wallpapers/ | wc -l)
swaybg -i $HOME/.config/wallpapers/$(shuf -i 0-$(( $WALLS_NUM - 1 )) -n 1).* -m fill
