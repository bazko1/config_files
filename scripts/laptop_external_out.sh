#!/bin/sh
# This script disables laptop builtin monitor if external displays are detected.

displays=$(xrandr | grep " connected")
num_display=$(echo "$displays" | wc -l)
if  [ "$num_display" -gt 1 ]; then
  xrandr --auto --output eDP-1-1 --off
fi
