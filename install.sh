#! /bin/bash

echo && read -n 1 -p "One key away from the miracle... " && echo

# Set BTRFS

echo -e "\nEXECUTION: mkfs.btrfs -fq /dev/sda3\n"
sleep 0.5
mkfs.btrfs -fq /dev/sda3

echo -e "\nEXECUTION: mount /dev/sda3 /mnt\n"
sleep 0.5
mount /dev/sda3 /mnt

echo -e "\nEXECUTION: btrfs subvolume create /mnt/@\n"
sleep 0.5
btrfs subvolume create /mnt/@

echo -e "\nEXECUTION: btrfs subvolume create /mnt/@snapshots\n"
sleep 0.5
btrfs subvolume create /mnt/@snapshots

echo -e "\nEXECUTION: umount /mnt\n"
sleep 0.5
umount /mnt

echo -e "\nEXECUTION: mount -o subvol=@ /dev/sda3 /mnt\n"
sleep 0.5
mount -o subvol=@ /dev/sda3 /mnt

# Format sda1, sda2

echo -e "\nEXECUTION: mkfs.ext4 -fq /dev/sda2\n"
sleep 0.5
mkfs.ext4 -fq /dev/sda2

echo -e "\nEXECUTION: mkfs.vfat -fq /dev/sda1\n"
sleep 0.5
mkfs.vfat -fq /dev/sda1

# Mount /boot

echo -e "\nEXECUTION: mount --mkdir /dev/sda1 /mnt/boot\n"
sleep 0.5
mount --mkdir /dev/sda1 /mnt/boot

# Enable ntpd

echo -e "\nEXECUTION: dinitctl start ntpd\n"
sleep 0.5
dinitctl start ntpd

# Install packages

echo -e "\nEXECUTION: pacman -Sy --noconfirm\n"
sleep 0.5
pacman -Sy --noconfirm

echo -e "\nEXECUTION: basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit\n"
sleep 0.5
basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit

# Generate Fstab

echo -e "\nEXECUTION: fstabgen -U /mnt >> /mnt/etc/fstab\n"
sleep 0.5
fstabgen -U /mnt >> /mnt/etc/fstab

# Prepare to chroot

echo -e "\nEXECUTION: cat ./install2.sh > /mnt/root/.bashrc\n"
sleep 0.5
cat ./install2.sh > /mnt/root/.bashrc

echo -e "\nEXECUTION: cp -r ./dots /mnt/root && cp -r ./configs /mnt/root\n"
sleep 0.5
cp -r ./dots /mnt/root && cp -r ./configs /mnt/root

# chroot

echo -e "\nEXECUTION: artix-chroot /mnt\n"
sleep 0.5
artix-chroot /mnt

