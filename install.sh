read -n 1 -p "One key away from the miracle: " && echo
mkfs.btrfs -f /dev/sda3
mount /dev/sda3 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o subvol=@ /dev/sda3 /mnt
mkfs.ext4 /dev/sda2
mkfs.vfat /dev/sda1
mount --mkdir /dev/sda2 /mnt/boot
dinitctl start ntpd
pacman -Sy --noconfirm
basestrap /mnt linux linux-firmware base base-devel dinit elogind-dinit os-prober efibootmgr connman-dinit xorg xorg-xinit ly-dinit git alacritty bash-completion beep breeze-gtk breeze5 bspwm btrfs-progs dunst grub gvim lxappearance neofetch neovim ntfs-3g openssh qt5ct rofi sxhkd unclutter viewnior vifm wget xorg xorg-xinit 
fstabgen -U /mnt >> /mnt/etc/fstab
cat ./install2 > /mnt/root/.bashrc
artix-chroot /mnt
