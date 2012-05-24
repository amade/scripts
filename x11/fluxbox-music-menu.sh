#!/bin/sh

file=${HOME}/.fluxbox/music-menu
script=$0

run () {
  if [[ $1 == "daemon" ]]; then
    while true; do
      generate_menu
      mpc current --wait --quiet > /dev/null
    done
  else
    generate_menu
  fi
}

generate_menu () {
  rm $file

  which mpd 1>/dev/null
  if [ $? -eq 1 ]; then
    nompd=1
  fi
  which mpc 1>/dev/null
  if [ $? -eq 1 ]; then
    nompc=1
  fi
  if [ $nompd ] || [ $nompc ]; then
    echo "[nop]This script requires mpd & mpc" >> $file
    echo "[nop]installed on system." >> $file
    echo "[separator]" >> $file
    echo "[exec] (Click here after installing) {mpd; ${script}}" >> $file
    exit 1
  fi
    
  pgrep mpd 1>/dev/null

  if [ $? -eq 1 ]; then
    echo "[begin] (Music)" >> $file
    echo "  [exec] (Start MPD) {mpd; ${script}}" >> $file
    echo "[end]" >> $file
    exit 1
  fi

  echo "[begin] (Music)" >> $file
  echo "  [nop] (Now playing:)" >> $file
  echo "  [nop] ($(mpc current -f %artist% | sed -e 's/)/\\)/g'))" >> $file
  echo "  [nop] ($(mpc current -f %title% | sed -e 's/)/\\)/g'))" >> $file
  echo "  [separator]" >> $file
  echo "  [exec] (Play/Pause) {mpc toggle && ${script}}" >> $file
  echo "  [exec] (Next) {mpc next && ${script}}" >> $file
  echo "  [exec] (Previous) {mpc prev && ${script}}" >> $file

  echo "  [separator]" >> $file

  mpc | grep -q -s "random\: on" 
  if [ $? -eq 1 ]; then
    echo "  [exec] (Random [Off]) {mpc random && ${script}}" >> $file
  else
    echo "  [exec] (Random [On]) {mpc random && ${script}}" >> $file
  fi

  mpc | grep -q -s "repeat\: on"
  if [ $? -eq 1 ]; then
    echo "  [exec] (Repeat [Off]) {mpc repeat && ${script}}" >> $file
  else
    echo "  [exec] (Repeat [On]) {mpc repeat && ${script}}" >> $file
  fi

  mpc | grep -q -s "consume\: on"
  if [ $? -eq 1 ]; then
    echo "  [exec] (Consume mode [Off]) {mpc consume && ${script}}" >> $file
  else
    echo "  [exec] (Consume mode [On]) {mpc consume && ${script}}" >> $file
  fi

  echo "[end]" >> $file
}

run $@
