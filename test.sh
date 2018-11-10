#!/bin/bash
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m" && wifi-menu
##### TEST      ######
#####  SELECT THE MIRRORS          #####
pacman --noconfirm --needed -S reflector

rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
nano /etc/pacman.d/mirrorlist  
sudo pacman -Syy
