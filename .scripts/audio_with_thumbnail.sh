#!/bin/bash

AUDIO_INFO="$(yt-dlp -s -f bestaudio -O '%(url)s %(thumbnail)s %(fulltitle)s' $1)"

AUDIO_URL="$(echo $AUDIO_INFO | cut -d ' ' -f 1)"
AUDIO_THUMBNAIL_URL="$(echo $AUDIO_INFO | cut -d ' ' -f 2)"
AUDIO_FULLTITLE="$(echo $AUDIO_INFO | cut -d ' ' -f 3-)"

MPV_CMD="mpv --loop-file=inf --cache-on-disk=yes --demuxer-max-bytes=2GiB --force-media-title='"$AUDIO_FULLTITLE"' --cover-art-file='"$AUDIO_THUMBNAIL_URL"' '"$AUDIO_URL"'"

hyprctl dispatch exec "[workspace 4 silent; fullscreen] $MPV_CMD"
