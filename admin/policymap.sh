#!/bin/bash

modules=( `semodule -l | awk '{ print $1 }'` )
basepolicy=( application authlogin bootloader clock consoletype cron dmesg fstools getty hostname hotplug init iptables libraries locallogin logging lvm miscfiles modutils mount mta netutils nscd portage raid rsync selinuxutil ssh staff storage su sysadm sysnetwork udev userdomain usermanage unprivuser xdg )
policies=$(ls /usr/portage/sec-policy | grep -v '(selinux-base|selinux-base-policy|metadata.xml)' | awk -F "-" '{print $2}')

#policy=$(sestatus| grep "Loaded policy name"| awk '{print $4}')

for module in ${modules[@]}; do
	package="\e[1;33muser supplied\e[0m"
	for searchmodule in ${basepolicy[@]}; do
		if [ $module == $searchmodule ]; then
			if [[ -n "$(qlist -Ie sec-policy/selinux-base-policy)" ]]; then
				package="\e[1;32mselinux-base-policy\e[0m"
			else
				package="\e[1;31mselinux-base-policy [UNMERGED]\e[0m"
			fi
			break
		fi
	done
	for searchmodule in ${policies[@]}; do
		if [ $module == $searchmodule ]; then
			if [[ -n "$(qlist -Ie sec-policy/selinux-${module})" ]]; then
				package="\e[1;32mselinux-${module}\e[0m"
			else
				package="\e[1;31mselinux-${module} [UNMERGED]\e[0m"
			fi
			break
		fi
	done

	printf "%20s %b\n" "${module}" "${package}"
done

#equery d selinux-base-policy | awk '{print $1}' | grep '^sec' |
