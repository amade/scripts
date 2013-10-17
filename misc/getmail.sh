#!/bin/bash

imapfilter &>/dev/null && offlineimap -o -u quiet &>/dev/null &
