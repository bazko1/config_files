#!/bin/sh
# This script disables laptop builtin monitor if external displays are detected.

displays=$(xrandr | grep " connected")
num_display=$(echo "$displays" | wc -l)
if  [ "$num_display" -gt 1 ]; then
  edp=$(echo "$displays" | grep "eDP-1" | cut -f 1 -d ' ')
  xrandr --auto --output "$edp" --off
else
  xrandr --auto
fi
