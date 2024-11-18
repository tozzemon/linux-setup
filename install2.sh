#! /bin/bash
# Installed system

# Set timezone

echo -e "\nEXECUTION: ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime\n"
ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime

echo -e "\nEXECUTION: hwclock --systohc\n"
hwclock --systohc

# Set locales

echo -e "\nEXECUTION: echo \"en_US.UTF-8 UTF-8\" > /etc/locale.gen\n"
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

echo -e "\nEXECUTION: echo \"LANG=en_US.UTF-8\" > /etc/locale.conf\n"
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo -e "\nEXECUTION: locale-gen\n"
locale-gen

# Install GRUB

echo -e "\nEXECUTION: grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB\n"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo -e "\nEXECUTION: grub-mkconfig -o /boot/grub/grub.cfg\n"
grub-mkconfig -o /boot/grub/grub.cfg

# Set users

echo -e "\nEXECUTION: echo \"desktop\" > /etc/hostname\n"
echo "desktop" > /etc/hostname

echo -e "\nEXECUTION: echo \"root:2486\" | chpasswd\n"
echo "root:2486" | chpasswd

echo -e "\nEXECUTION: useradd -m -G wheel -s /bin/bash tozzemon\n"
useradd -m -G wheel -s /bin/bash tozzemon

echo -e "\nEXECUTION: echo \"tozzemon:2486\" | chpasswd\n"
echo "tozzemon:2486" | chpasswd

echo -e "\necho '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers\n"
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Copy dots and configs to /home/tozzemon

echo -e "\nEXECUTION: cd /root\n"
cd /root

echo -e "\nEXECUTION: mkdir -p ~/.config && cp -r ./dots/* /home/tozzemon/.config\n"
mkdir -p /home/tozzemon/.config && cp -r /root/dots/* /home/tozzemon/.config

# Install NVIDIA drivers

echo -e "\nEXECUTION: pacman -S --noconfirm nvidia-open nvidia-settings\n"
pacman -S --noconfirm nvidia-open nvidia-settings

echo -e "\nEXECUTION: sed -i 's/\\<kms\\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf\n"
sed -i 's/\<kms\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf

echo -e "\nEXECUTION: mkdir -p /etc/X11 && cp ./configs/xorg.conf /etc/X11/\n"
mkdir -p /etc/X11 && cp /root/configs/xorg.conf /etc/X11/

# Remove .bashrc, configs, and dots from /root in the installed system

echo -e "\nEXECUTION: rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots\n"
rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots

# Temporary rename user's .bashrc in the installed system

echo -e "\nmv /home/tozzemon/.bashrc /home/tozzemon/.bashrcBACKUP\n"
mv /home/tozzemon/.bashrc /home/tozzemon/.bashrcBACKUP

# Write install3.sh to /home/tozzemon/.bashrc in the installed system

echo -e "\nEXECUTION: cat ./install3.sh > /home/tozzemon/.bashrc\n"
cat ./install3.sh > /home/tozzemon/.bashrc

# Exit installed system

echo -e "\nEXECUTION: exit\n"
exit
