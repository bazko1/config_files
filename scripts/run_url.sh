#!/bin/bash

YT_PLAYER=mpv
BROWSER=vivaldi

URL="$1"

[ "$URL" == "" ] && exit 0

# TODO: more sophisticated way of detection if given url is video media type supported by mpv
if [[ "$URL" =~ ^.*youtube.com/watch ]];then
  $YT_PLAYER "$URL"
else
  $BROWSER "$URL"
fi

exit 0
