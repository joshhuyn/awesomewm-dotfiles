#!/bin/sh

xrandr --output DisplayPort-3 --mode 1920x1080 --rate 100 --pos 0x0 --output DisplayPort-2 --mode 1920x1080 --rate 100 --pos 1920x0 --output eDP --mode 1920x1080 --pos 3840x0;
picom -b;
warpd;
