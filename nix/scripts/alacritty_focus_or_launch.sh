#!/usr/bin/env bash

if pgrep -x alacritty > /dev/null; then
  wmctrl -x -a alacritty.Alacritty || echo "Alacritty window not found by wmctrl"
else
  alacritty &
fi