#!/bin/bash

if (eww active-windows | grep bar > /dev/null); then
  eww close-all
else
  eww close-all
  eww open bar
fi
