#!/bin/bash

case ${1} in
nouveau)
	files=(	\
		/usr/bin/kwin \
		/usr/bin/mplayer \
		/usr/bin/mplayer2 \
		/usr/bin/systemsettings \
		/usr/bin/vlc \
		/usr/games/bin/xonotic-glx \
		/usr/lib64/kde4/libexec/kwin_opengl_test \
		/usr/lib64/virtualbox/VBoxTestOGL \
		/usr/libexec/gnome-session-check-accelerated-helper
	)

	for i in $(seq 0 $((${#files[@]} -1))); do
		if [ -e ${files[${i}]} ]; then
			paxctl -m ${files[${i}]}
			echo -e "\033[31mpaxmarked\033[0m ${files[${i}]}"
		fi
	done
	;;
nvidia)
	for i in `/bin/ls -1 /usr/bin/`; do
		ldd "/usr/bin/${i}" 2>&1 >&- | grep "error while loading shared libraries: libGL.so.1" > /dev/null
		if [ ${?} == 0 ]; then
			paxctl -m "/usr/bin/${i}"
			if [ ${?} == 1 ]; then
				echo -e "\033[31madding header\033[0m /usr/bin/${i}"
				paxctl -C "/usr/bin/${i}"
				paxctl -m "/usr/bin/${i}"
			fi
			echo -e "\033[31mpaxmarked\033[0m /usr/bin/${i}"
		fi
	done
	for i in `/bin/ls -1 /usr/lib64/`; do
		ldd "/usr/lib64/${i}" 2>&1 >&- | grep "error while loading shared libraries: libGL.so.1" > /dev/null
		if [ ${?} == 0 ]; then
			paxctl -m "/usr/lib64/${i}"
			if [ ${?} == 1 ]; then
				echo -e "\033[31madding header\033[0m /usr/lib64/${i}"
				paxctl -C "/usr/lib64/${i}"
				paxctl -m "/usr/lib64/${i}"
			fi
			echo -e "\033[31mpaxmarked\033[0m /usr/lib64/${i}"
		fi
	done
	for i in `/bin/ls -1 /usr/lib64/kde4/`; do
		ldd "/usr/lib64/kde4/${i}" 2>&1 >&- | grep "error while loading shared libraries: libGL.so.1" > /dev/null
		if [ ${?} == 0 ]; then
			paxctl -m "/usr/lib64/kde4/${i}"
			if [ ${?} == 1 ]; then
				echo -e "\033[31madding header\033[0m /usr/lib64/kde4/${i}"
				paxctl -C "/usr/lib64/kde4/${i}"
				paxctl -m "/usr/lib64/kde4/${i}"
			fi
			echo -e "\033[31mpaxmarked\033[0m /usr/lib64/kde4/${i}"
		fi
	done

	;;
*)
	echo "Usage: ${0} [nouveau|nvidia]"
esac

