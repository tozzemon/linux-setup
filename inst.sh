#! /bin/bash

prfx="[Script]"
command_number=1
stage_number=1
standalone_installation=false
basestrap_packages="linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit"
basestrap_minimal="linux-firmware base dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit bash-completion grub gvim neofetch neovim ntfs-3g openssh wget"
basestrap_kernel="linux"

# Flags

# `confirm` (type: bool, default: false) - toggles confirmation message before each command execution.
# `delay` (type: bool, default: false) - adds one second delay after each command.

# Greeter

grtr() {
	local input=""
	echo -e "\nArtix (Dinit) Dummy Installation Script by tozzemon\n"
	echo -e " [S]tart immediately\n [B]asestrap adjustment\n [U]pdate the script\n [Q]uit\n"
	
	while [ true ]; do

		read -n 1 -p ">>> " input
		
		case "$input" in

			[Ss]) scenario ;;
			[Bb]) basestrapManager ;;
			[Uu]) update ;;
			[Qq]) exit ;;
			*) echo -e "\n ! There's no such option..." ;;

		esac

	done
}

# Commands executor

x() {
	local input=""
	local pass=false

        echo -e "\nStage: $stage_number Step: $command_number Command: $c"

	if [ "$confirm" == true ]; then

		while [ "$pass" == false ]; do

			read -n 1 -p "Proceed? [Y/n] " input && echo

			case "$input" in
				
				[Yy]|"") pass=true ;;
				[Nn]) echo "Aborted."; exit ;;
				*) continue ;;

			esac

		done

	fi

	pass=false
	eval "$c"
	
	if [ "$delay" == true ]; then
		sleep 1
	fi

	((counter++))
}

basestrapManager() {
	local input=""

	while [ true ]; do
		echo -e "What to do with basestrap?\n"
		echo -e " [F]ull redefine\n [K]ernel redefine\n [M]inimal system set\n [S]how current set\n [B]ack\n"
		read -n 1 -p ">>> " input && echo

		case "$input" in

			[Ff])
				echo && read -p "Type in a new set: " basestrap_packages ;
				echo -e "\nPackages successfully updated.\n" ;;
			[Kk])
				echo && read -p "Specify a new kernel: " basestrap_kernel ;
				echo -e "\nKernel package successfully updated.\n" ;;
			[Mm])
				echo -e "\nThe minimal package set is:\n$basestrap_minimal\n" ;
				read -n 1 -p "Apply it? [Y/n] " input && echo ;

				case "$input" in
					
					[Yy]|"")
						basestrap_packages="$basestrap_minimal" ;
						echo -e "\nApplied.\n" ;
						basestrapManager ;;
					[Nn])
						echo -e "\nCanceled.\n";
						basestrapManager ;;
					*) continue ;;

				esac ;;

			[Ss]) echo -e "\nKernel:\n$basestrap_kernel\n\nPackages:\n$basestrap_packages\n" ;;
			[Bb]) grtr;;
		esac
	done
}

scenario() {
	# Paths
	
	local boot_path="/dev/sda1"
	local swap_path="/dev/sda2"
	local root_path="/dev/sda3"
	local boot_dir="/mnt/boot"

	# Setting partitions
	
	c="mkfs.btrfs -fq $root_path" && x
	
	c="mount $root_path /mnt" && x
	c="btrfs subvolume create /mnt/@" && x
	c="btrfs subvolume create /mnt/@snapshots" && x
	c="umount /mnt" && x
	c="mount -o subvol=@ $root_path /mnt" && x
	c="mkfs.ext4 -Fq $swap_path" && x
	c="mkfs.vfat $boot_path" && x
	c="mount --mkdir $boot_path $boot_dir" && x
	
	# Configuring network
	
	c="dinitctl start ntpd" && x
	
	# Updating package database
	
	c="pacman -Sy --noconfirm" && x
	
	# Installing packages
	
	c="basestrap /mnt $basestrap_kernel $basestrap_packages" && x
	
	# Generating Fstab
	
	c="fstabgen -U /mnt >> /mnt/etc/fstab" && x
	
	# Creating a directory for configuration files
	
	c="mkdir -p /mnt/configurations" && x
	
	# Copying configurations
	
	c="cp -r ./config /mnt/configurations && cp -r ./xorg /mnt/configurations && cp -r ./sddm-theme /mnt/configurations" && x

}

grtr









# SDDM

# Add SDDM theme from ./themes/where_is_my_sddm_theme to /usr/share/sddm/themes
# Add backing up /usr/share/sddm/scripts/Xsetup to turn off the second monitor
