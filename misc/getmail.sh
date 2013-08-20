#!/bin/bash

while true; do
	imapfilter &>/dev/null && offlineimap -o -u quiet &>/dev/null &
	sleep 3600
done
