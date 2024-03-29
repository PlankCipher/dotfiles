#!/usr/bin/env bash

# Copyright (C) 2012 Stefan Breunig <stefan+measure-net-speed@mathphys.fsk.uni-heidelberg.de>
# Copyright (C) 2014 kaueraal
# Copyright (C) 2015 Thiago Perrotta <perrotta dot thiago at poli dot ufrj dot br>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

INTERFACE=$(ip route | awk '/^default/ { print $5 ; exit }')

if [[ -z "$INTERFACE" ]]; then
  echo "N/A"
  exit 0
fi

if ! [ -e "/sys/class/net/${INTERFACE}/operstate" ] ||
   (! [ "$TREAT_UNKNOWN_AS_UP" = "1" ] &&
    ! [ "`cat /sys/class/net/${INTERFACE}/operstate`" = "up" ]) then
    echo "N/A"
    exit 0
fi

# path to store the old results in
path="/dev/shm/$(basename $0)-${INTERFACE}"

# grabbing data for each adapter.
read rx < "/sys/class/net/${INTERFACE}/statistics/rx_bytes"
read tx < "/sys/class/net/${INTERFACE}/statistics/tx_bytes"

# get time
time=$(date +%s)

# write current data if file does not exist. Do not exit, this will cause
# problems if this file is sourced instead of executed as another process.
if ! [[ -f "${path}" ]]; then
  echo "${time} ${rx} ${tx}" > "${path}"
  chmod 0600 "${path}"
fi

# read previous state and update data storage
read old < "${path}"
echo "${time} ${rx} ${tx}" > "${path}"

# parse old data and calc time passed
old=(${old//;/ })
time_diff=$(( $time - ${old[0]} ))

# sanity check: has a positive amount of time passed
[[ "${time_diff}" -gt 0 ]] || exit

# calc bytes transferred, and their rate in byte/s
rx_diff=$(( $rx - ${old[1]} ))
tx_diff=$(( $tx - ${old[2]} ))
rx_rate=$(( $rx_diff / $time_diff ))
tx_rate=$(( $tx_diff / $time_diff ))

# shift by 10 bytes to get KiB/s. If the value is larger than
# 1024^2 = 1048576, then display MiB/s instead

# incoming
OUT_RX=""
rx_kib=$(( $rx_rate >> 10 ))
if hash bc 2>/dev/null && [[ "$rx_rate" -gt 1048576 ]]; then
  OUT_RX=$(printf '%sM' "`echo "scale=1; $rx_kib / 1024" | bc`")
else
  OUT_RX="${rx_kib}K"
fi

# outgoing
OUT_TX=""
tx_kib=$(( $tx_rate >> 10 ))
if hash bc 2>/dev/null && [[ "$tx_rate" -gt 1048576 ]]; then
  OUT_TX=$(printf '%sM\n' "`echo "scale=1; $tx_kib / 1024" | bc`")
else
  OUT_TX="${tx_kib}K"
fi

echo " $OUT_RX  $OUT_TX"
