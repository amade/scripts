#!/bin/bash

loaded_modules=( `semodule -l | awk '{ print $1 }'` )
installed_policies=( `equery d selinux-base-policy | awk '{print $1}' | grep '^sec' | awk -F "-" '{print $3}'` )
basepolicy=( application authlogin bootloader clock consoletype cron dmesg fstools getty hostname hotplug init iptables libraries locallogin logging lvm miscfiles modutils mount mta netutils nscd portage raid rsync selinuxutil ssh staff storage su sysadm sysnetwork udev userdomain usermanage unprivuser xdg )
policies=$(ls /usr/portage/sec-policy | grep -v '(selinux-base|selinux-base-policy|metadata.xml)' | awk -F "-" '{print $2}')

#policy=$(sestatus| grep "Loaded policy name"| awk '{print $4}')

echo "Loaded modules:"
for module in ${loaded_modules[@]}; do
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

echo "Installed policies:"
for policy in ${installed_policies[@]}; do
	status="\e[1;31munloaded!\e[0m"
	for module in ${loaded_modules[@]}; do
		if [ $module == $policy ]; then
			status="\e[1;32mloaded\e[0m"
		fi
	done
	printf "%20s %b\n" "${policy}" "${status}"
done

printf "\n"

dontauditstatus=( `seinfo --stats | grep Dontaudit | awk -F " " '{print $4}'` )
if [ ${dontauditstatus} -gt 0 ]; then
	printf "Dontaudit is \e[1;32menabled\e[0m\n"
else
	printf "Dontaudit is \e[1;31mdisabled\e[0m\n"
fi
