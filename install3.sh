#! /bin/bash
# Installed system (Final)

echo -e "\nSUDO REQUEST\n" && sudo -v && echo -e "\nPROCEEDING...\n"

# Enable services

echo -e "\nEXECUTION: dinitctl enable connmand\n"
sudo dinitctl enable connmand

echo -e "\nEXECUTION: sudo ln -s /etc/dinit.d/ly /etc/dinit.d/boot.d/ly && sudo dinitctl enable ly\n"
sudo ln -s /etc/dinit.d/ly /etc/dinit.d/boot.d/ly && sudo dinitctl enable ly # Maybe `connman` needs the same approach as `dinitctl`

# Wait for the Internet connection

while ! ping -c 1 -W 1 archlinux.org &>/dev/null; do
    echo "Waiting for network..."
    sleep 2
done

# Install yay

echo -e "\nEXECUTION: cd /opt && sudo git clone https://aur.archlinux.org/yay.git && sudo chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si\n"
cd /opt && sudo git clone https://aur.archlinux.org/yay.git && sudo chown -R $(whoami):$(whoami) yay && cd yay && makepkg -si

# echo "cd /opt"
# cd /opt
# echo "git clone https://aur.archlinux.org/yay.git"
# sudo git clone https://aur.archlinux.org/yay.git
# echo "sudo chown -R \$(whoami):\$(whoami) yay"
# sudo chown -R \$(whoami):\$(whoami) yay 
# echo "cd yay"
# cd yay
# echo "makepkg -si"
# makepkg -si

# Install soft from AUR

echo -e "\nEXECUTION: yay -S xbanish librewolf-bin intellij-idea-community-edition-jre\n"
yay -S xbanish librewolf-bin intellij-idea-community-edition-jre

# Remove user's .bash_profile

echo -e "\nEXECUTION: sudo rm /home/tozzemon/.bash_profile\n"
sudo rm /home/tozzemon/.bash_profile

# Reboot 
echo -e "\nINSTALLATION COMPLETED. REBOOT...\n"
sleep 2 && sudo reboot
