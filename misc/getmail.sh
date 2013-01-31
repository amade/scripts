#!/bin/bash

echo "$(date "+%H:%M") : checking mail"
imapfilter &>/dev/null && offlineimap -o -u quiet &>/dev/null &
