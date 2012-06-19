#!/bin/sh

TERMINAL=urxvtc.sh

if [ -e "${HOME}/.wine/drive_c/Program Files (x86)" ]; then
	WINEPATH32="${HOME}/.wine/drive_c/Program Files (x86)"
	WINEPATH64="${HOME}/.wine/drive_c/Program Files"
	WINEPATH=${WINEPATH32}
else
	WINEPATH="${HOME}/.wine/drive_c/Program Files"
fi

function launch_wine {
	pkill xcompmgr
	restorexcompmgr=$?

	cd "$1"
	wine "$2"

	if [ $restorexcompmgr -eq 0 ]; then
		xcompmgr &
	fi
}

case $1 in
#====================
	cs)
		launch_wine "${WINEPATH}/Counter-Strike 1.6" cstrike.exe
		;;
#====================
	cstrike)
		launch_wine "${WINEPATH}/CS Source" cstrike.exe
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
		launch_wine "${WINEPATH}/GridWars54" GridWars.exe
		;;
#====================
	heroes)
		launch_wine "${WINEPATH}/Heroes of Might and Magic III" Heroes3.exe
		;;
#====================
	starcraft)
		launch_wine "${WINEPATH}/Starcraft" StarCraft.exe
		;;
#====================
	torchlight)
		launch_wine "${WINEPATH}/Torchlight" Torchlight.exe
		;;
#====================
	win7)
		SDL_VIDEO_X11_WMCLASS="qemu-win7" qemu-kvm -name "win7" -hda VMs/Windows\ 7.img -net nic,macaddr=00:de:ad:fa:ce:00 -net tap,ifname=tap0,script=no,downscript=no -m 1024 -smp 4 -usbdevice tablet
		;;
#====================
	wow)
		launch_wine "${WINEPATH}/World of Warcraft" WoW.exe
		;;
#====================
	*)
		notify-send -t 3000 "launch.sh: Unknown command"
		echo "launch.sh: Unknown command">&2
		;;
esac

