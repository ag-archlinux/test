#!/bin/bash
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m" && wifi-menu
##### TEST      ######
#####  SELECT THE MIRRORS          #####
pacman --noconfirm --needed -S reflector

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

sudo reflector -l 100 -f 50 -c SK -c CZ -c PL -c DE -c GB --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new
rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist 
sudo cp /tmp/mirrorlist /etc/pacman.d/mirrorlist

cat /etc/pacman.d/mirrorlist
sudo pacman -Syu
