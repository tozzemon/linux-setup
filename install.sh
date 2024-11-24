#! /bin/bash



# ---------------------------------------
# FLAGS
# ---------------------------------------



# `confirm` (type: bool, default: false) - toggles confirmation message before each command execution;
# `delay` (type: bool, default: false) - adds one second delay after each command.



# ---------------------------------------
# GLOBAL VARIABLES
# ---------------------------------------



# Store numbers of the current stage and command for more clarity in the case of debugging
command_number=1
stage_number=1

# Stores commands for execution and has to be used in pair with the `x()` method in the `scenarion()`
c=""

# Just a fancy thing to have
prfx="[Script]"

# Default kernel (the script supposes separately kernel specifying)
basestrap_default_kernel="linux" 

# Default package set
basestrap_default_packages="linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit"

# Minimal package set
basestrap_minimal_packages="linux-firmware base dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit bash-completion grub gvim neofetch neovim ntfs-3g openssh wget"

# The current kernel to install
basestrap_kernel="$basestrap_default_kernel"

# The current set of packages to install
basestrap_packages="$basestrap_default_packages"



# ---------------------------------------
# METHODS
# ---------------------------------------



# Greeter

grtr() {
	echo -e "\n-------------------------------------------------"
	echo -e "Artix Dinit Dummy Installation Script by tozzemon"
	echo -e "-------------------------------------------------"
	menu
}

# Main menu

menu() {
	local input=""
	echo -e "\nInstallation options\n"
	echo -e " [S]tart immediately\n [B]asestrap adjustment\n [U]pdate the script\n [H]Help\n [Q]uit"
	
	while [ true ]; do

		echo && read -n 1 -p ">>> " input && echo
		
		case "$input" in

			[Ss]) scenario ;;
			[Bb]) basestrapManager ;;
			[Uu]) update ;;
			[Qq]) exit ;;
			*) echo -e "\n ! There's no such option..." ;;

		esac

	done
}

# Command executor

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

# Basestrap command's manager

basestrapManager() {
	local input=""

	while [ true ]; do
		echo -e "\nWhat to do with basestrap?\n"
		echo -e " [F]ull redefine\n [K]ernel redefine\n [M]inimal system set\n [D]efault system set\n [S]how current set\n [B]ack"
		echo && read -n 1 -p ">>> " input && echo 

		case "$input" in

			[Ff])
				echo && read -p "Type in a kernel to use (specifies separately): " basestrap_kernel ;
				echo && read -p "Type in other packages names: " basestrap_packages ;
				echo -e "\nPackages successfully updated." ;;
			[Kk])
				echo && read -p "Specify a new kernel: " basestrap_kernel ;
				echo -e "\nKernel package successfully updated." ;;
			[Mm])
				echo -e "\nThe minimal package set is:\n\nKernel: $basestrap_default_kernel\n\nPackages: $basestrap_minimal_packages\n" ;
				read -n 1 -p "Apply it? [Y/n] " input && echo ;

				case "$input" in
					
					[Yy]|"")
						basestrap_kernel="$basestrap_default_kernel" ;
						basestrap_packages="$basestrap_minimal_packages" ;
						echo -e "\nApplied." ;
						basestrapManager ;;
					[Nn])
						echo -e "\nCanceled.";
						basestrapManager ;;
					*) continue ;;

				esac ;;
			[Dd]) 	
				echo -e "\nThe default package set is:\n\nKernel: $basestrap_default_kernel\n\nPackages: $basestrap_default_packages\n" ;
				read -n 1 -p "Apply it? [Y/n] " input && echo ;

				case "$input" in
					
					[Yy]|"")
						basestrap_kernel="$basestrap_default_kernel" ;
						basestrap_packages="$basestrap_default_packages" ;
						echo -e "\nApplied." ;
						basestrapManager ;;
					[Nn])
						echo -e "\nCanceled.";
						basestrapManager ;;
					*) continue ;;

				esac ;;
			[Ss]) 
				echo -e "\nThe current package set is:\n\nKernel:\n$basestrap_kernel\n\nPackages:\n$basestrap_packages" ;;
			[Bb]) menu;;

		esac

	done
}

# The script's updator, tries to suck up a new version from Github

update() {
	local input=""

	echo && read -n 1 -p "It might overwrite your custom setting. Proceed? [y/N] " input && echo

	while [ true ]; do

		case "$input" in
			
			[Yy])
				echo -e "\nI wish to have the same courage as yours...\n" ;
				local script_path=$(pwd) ;
				cd .. && rm -rf $script_path ;
				git clone https://github.com/tozzemon/linux-setup.git ;
				echo -e "\nRelaunching the script...\n" ;
				cd $script_path && exec ./install.sh ;;
			[Nn]|"")
				echo -e "\nCanceled.";
				menu ;;
			*) continue ;;

		esac 

	done
}

# Installation scenario

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
	
	c="cp -r ./configurations/dots /mnt/configurations && cp -r ./configurations/xorg /mnt/configurations && cp -r ./configurations/themes /mnt/configurations" && x

	# Overriding `/mnt/root/.bashrc` content with the script's instance

	c="cat ./install.sh > /mnt/root/.bashrc" && x

	# Updating the stage number

	((stage_number++))

	# Saving temporary settings
	
	c="cat <<EOF > ./var.tmp
stage_number="$stage_number"
basestrap_kernel="$basestrap_kernel"
basestrap_packages="$basestrap_packages"
EOF" && x

	# Copying temporary settings to `/mnt/root`
	
	c="cp ./var.tmp /mnt/root" && x

	# Chroot into the installed system
	
	c="artix-chroot /mnt" && x

	# Reboot
	
	c="reboot" && x

}

grtr









# SDDM

# Add SDDM theme from ./themes/where_is_my_sddm_theme to /usr/share/sddm/themes
# Add backing up /usr/share/sddm/scripts/Xsetup to turn off the second monitor
