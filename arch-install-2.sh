#! /bin/bash

# In-system part

# Setting time

echo -e "\nln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime\n"
sleep 0.5
ln -sf /usr/share/zoneinfo/Asia/Bishkek /etc/localtime

echo -e "\nhwclock --systohc\n"
sleep 0.5
hwclock --systohc

# Setting locales

echo -e "\necho 'en_US.UTF-8 UTF-8' > /etc/locale.gen\n"
sleep 0.5
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

echo -e "\necho 'LANG=en_US.UTF-8' > /etc/locale.conf\n"
sleep 0.5
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

echo -e "\nlocale-gen\n"
sleep 0.5
locale-gen

# Enabling NetworkManager

echo -e "\ndinitctl enable networkmanager\n"
sleep 0.5
dinitctl enable networkmanager

# Configuring Boot

echo -e "\nos-prober\n"
sleep 0.5
os-prober

echo -e "\ngrub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB\n"
sleep 0.5
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo -e "\ngrub-mkconfig -o /boot/grub/grub.cfg\n"
sleep 0.5
grub-mkconfig -o /boot/grub/grub.cfg

# Configuring users

echo -e "\necho "desktop" > /etc/hostname\n"
sleep 0.5
echo "desktop" > /etc/hostname

echo -e "\necho "root:2486" | chpasswd\n"
sleep 0.5
echo "root:2486" | chpasswd

echo -e "\nuseradd -m -G wheel -s /bin/bash tozzemon\n"
sleep 0.5
useradd -m -G wheel -s /bin/bash tozzemon

echo -e "\necho "tozzemon:2486" | chpasswd\n"
sleep 0.5
echo "tozzemon:2486" | chpasswd

echo -e "\nsed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers\n"
sleep 0.5
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

# Enabling ly

echo -e "\ndinitctl enable ly\n"
sleep 0.5
dinitctl enable ly

# Installing yay

echo -e "\ncd /opt && git clone https://aur.archlinux.org/yay.git && chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si\n"
sleep 0.5
cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si

# Installing additionals from AUR

echo -e "\nyay -S --noconfirm librewolf-bin intellij-idea-community-edition-jre xbanish\n"
sleep 0.5
yay -S --noconfirm librewolf-bin intellij-idea-community-edition-jre xbanish

# Recovering dots

echo -e "\nmdkir -p ~/.config && cp -r ./dots/* $USER/.config\n"
sleep 0.5
mdkir -p ~/.config && cp -r ./dots/* /home/tozzemon/.config

# Installing NVIDIA drivers

echo -e "\npacman -S nvidia-open nvidia-settings\n"
sleep 0.5
pacman -S --noconfirm nvidia-open nvidia-settings

echo
echo "sed -i 's/\<kms\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf"
echo
sleep 0.5
sed -i 's/\<kms\>//g; s/  / /g; s/ ( /(/; s/ ) /)/' /etc/mkinitcpio.conf

# Recovering xorg.conf

echo -e "\nmkdir -p /etc/X11 && cp ./configs/xorg.conf /etc/X11/\n"
sleep 0.5
mkdir -p /etc/X11 && cp ./configs/xorg.conf /etc/X11/

# Removing .bashrc

echo -e "\nrm /root/.bashrc\n"
sleep 0.5
rm /root/.bashrc

# Rebooting

echo -e "\nreboot\n"
sleep 0.5
reboot
