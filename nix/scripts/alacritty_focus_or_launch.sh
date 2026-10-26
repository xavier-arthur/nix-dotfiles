#!/usr/bin/env bash

APP="Alacritty"

# detect session
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    # XORG REALM (old but reliable)
    wmctrl -xa "$APP" 2>/dev/null || xdotool search --class "$APP" windowactivate
    exit 0
fi

# WAYLAND REALM (split into tribes)
if [ -n "$SWAYSOCK" ]; then
    # SWAY (structured warband)
    swaymsg "[app_id=$APP] focus" 2>/dev/null
    swaymsg "[class=$APP] focus" 2>/dev/null
    exit 0
fi

if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    # HYPERLAND (spiky speed demons)
    hyprctl dispatch focuswindow "class:$APP"
    exit 0
fi

# GENERIC WAYLAND (no true global control, only prayers)
echo "NO PROPER WAYLAND HOOK FOUND. WINDOW MANAGER TOO CHAOTIC."
exit 1