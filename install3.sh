echo -e "\nEXECUTION: dinitctl enable connmand\n"
dinitctl enable connmand

echo -e "\nEXECUTION: dinitctl enable ly\n"
dinitctl enable ly

# Remove .bashrc, configs, and dot from the

echo -e "\nEXECUTION: rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots\n"
rm /root/.bashrc && rm -rf /root/configs && rm -rf /root/dots

