#!/bin/bash

TOP_MARGIN=66
BOTTOM_MARGIN=2
LEFT_MARGIN=2
RIGHT_MARGIN=66
Y_DECOR_SIZE=27
X_DECOR_SIZE=2

#DISPLAY_WIDTH=$(xrandr 2>/dev/null | grep "*" | awk '{print $1}' | awk -F "x" '{print $1}')
#DISPLAY_HEIGHT=$(xrandr 2>/dev/null | grep "*" | awk '{print $1}' | awk -F "x" '{print $2}')

#Works fast enough (no noticeable lag)
DISPLAY_WIDTH=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | awk -F "x" '{print $1}')
DISPLAY_HEIGHT=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | awk -F "x" '{print $2}')

#Works immediately:
#DISPLAY_WIDTH=1366
#DISPLAY_HEIGHT=768

let WORKAREA_WIDTH=${DISPLAY_WIDTH}-${LEFT_MARGIN}-${RIGHT_MARGIN}
let WORKAREA_HEIGHT=${DISPLAY_HEIGHT}-${TOP_MARGIN}-${BOTTOM_MARGIN}

let NEW_WINDOW_HALF_WIDTH=$WORKAREA_WIDTH/2-$X_DECOR_SIZE
let NEW_WINDOW_FULL_WIDTH=$WORKAREA_WIDTH-$X_DECOR_SIZE
let NEW_WINDOW_HALF_X=$WORKAREA_WIDTH/2+${LEFT_MARGIN}

let NEW_WINDOW_HALF_HEIGHT=$WORKAREA_HEIGHT/2-$Y_DECOR_SIZE
let NEW_WINDOW_FULL_HEIGHT=$WORKAREA_HEIGHT-$Y_DECOR_SIZE
let NEW_WINDOW_HALF_Y=$WORKAREA_HEIGHT/2+${TOP_MARGIN}

case "$1" in
	left)
		wmctrl -r :ACTIVE: -e "1,$LEFT_MARGIN,$TOP_MARGIN,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_FULL_HEIGHT"
		;;
	right)
		wmctrl -r :ACTIVE: -e "1,$NEW_WINDOW_HALF_X,$TOP_MARGIN,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_FULL_HEIGHT"
		;;
	top)
		wmctrl -r :ACTIVE: -e "1,$LEFT_MARGIN,$TOP_MARGIN,$NEW_WINDOW_FULL_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	bottom)
		wmctrl -r :ACTIVE: -e "1,$LEFT_MARGIN,$NEW_WINDOW_HALF_Y,$NEW_WINDOW_FULL_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	righttop)
		wmctrl -r :ACTIVE: -e "1,$NEW_WINDOW_HALF_X,$TOP_MARGIN,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	lefttop)
		wmctrl -r :ACTIVE: -e "1,$LEFT_MARGIN,$TOP_MARGIN,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	rightbottom)
		wmctrl -r :ACTIVE: -e "1,$NEW_WINDOW_HALF_X,$NEW_WINDOW_HALF_Y,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	leftbottom)
		wmctrl -r :ACTIVE: -e "1,$LEFT_MARGIN,$NEW_WINDOW_HALF_Y,$NEW_WINDOW_HALF_WIDTH,$NEW_WINDOW_HALF_HEIGHT"
		;;
	*)
		echo "Usage: $0 {left|right|top|down|righttop|lefttop|rightbottom|leftbottom}"
		exit 1
		;;
esac
exit 0

