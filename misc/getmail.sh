#!/bin/bash

while true; do
	echo "$(date "+%H:%M") : checking mail"
	PID=$(pgrep offlineimap)
	[[ -n "$PID" ]] && kill "$PID"
	imapfilter &>/dev/null && offlineimap -o -u quiet &>/dev/null &

	sleep 15m
done
