#!/bin/bash

for i in `find /usr/bin -type f -executable`; do
	rm -rf /tmp/paxit
	ldd $i 1>/dev/null 2>/tmp/paxit
	cat /tmp/paxit | grep libGL.so.1 >/dev/null
	if [ $? -eq 0 ]; then
	paxctl-ng -m "$i"
	echo -e "\033[31mpaxmarked\033[0m ${i}"
	fi
done

for i in `find /usr/libexec -type f -executable`; do
	rm -rf /tmp/paxit
	ldd $i 1>/dev/null 2>/tmp/paxit
	cat /tmp/paxit | grep libGL.so.1 >/dev/null
	if [ $? -eq 0 ]; then
	paxctl-ng -m "$i"
	echo -e "\033[31mpaxmarked\033[0m ${i}"
	fi
done

for i in `find /usr/lib64 -type f -executable`; do
	rm -rf /tmp/paxit
	ldd $i 1>/dev/null 2>/tmp/paxit
	cat /tmp/paxit | grep libGL.so.1 >/dev/null
	if [ $? -eq 0 ]; then
	paxctl-ng -m "$i"
	echo -e "\033[31mpaxmarked\033[0m ${i}"
	fi
done


# /usr/bin/X  needed for acceleration
files=(	\
	/usr/bin/X
)

for i in $(seq 0 $((${#files[@]} -1))); do
	if [ -e ${files[${i}]} ]; then
		paxctl-ng -m ${files[${i}]}
		echo -e "\033[31mpaxmarked\033[0m ${files[${i}]}"
	fi
done

