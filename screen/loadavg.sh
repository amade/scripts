#!/bin/zsh

colors=(46 82 118 154 190 226 220 214 208 202 196)

cpus=$(grep processor /proc/cpuinfo| wc -l)

avg=$(cat /proc/loadavg)

avg1=$(echo $avg | cut -f 1 -d ' ')
avg5=$(echo $avg | cut -f 2 -d ' ')
avg15=$(echo $avg | cut -f 3 -d ' ')

color1=$(( ${avg1} / ${cpus} * ${#colors} ))
color5=$(( ${avg5} / ${cpus} * ${#colors} ))
color15=$(( ${avg15} / ${cpus} * ${#colors} ))

if [ $(( ${color1} >= ${#colors} )) -eq 1 ]; then
	color1=${#colors}
else
	color1=$(( ${color1} % 11 + 1 ))
fi
if [ $(( ${color5} >= ${#colors} )) -eq 1 ]; then
	color5=${#colors};
else
	color5=$(( ${color5} % 11 + 1))
fi
if [ $(( ${color15} >= ${#colors} )) -eq 1 ]; then
	color15=${#colors};
else
	color15=$(( ${color15} % 11 + 1))
fi
echo -en "\005{16;${colors[$color1]}}${avg1}\005{-;-} \005{16;${colors[$color5]}}${avg5}\005{-;-} \005{16;${colors[$color15]}}${avg15}\005{-;-}";
