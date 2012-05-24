#!/bin/sh

TERMINAL=urxvtc.sh

if [ -e "${HOME}/.wine/drive_c/Program Files (x86)" ]; then
	WINEPATH32="${HOME}/.wine/drive_c/Program Files (x86)"
	WINEPATH64="${HOME}/.wine/drive_c/Program Files"
	WINEPATH=${WINEPATH32}
else
	WINEPATH="${HOME}/.wine/drive_c/Program Files"
fi

case $1 in
#====================
	cs)
		pkill xcompmgr
		restorexcompmgr=$?

		cd "${WINEPATH}/Counter-Strike 1.6"
		wine cstrike.exe

		if [ $restorexcompmgr -eq 0 ]; then
			xcompmgr &
		fi
		;;
#====================
	ekg2)
		wmctrl -s 0
		pgrep ekg2
		if [ $? -eq 1 ]; then
			${TERMINAL} -e ekg2
		fi
		;;
#====================
	firefox)
		wmctrl -s 1
		pgrep firefox
		if [ $? -eq 1 ]; then
			firefox
		else
			firefox -new-tab about:blank
		fi
		;;
#====================
	gridwars)
		pkill xcompmgr
		restorexcompmgr=$?

		cd "${WINEPATH}/GridWars54"
		wine GridWars.exe

		if [ $restorexcompmgr -eq 0 ]; then
			xcompmgr &
		fi
		;;
#====================
	starcraft)
		pkill xcompmgr
		restorexcompmgr=$?

		cd "${WINEPATH}/Starcraft"
		wine StarCraft.exe

		if [ $restorexcompmgr -eq 0 ]; then
			xcompmgr &
		fi
		;;
#====================
	torchlight)
		pkill xcompmgr
		restorexcompmgr=$?

		cd "${WINEPATH}/Torchlight"
		wine Torchlight.exe

		if [ $restorexcompmgr -eq 0 ]; then
			xcompmgr &
		fi
		;;
#====================
	wow)
		pkill xcompmgr
		restorexcompmgr=$?

		cd "${WINEPATH}/World of Warcraft"
		wine WoW.exe

		if [ $restorexcompmgr -eq 0 ]; then
			xcompmgr &
		fi
		;;
#====================
	heroes)
		cd "${WINEPATH}/Heroes of Might and Magic III"
		wine Heroes3.exe
		;;
#====================
	*)
		notify-send -t 3000 "launch.sh: Unknown command"
		echo "launch.sh: Unknown command">&2
		;;
esac

