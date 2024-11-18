#! /bin/bash
# Installed system (Final)

echo -e "\nSUDO REQUEST\n" && sudo -v && echo -e "\nPROCEEDING...\n"

# Enable services

echo -e "\nEXECUTION: dinitctl enable connmand\n"
sudo dinitctl enable connmand

echo -e "\nEXECUTION: dinitctl enable ly\n"
sudo dinitctl enable ly

# Install yay

echo -e "\nEXECUTION: cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R \$(whoami):\$(whoami) yay && cd yay && makepkg -si\n"
cd /opt && git clone https://aur.archlinux.org/yay.git && chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si

# Install soft from AUR

echo -e "\nEXECUTION: yay -s xbanish librewolf-bin intellij-idea-community-edition-jre\n"
yay -s xbanish librewolf-bin intellij-idea-community-edition-jre

# Recover user's .bashrc

echo -e "\nEXECUTION: rm /home/tozzemon/.bash_profile\n"
rm /home/tozzemon/.bash_profile

# Reboot 

echoo -e "\nINSTALLATION COMPLETED. REBOOT...\n"
sleep 2 && sudo reboot
