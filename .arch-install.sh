#! /bin/bash

# Live-CD part

read -n 1 -p "One key away from the miracle: " && echo

# Live environment configuration

echo -e "\npacman -Sy --noconfirm\n"
sleep 0.5
pacman -Sy --noconfirm

echo -e "\npacman-key --init && pacman-key --populate archlinux && pacman -S chrony --noconfirm\n"
sleep 0.5
pacman-key --init && pacman-key --populate archlinux && pacman -S chrony --noconfirm

# Messing with partitons

echo -e "\nmkfs.btrfs -f /dev/sda3\n"
sleep 0.5
mkfs.btrfs -f /dev/sda3

echo -e "\nmount /dev/sda3 /mnt\n"
sleep 0.5
mount /dev/sda3 /mnt

echo -e "\nbtrfs subvolume create /mnt/@\n"
sleep 0.5
btrfs subvolume create /mnt/@

echo -e "\numount /mnt\n"
sleep 0.5
umount /mnt

echo -e "\nmount -o subvol=@ /dev/sda3 /mnt\n"
sleep 0.5
mount -o subvol=@ /dev/sda3 /mnt

echo -e "\nmkfs.vfat /dev/sda1 && mkswap /dev/sda2\n"
sleep 0.5
mkfs.vfat /dev/sda1 && mkswap /dev/sda2

echo -e "\nmount /dev/sda3 /mnt && swapon /dev/sda2 && mount --mkdir /dev/sda1 /mnt/boot\n"
sleep 0.5
mount /dev/sda3 /mnt && swapon /dev/sda2 && mount --mkdir /dev/sda1 /mnt/boot

# Packages installation

echo -e "\npacstrap -K /mnt alacritty alsa-utils arp-scan base base-devel bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs cmake dunst git grub gvim htop ly linux linux-firmware lxappearance man neofetch neovim networkmanager ntfs-3g obsidian opensh os-prober pavucontrol qt5ct rofi sudo sxhkd tar unclutter unzip viewnior vifm wget xbanish xorg-server xorg-xinit zip\n"
sleep 0.5
pacstrap -K /mnt alacritty alsa-utils arp-scan base base-devel bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs cmake dunst git grub gvim htop ly linux linux-firmware lxappearance man neofetch neovim networkmanager ntfs-3g obsidian opensh os-prober pavucontrol qt5ct rofi sudo sxhkd tar unclutter unzip viewnior vifm wget xbanish xorg-server xorg-xinit zip

# Generating Fstab

echo -e "\ngenfstab -U /mnt >> /mnt/etc/fstab\n"
sleep 0.5
genfstab -U /mnt >> /mnt/etc/fstab

# Writing down the path to the script's second part in .bashrc

echo -e "\ncat ./arch-install-2.sh > /mnt/root/.bashrc\n"
sleep 0.5
cat ./arch-install-2.sh > /mnt/root/.bashrc

# Making chroot

echo -e "\narch-chroot /mnt\n"
sleep 0.5
arch-chroot /mnt
