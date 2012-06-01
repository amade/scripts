#!/bin/sh

if [ $# -ne 2 ]; then
	echo "Usage: $0 left|right WIDTHxHEIGHT"
	exit 1
fi

# first restore main monitor
xrandr --size 1366x768

# do stuff to the other one
xrandr --auto
xrandr --output LVDS-1 --${1}-of VGA-1
xrandr --output VGA-1 --size ${2}

# set background
nitrogen --restore

pgrep fluxbox
if [ $? -eq 0 ]; then
	fluxbox-remote restart
fi
