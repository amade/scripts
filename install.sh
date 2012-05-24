#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $DIR

if [[ ! -d ~/bin ]]; then
	mkdir ~/bin
fi

if [[ `whoami` ==  "root" ]]; then
	for i in `ls ${DIR}/admin`; do
		ln -s "${DIR}/admin/${i}" "${HOME}/bin/${i}"
	done
else
	for i in `ls ${DIR}/misc`; do
		ln -s "${DIR}/misc/${i}" "${HOME}/bin/${i}"
	done
	for i in `ls ${DIR}/screen`; do
		ln -s "${DIR}/screen/${i}" "${HOME}/bin/${i}"
	done
	for i in `ls ${DIR}/x11`; do
		ln -s "${DIR}/x11/${i}" "${HOME}/bin/${i}"
	done
fi
