#!/bin/sh
xrandr --output HDMI1 --primary --mode $1 --pos 0x0 --rotate normal --output DP1 --off --output eDP1 --mode 1366x768 --pos 1920x312 --rotate normal --output VIRTUAL1 --off
