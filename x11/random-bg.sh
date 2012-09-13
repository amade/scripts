#!/bin/sh

n_files=`ls -1 "${1}" | wc -l`

n=$(( $RANDOM % $n_files + 1 ))

file=`ls -1 "$1" | head -${n} | tail -1`

wmsetbg -S -f -u "${1}/${file}"
