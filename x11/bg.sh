#!/bin/sh

configfile="${HOME}/.background"

usage () {
	echo -e "\e[31mUsage: ${0} [files dir] [restore|random|previous|next]\e[0m"
	exit 1
}

main () {
	if [ ${#} -ne 2 ]; then
		usage
	fi

	if [ ! -d ${1} ]; then
		usage
	fi

	filenum=0
	if [ -f ${configfile} ]; then
		read filenum < ${configfile}
	else
		filenum=1
	fi

	n_files=`ls -1 "${1}" | wc -l`

	case $2 in
		"restore")
			# do not filenum
			;;
		"previous")
			filenum=$((filenum - 1))
			if [ ${filenum} -le 0 ]; then
				filenum=${n_files}
			fi
			;;
		"next")
			filenum=$(((filenum + 1) % ${n_files}))
			;;
		"random")
			filenum=$(( ${RANDOM} % ${n_files} + 1 ))
			;;
		*)
			usage
	esac

	echo ${filenum} > ${configfile}

	file=`ls -1 "${1}" | head -${filenum} | tail -1`

	wmsetbg -S -f -u "${1}/${file}"
}

main ${@}
