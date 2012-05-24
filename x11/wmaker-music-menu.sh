#!/bin/bash

TERM=urxvtc.sh

echo "Music MENU"

which mpd 1>/dev/null
if [ $? -eq 1 ]; then
  nompd=1
fi
which mpc 1>/dev/null
if [ $? -eq 1 ]; then
  nompc=1
fi
if [ $nompd ] || [ $nompc ]; then
  echo "\"Please install mpd & mpc\" EXEC true"
  exit 1
fi

pgrep mpd 1>/dev/null
if [ $? -eq 1 ]; then
  echo "\"Start MPD\" EXEC mpd"
  exit 1
fi

echo "\"Artist: $(mpc current -f %artist% | sed -e 's/)/\\)/g')\" EXEC \"${TERM} -e ncmpcpp\""
echo "\"Album: $(mpc current -f %album% | sed -e 's/)/\\)/g')\" EXEC \"${TERM} -e ncmpcpp\""
echo "\"Title: $(mpc current -f %title% | sed -e 's/)/\\)/g')\" EXEC \"${TERM} -e ncmpcpp\""

echo "\"=====\" EXEC true"

echo "\"(Play/Pause)\" EXEC \"mpc toggle\""
echo "\"(Next)\" EXEC \"mpc next\""
echo "\"(Previous)\" EXEC \"mpc prev\""

echo "\"=====\" EXEC true"

mpc | grep -q -s "random\: on" 
if [ $? -eq 1 ]; then
  echo "\"Random [Off]\" EXEC \"mpc random\""
else
  echo "\"Random [On]\" EXEC \"mpc random\""
fi

mpc | grep -q -s "repeat\: on"
if [ $? -eq 1 ]; then
  echo "\"Repeat [Off]\" EXEC \"mpc repeat\""
else
  echo "\"Repeat [On]\" EXEC \"mpc repeat\""
fi

mpc | grep -q -s "consume\: on"
if [ $? -eq 1 ]; then
  echo "\"Consume mode [Off]\" EXEC \"mpc consume\""
else
  echo "\"Consume mode [On]\" EXEC \"mpc consume\""
fi

echo "Music END"
exit 0
