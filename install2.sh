echo -e "\nEXECUTION: ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime\n"
sleep 0.5
ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime

echo -e "\nEXECUTION: hwclock --systohc\n"
sleep 0.5
hwclock --systohc

echo -e "\nEXECUTION: echo \"en_US.UTF-8 UTF-8\" > /etc/locale.gen\n"
sleep 0.5
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

echo -e "\nEXECUTION: echo \"LANG=en_US.UTF-8\" > /etc/locale.conf\n"
sleep 0.5
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo -e "\nEXECUTION: locale-gen\n"
sleep 0.5
locale-gen

echo -e "\nEXECUTION: grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB\n"
sleep 0.5
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo -e "\nEXECUTION: grub-mkconfig -o /boot/grub/grub.cfg\n"
sleep 0.5
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "\nEXECUTION: echo \"desktop\" > /etc/hostname\n"
sleep 0.5
echo "desktop" > /etc/hostname

echo -e "\nEXECUTION: echo \"root:2486\" | chpasswd\n"
sleep 0.5
echo "root:2486" | chpasswd

echo -e "\nEXECUTION: useradd -m -G wheel -s /bin/bash tozzemon\n"
sleep 0.5
useradd -m -G wheel -s /bin/bash tozzemon

echo -e "\nEXECUTION: echo \"tozzemon:2486\" | chpasswd\n"
sleep 0.5
echo "tozzemon:2486" | chpasswd

echo -e "\nEXECUTION: sed -i \"/^# %wheel ALL=(ALL) ALL/s/^# //\" /etc/sudoers\n"
sleep 0.5
sed -i "/^# %wheel ALL=(ALL) ALL/s/^# //" /etc/sudoers

# echo -e "\nEXECUTION: cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R \$(whoami):\$(whoami) yay && cd yay && makepkg -si\n"
# sleep 0.5
# cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si

echo -e "\nEXECUTION: mkdir -p ~/.config && cp -r ./dots/* /home/tozzemon/.config\n"
sleep 0.5
mkdir -p ~/.config && cp -r /root/dots/* /home/tozzemon/.config

echo -e "\nEXECUTION: pacman -S --noconfirm nvidia-open nvidia-settings\n"
sleep 0.5
pacman -S --noconfirm nvidia-open nvidia-settings

echo -e "\nEXECUTION: sed -i 's/\\<kms\\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf\n"
sleep 0.5
sed -i 's/\<kms\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf

echo -e "\nEXECUTION: mkdir -p /etc/X11 && cp ./configs/xorg.conf /etc/X11/\n"
sleep 0.5
mkdir -p /etc/X11 && cp /root/configs/xorg.conf /etc/X11/

# echo -e "\nEXECUTION: yay -S xbanish librewolf-bin intellij-idea-community-edition-jre\n"
# sleep 0.5
# yay -S xbanish librewolf-bin intellij-idea-community-edition-jre

echo -e "\nEXECUTION: dinitctl enable connmand\n"
sleep 0.5
dinitctl enable connmand

echo -e "\nEXECUTION: dinitctl enable ly\n"
sleep 0.5
dinitctl enable ly

echo -e "\nEXECUTION: rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots\n"
sleep 0.5
rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots

echo -e "\nEXECUTION: exit\n"
sleep 0.5
exit
