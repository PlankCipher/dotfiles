#!/bin/sh

CPU_TEMP=$(sensors | grep Tctl | awk '{ print $2 }' | tr -d '+°C' | cut -d '.' -f 1)
GPU_TEMP=$(sensors | grep GPU | awk '{ print $2 }' | tr -d '+°C' | cut -d '.' -f 1)

echo "$CPU_TEMP $GPU_TEMP"
