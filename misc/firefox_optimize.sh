#!/bin/sh

pgrep "^firefox$"
if [[ $? == 0 ]]; then
	echo "Please exit firefox"
	exit 1
fi

for f in ~/.mozilla/firefox/*/*.sqlite; do sqlite3 $f 'VACUUM;'; done

