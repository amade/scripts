#!/bin/sh

if [ ${1} == "add" ]; then
	wmctrl -n $(( $(wmctrl -d | wc -l) + 1 ))
	exit 0
fi
if [ ${1} == "remove" ]; then
	wmctrl -n $(( $(wmctrl -d | wc -l) - 1 ))
	exit 0
fi
