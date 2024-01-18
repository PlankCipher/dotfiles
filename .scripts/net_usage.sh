#!/bin/bash

# Uses vnstat to get the total used bandwidth for today

INTERFACE=$(ip route | awk '/^default/ { print $5 ; exit }')

TODAY_TIMESTAMP=$(date +%Y-%m-%d)
VNSTAT_TIMESTAMP=$(vnstat -i $INTERFACE --oneline | awk -F\; '{ print $3 }')

OUTPUT=""

if [[ $TODAY_TIMESTAMP == $VNSTAT_TIMESTAMP ]]; then
  RX=$(vnstat -i $INTERFACE --oneline | awk -F\; '{ print $4 }' | sed -E 's/[0-9] //; s/iB//')
  TX=$(vnstat -i $INTERFACE --oneline | awk -F\; '{ print $5 }' | sed -E 's/[0-9] //; s/iB//')
  OUTPUT=" $RX  $TX"
else
  OUTPUT="N/A"
fi

echo "$OUTPUT"
