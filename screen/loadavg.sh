#!/bin/zsh

scolor=(46 82 118 154 190 226 220 214 208 202 196)

cpus=$(grep processor /proc/cpuinfo| wc -l)

avg=$(cat /proc/loadavg)
avg1=$(echo $avg | cut -f 1 -d ' ')
avg5=$(echo $avg | cut -f 2 -d ' ')
avg15=$(echo $avg | cut -f 3 -d ' ')

color1=$(( ${avg1} / 4. * 11 % 12 + 1))
color5=$(( ${avg5} / 4. * 11 % 12 + 1))
color15=$(( ${avg15} / 4. * 11 % 12 + 1))

if [ $color1 -gt 11 ]; then color1=11; fi
if [ $color5 -gt 11 ]; then color5=11; fi
if [ $color15 -gt 11 ]; then color15=11; fi

echo -en "\005{16;${scolor[$color1]}}${avg1}\005{16;16} \005{16;${scolor[$color5]}}${avg5}\005{16;16} \005{16;${scolor[$color15]}}${avg15}\005{16;16}";
