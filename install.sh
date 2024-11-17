#! /bin/bash

read -n 1 -p "One key away from the miracle: " && echo

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

echo -e "\nEXECUTION: mkfs.ext4 -q /dev/sda2\n"
sleep 0.5
mkfs.ext4 -q /dev/sda2

echo -e "\nEXECUTION: mkfs.vfat -q /dev/sda1\n"
sleep 0.5
mkfs.vfat -q /dev/sda1

echo -e "\nEXECUTION: mount --mkdir /dev/sda1 /mnt/boot\n"
sleep 0.5
mount --mkdir /dev/sda1 /mnt/boot

echo -e "\nEXECUTION: dinitctl start ntpd\n"
sleep 0.5
dinitctl start ntpd

echo -e "\nEXECUTION: pacman -Sy --noconfirm\n"
sleep 0.5
pacman -Sy --noconfirm

echo -e "\nEXECUTION: basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit\n"
sleep 0.5
basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit

echo -e "\nEXECUTION: fstabgen -U /mnt >> /mnt/etc/fstab\n"
sleep 0.5
fstabgen -U /mnt >> /mnt/etc/fstab

echo -e "\nEXECUTION: cat ./install2.sh > /mnt/root/.bashrc\n"
sleep 0.5
cat ./install2 > /mnt/root/.bashrc

cp -r ./dots /mnt/root && cp -r ./configs /mnt/root

echo -e "\nEXECUTION: artix-chroot /mnt\n"
sleep 0.5
artix-chroot /mnt

