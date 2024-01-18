#!/bin/sh

HISTORY=""

run () {
  if [[ $1 ]]; then
    HISTORY="$1\n${HISTORY}"
    INPUT=$(printf "$HISTORY" | rofi -dmenu -p 'Calculate' -l 15)
    exit_on_esc
    RESULT=$(echo "$INPUT" | qalc | sed '3!d; s/\x1b\[[0-9;]*m//g' | cut -c 3-)
    run "$RESULT"
  else
    INPUT=$(printf '%s' | rofi -dmenu -p 'Calculate')
    exit_on_esc
    RESULT=$(echo "$INPUT" | qalc | sed '3!d; s/\x1b\[[0-9;]*m//g' | cut -c 3-)
    run "$RESULT"
  fi
}

exit_on_esc () {
  EXIT_CODE=$?
  if [[ $EXIT_CODE -ne 0 ]]; then
    exit $EXIT_CODE
  fi
}

run
