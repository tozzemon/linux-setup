#! /bin/bash
# Live-CD

ROOT_PATH=""
BOOT_PATH=""
SWAP_PATH=""
TIMEZONE=""
LOCALE=""
ROOT_PASS=""
USERNAME=""
USER_PASS=""

read -n 1 -p "'Enter' to proceed with defaults\n[C]onfigure installation\n[U]pdate\n[Q]uit"
if [[ "$INPUT" == "" ]]; then
	default-installation
elif [[ "$INPUT" == "C" || "$INPUT" == "c" ]]; then
	configure-installation
elif [[ "$INPUT" == "U" || "$INPUT" == "u" ]]; then
	update
elif [[ "$INPUT" == "Q" || "$INPUT" == "q" ]]; then
	quit
else
	echo -e "\n! No such option\n"
fi

echo && read -n 1 -p "One key away from the miracle... " && echo

# Set BTRFS

echo -e "\nEXECUTION: mkfs.btrfs -fq /dev/sda3\n"
mkfs.btrfs -fq /dev/sda3

echo -e "\nEXECUTION: mount /dev/sda3 /mnt\n"
mount /dev/sda3 /mnt

echo -e "\nEXECUTION: btrfs subvolume create /mnt/@\n"
btrfs subvolume create /mnt/@

echo -e "\nEXECUTION: btrfs subvolume create /mnt/@snapshots\n"
btrfs subvolume create /mnt/@snapshots

echo -e "\nEXECUTION: umount /mnt\n"
umount /mnt

echo -e "\nEXECUTION: mount -o subvol=@ /dev/sda3 /mnt\n"
mount -o subvol=@ /dev/sda3 /mnt

# Format sda1, sda2

echo -e "\nEXECUTION: mkfs.ext4 -Fq /dev/sda2\n"
mkfs.ext4 -Fq /dev/sda2

echo -e "\nEXECUTION: mkfs.vfat /dev/sda1\n"
mkfs.vfat /dev/sda1

# Mount /boot

echo -e "\nEXECUTION: mount --mkdir /dev/sda1 /mnt/boot\n"
mount --mkdir /dev/sda1 /mnt/boot

# Enable ntpd

echo -e "\nEXECUTION: dinitctl start ntpd\n"
dinitctl start ntpd

# Install packages

echo -e "\nEXECUTION: pacman -Sy --noconfirm\n"
pacman -Sy --noconfirm

echo -e "\nEXECUTION: basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit\n"
basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit

# Generate Fstab

echo -e "\nEXECUTION: fstabgen -U /mnt >> /mnt/etc/fstab\n"
fstabgen -U /mnt >> /mnt/etc/fstab

# Add install2.sh to .bashrc in the installed system

echo -e "\nEXECUTION: cat ./install2.sh > /mnt/root/.bashrc\n"
cat ./install2.sh > /mnt/root/.bashrc

# Add dots and configs to /root in the installed system

echo -e "\nEXECUTION: cp -r ./dots /mnt/root && cp -r ./configs /mnt/root\n"
cp -r ./dots /mnt/root && cp -r ./configs /mnt/root

# Write install3.sh to /home/tozzemon/.bash_profile in the installed system

echo -e "\nEXECUTION: mkdir -p /mnt/home/tozzemon && cat ./install3.sh > /mnt/home/tozzemon/.bash_profile\n"
mkdir -p /mnt/home/tozzemon && cat ./install3.sh > /mnt/home/tozzemon/.bash_profile

# Chroot

echo -e "\nEXECUTION: artix-chroot /mnt\n"
artix-chroot /mnt

# Reboot

echo -e "\nEXECUTION: reboot\n"
reboot
