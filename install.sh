#! /bin/bash

echo -e "\nread -n 1 -p \"One key away from the miracle: \" && echo\n"
sleep 0.5
read -n 1 -p "One key away from the miracle: " && echo

echo -e "\nmkfs.btrfs -f /dev/sda3\n"
sleep 0.5
mkfs.btrfs -f /dev/sda3

echo -e "\nmount /dev/sda3 /mnt\n"
sleep 0.5
mount /dev/sda3 /mnt

echo -e "\nbtrfs subvolume create /mnt/@\n"
sleep 0.5
btrfs subvolume create /mnt/@

echo -e "\nbtrfs subvolume create /mnt/@snapshots\n"
sleep 0.5
btrfs subvolume create /mnt/@snapshots

echo -e "\numount /mnt\n"
sleep 0.5
umount /mnt

echo -e "\nmount -o subvol=@ /dev/sda3 /mnt\n"
sleep 0.5
mount -o subvol=@ /dev/sda3 /mnt

echo -e "\nmkfs.ext4 /dev/sda2\n"
sleep 0.5
mkfs.ext4 /dev/sda2

echo -e "\nmkfs.vfat /dev/sda1\n"
sleep 0.5
mkfs.vfat /dev/sda1

echo -e "\nmount --mkdir /dev/sda2 /mnt/boot\n"
sleep 0.5
mount --mkdir /dev/sda2 /mnt/boot

echo -e "\ndinitctl start ntpd\n"
sleep 0.5
dinitctl start ntpd

echo -e "\npacman -Sy --noconfirm\n"
sleep 0.5
pacman -Sy --noconfirm

echo -e "\nbasestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit\n"
sleep 0.5
basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit

echo -e "\nfstabgen -U /mnt >> /mnt/etc/fstab\n"
sleep 0.5
fstabgen -U /mnt >> /mnt/etc/fstab

echo -e "\ncat ./install2 > /mnt/root/.bashrc\n"
sleep 0.5
cat ./install2 > /mnt/root/.bashrc

echo -e "\nartix-chroot /mnt\n"
sleep 0.5
artix-chroot /mnt

