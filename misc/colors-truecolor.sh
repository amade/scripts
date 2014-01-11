#!/bin/sh

#R:/\__/\
#G:_/\/\_
#B:\_/\_/

width=`tput cols`
height=`tput lines`
x=0
y=0

# hide cursor
echo -e "\e[?25l"

while [ $x -le $width ]; do
	if [ $(bc <<< "scale=3; ${x}<${width}/6") -eq 1 ]; then
		r=255
		g=0
		b=$(bc <<< "scale=5; ${x}/(${width}/6)*255")
	elif [ $(bc <<< "scale=3; ${x}<${width}/6*2") -eq 1 ]; then
		r=$(bc <<< "scale=5; ((${width}/6*2)-${x})/(${width}/6)*255")
		g=0
		b=255
	elif [ $(bc <<< "scale=3; ${x}<${width}/6*3") -eq 1 ]; then
		r=0
		g=$(bc <<< "scale=5; (${x}-${width}/6*2)/(${width}/6)*255")
		b=255
	elif [ $(bc <<< "scale=3; ${x}<${width}/6*4") -eq 1 ]; then
		r=0
		g=255
		b=$(bc <<< "scale=5; ((${width}/6*4)-${x})/(${width}/6)*255")
	elif [ $(bc <<< "scale=3; ${x}<${width}/6*5") -eq 1 ]; then
		r=$(bc <<< "scale=5; (${x}-${width}/6*4)/(${width}/6)*255")
		g=255
		b=0
	else
		r=255
		g=$(bc <<< "scale=5; ((${width})-${x})/(${width}/6)*255")
		b=0
	fi
	while [ $y -le $height ]; do
		R=$(bc <<< "scale=5; ${r}*(${height}-${y})/${height}" | cut -d . -f 1)
		G=$(bc <<< "scale=5; ${g}*(${height}-${y})/${height}" | cut -d . -f 1)
		B=$(bc <<< "scale=5; ${b}*(${height}-${y})/${height}" | cut -d . -f 1)
		echo -en "\e[${y};${x}H"
		echo -en "\e[48;2;${R};${G};${B}m "
		y=$(( $y + 1 ))
	done
	y=0
	x=$(( $x + 1 ))
done

sleep 5
scrot

# show cursor
echo -e "\e[?25h"

clear
