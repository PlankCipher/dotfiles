#!/bin/bash

pause () {
  echo 'paused' > $PMDR_STATUS_FILE
}

resume () {
  echo $(date -d "+$(cat $PMDR_REM_FILE) seconds" +%s) > $PMDR_END_FILE
  echo 'running' > $PMDR_STATUS_FILE
}

start_break_session () {
  echo 'break' > $PMDR_SESSION_TYPE_FILE
  echo $(date -d '+15 minutes' +%s) > $PMDR_END_FILE
  echo $(( 15 * 60 )) > $PMDR_REM_FILE
  resume
}

start_work_session () {
  echo 'work' > $PMDR_SESSION_TYPE_FILE
  echo $(date -d '+45 minutes' +%s) > $PMDR_END_FILE
  echo $(( 45 * 60 )) > $PMDR_REM_FILE
  resume
}

get_state () {
  PMDR_REM_TIME=$(cat $PMDR_REM_FILE)
  PMDR_TYPE=$(cat $PMDR_SESSION_TYPE_FILE)
  PMDR_STATUS=$(cat $PMDR_STATUS_FILE)

  PMDR_CLASS=""
  if [[ "$PMDR_STATUS" == "running" ]]; then
    PMDR_CUR_REM_TIME=$(( $(cat $PMDR_END_FILE) - $(date +%s) ))
    echo $PMDR_CUR_REM_TIME > $PMDR_REM_FILE

    if (( $PMDR_CUR_REM_TIME > 0 )); then
      PMDR_CLASS="running"
    else
      pause
      notify-send -a 'pomodoro' "$PMDR_TYPE session is over"
      PMDR_CLASS="blink"
    fi
  else
    PMDR_CUR_REM_TIME=$PMDR_REM_TIME
    echo $(date -d "+$PMDR_REM_TIME seconds" +%s) > $PMDR_END_FILE
    PMDR_CLASS="off"
  fi

  PMDR_ICON=""
  if [[ "$PMDR_TYPE" == "work" ]]; then
    PMDR_ICON=""
  else
    PMDR_ICON=""
  fi
  PMDR_TEXT="$(( (PMDR_CUR_REM_TIME + 60 - 1) / 60 ))m"

  printf '{"icon": "%s", "rem": "%s", "class": "%s"}' "$PMDR_ICON" "$PMDR_TEXT" "$PMDR_CLASS"
}

if ls -d /tmp/pomodoro* &> /dev/null; then
  PMDR_TEMP_DIR="$(ls -d /tmp/pomodoro*)"
  PMDR_STATUS_FILE="$(ls $PMDR_TEMP_DIR/status*)"
  PMDR_SESSION_TYPE_FILE="$(ls $PMDR_TEMP_DIR/type*)"
  PMDR_END_FILE="$(ls $PMDR_TEMP_DIR/end*)"
  PMDR_REM_FILE="$(ls $PMDR_TEMP_DIR/rem*)"
else
  PMDR_TEMP_DIR="$(mktemp -d /tmp/pomodoro.XXXXXXXXXX)"
  PMDR_STATUS_FILE="$(mktemp $PMDR_TEMP_DIR/status.XXXXXXXXXX)"
  PMDR_SESSION_TYPE_FILE="$(mktemp $PMDR_TEMP_DIR/type.XXXXXXXXXX)"
  PMDR_END_FILE="$(mktemp $PMDR_TEMP_DIR/end.XXXXXXXXXX)"
  PMDR_REM_FILE="$(mktemp $PMDR_TEMP_DIR/rem.XXXXXXXXXX)"

  start_work_session
  pause
fi

case $1 in
  toggle-status)
    PMDR_STATUS=$(cat $PMDR_STATUS_FILE)

    if [[ "$PMDR_STATUS" == "running" ]]; then
      pause
    else
      resume
    fi

    eww update pomodoro="$(get_state)"
    ;;

  toggle-type)
    PMDR_TYPE=$(cat $PMDR_SESSION_TYPE_FILE)

    if [[ "$PMDR_TYPE" == "work" ]]; then
      start_break_session
    else
      start_work_session
    fi

    eww update pomodoro="$(get_state)"
    ;;

  *)
    get_state
    ;;
esac
