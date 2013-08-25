#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ `whoami` !=  "root" ]]; then
	echo "need root access"
	exit 1
fi

for i in `ls ${DIR}/admin`; do
	ln -s "${DIR}/admin/${i}" "/usr/local/sbin/${i}"
done
for i in `ls ${DIR}/misc`; do
	ln -s "${DIR}/misc/${i}" "/usr/local/bin/${i}"
done
for i in `ls ${DIR}/screen`; do
	ln -s "${DIR}/screen/${i}" "/usr/local/bin/${i}"
done
for i in `ls ${DIR}/x11`; do
	ln -s "${DIR}/x11/${i}" "/usr/local/bin/${i}"
done
echo "done"
