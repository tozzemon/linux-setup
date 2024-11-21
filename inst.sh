#! /bin/bash

input=""
prfx="[Script]"
counter=1
cmd=""

# Flags:
# 
# `confirm` (Boolean) - toggles confirmation message before each command execution.
# `delay` (Boolean) - adds one second delay after each command.
#
#

xcute() {
	local pass=false
        echo -e "\n$prfx Step: $counter Command: $cmd\n"
	if [ "$confirm" == true ]; then
		while [ "$pass" == false ]; do
			read -n 1 -p "$prfx Proceed? [Y/n] " input && echo
			case "$input" in
				[Yy]|"") pass=true ;;
				[Nn]) echo "$prfx Aborted."; exit ;;
				*) continue ;;
			esac
		done
	fi
	pass=false
	eval "$cmd"
	if [ "$delay" == true ]; then
		i=0
		while [ "$i" -lt 1 ]; do
			sleep 1
			((i++))
		done
	fi
	((counter++))
}

# `cmd=<string-command> && xcute`

cmd="echo 'A text provided by echo command!'" && xcute
cmd="mkdir test111 && ls && rm rest111" && xcute
cmd="echo -e 'And another one text'" && xcute

# SDDM

# Add SDDM theme from ./themes/where_is_my_sddm_theme to /usr/share/sddm/themes
# Add backing up /usr/share/sddm/scripts/Xsetup to turn off the second monitor
