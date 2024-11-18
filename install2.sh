echo -e "\nEXECUTION: ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime\n"
read
ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime

echo -e "\nEXECUTION: hwclock --systohc\n"
read
hwclock --systohc

echo -e "\nEXECUTION: echo \"en_US.UTF-8 UTF-8\" > /etc/locale.gen\n"
read
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

echo -e "\nEXECUTION: echo \"LANG=en_US.UTF-8\" > /etc/locale.conf\n"
read
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo -e "\nEXECUTION: locale-gen\n"
read
locale-gen

echo -e "\nEXECUTION: grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB\n"
read
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo -e "\nEXECUTION: grub-mkconfig -o /boot/grub/grub.cfg\n"
read
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\nEXECUTION: echo \"desktop\" > /etc/hostname\n"
read
echo "desktop" > /etc/hostname

echo -e "\nEXECUTION: echo \"root:2486\" | chpasswd\n"
read
echo "root:2486" | chpasswd

echo -e "\nEXECUTION: useradd -m -G wheel -s /bin/bash tozzemon\n"
read
useradd -m -G wheel -s /bin/bash tozzemon

echo -e "\nEXECUTION: echo \"tozzemon:2486\" | chpasswd\n"
read
echo "tozzemon:2486" | chpasswd

# echo -e "\nEXECUTION: sed -i \"/^# %wheel ALL=(ALL:ALL) ALL/s/^# //\" /etc/sudoers\n"
# read
# sed -i "/^# %wheel ALL=(ALL:ALL) ALL/s/^# //" /etc/sudoers

echo -e "\necho '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers\n"
read
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# echo -e "\nEXECUTION: cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R \$(whoami):\$(whoami) yay && cd yay && makepkg -si\n"
# read
# cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si

echo -e "\nEXECUTION: cd /root\n"
read
cd /root

echo -e "\nEXECUTION: mkdir -p ~/.config && cp -r ./dots/* /home/tozzemon/.config\n"
read
mkdir -p /home/tozzemon/.config && cp -r /root/dots/* /home/tozzemon/.config

echo -e "\nEXECUTION: pacman -S --noconfirm nvidia-open nvidia-settings\n"
read
pacman -S --noconfirm nvidia-open nvidia-settings

# Delete it later
echo "\nSTOPPP\n" && read

echo -e "\nEXECUTION: sed -i 's/\\<kms\\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf\n"
read
sed -i 's/\<kms\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf

echo -e "\nEXECUTION: mkdir -p /etc/X11 && cp ./configs/xorg.conf /etc/X11/\n"
read
mkdir -p /etc/X11 && cp /root/configs/xorg.conf /etc/X11/

# echo -e "\nEXECUTION: yay -S xbanish librewolf-bin intellij-idea-community-edition-jre\n"
# read
# yay -S xbanish librewolf-bin intellij-idea-community-edition-jre

echo -e "\nEXECUTION: dinitctl enable connmand\n"
read
dinitctl enable connmand

echo -e "\nEXECUTION: dinitctl enable ly\n"
read
dinitctl enable ly

echo -e "\nEXECUTION: rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots\n"
read
rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots

echo -e "\nEXECUTION: exit\n"
read
exit
