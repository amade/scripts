#!/bin/bash

files=(	\
	/usr/bin/compton
        /usr/bin/blender \
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
		paxctl-ng -m ${files[${i}]}
		echo -e "\033[31mpaxmarked\033[0m ${files[${i}]}"
	fi
done
