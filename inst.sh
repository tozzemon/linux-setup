#! /bin/bash

prfx="[Script]"
command_number=1
stage_number=1
cmd=""
standalone_installation=false
configure_installation=false

# Flags:

# `confirm` (type: bool, default: false) - toggles confirmation message before each command execution.
# `delay` (type: bool, default: false) - adds one second delay after each command.

greeter() {
	echo -e "\nArtix (Dinit) Dummy Installation Script by tozzemon\n"
	echo -e "[S]tandalone installation (starts immidiately)\n[C]onfigure installation (adjust before start)\n[U]pdate (tries to suck an update from GitHub)\n[Q]uit"
	while [ true ]; do
		local input=""
		echo && read -n 1 -p "$prfx >>> " input && echo
		case "$input" in
			[Ss]) standalone_installation ;;
			[Cc]) configure_installation ;;
			[Uu]) updateScript ;;
			[Qq]) exit ;;
			*) echo -e "\n$prfx ! There's no such option..." ;;
		esac
	done
}

xcute() {
	local input=""
	local pass=false
        echo -e "\n$prfx Stage: $stage_number Step: $command_number Command: $cmd\n"
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

greeter

# Scenario:

cmd="echo 'A text provided by echo command!'" && xcute
cmd="mkdir test111 && ls && rm rest111" && xcute
cmd="echo -e 'And another one text'" && xcute

# SDDM

# Add SDDM theme from ./themes/where_is_my_sddm_theme to /usr/share/sddm/themes
# Add backing up /usr/share/sddm/scripts/Xsetup to turn off the second monitor
