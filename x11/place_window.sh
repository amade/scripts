#!/bin/bash

TOP_MARGIN=66
BOTTOM_MARGIN=2
LEFT_MARGIN=2
RIGHT_MARGIN=66

ACTIVE_WINDOW=$(xprop -root | grep _NET_ACTIVE_WINDOW\(WINDOW\) | awk '{print $5}')

if [ $ACTIVE_WINDOW == "0x0" ]; then
	# Do not touch root window
	exit 0;
fi

Y_DECOR_SIZE=$(xprop -id ${ACTIVE_WINDOW} | grep _NET_FRAME_EXTENTS | awk 'BEGIN{result=0}{result += $5}{result += $6}END{print result}')
X_DECOR_SIZE=$(xprop -id ${ACTIVE_WINDOW} | grep _NET_FRAME_EXTENTS | awk 'BEGIN{result=0}{result += $3}{result += $4}END{print result}')

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

