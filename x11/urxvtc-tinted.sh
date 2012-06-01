#!/bin/bash
r=$(($RANDOM%5))
g=$(($RANDOM%5))
b=$(($RANDOM%5))
case $r in
0) r="00";;
1) r="3f";;
2) r="7f";;
3) r="bf";;
4) r="ff";;
esac
case $g in
0) g="00";;
1) g="3f";;
2) g="7f";;
3) g="bf";;
4) g="ff";;
esac
case $b in
0) b="00";;
1) b="3f";;
2) b="7f";;
3) b="bf";;
4) b="ff";;
esac

urxvtc.sh -tint "#$r$g$b" "$@"
