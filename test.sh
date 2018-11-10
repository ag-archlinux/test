#!/bin/bash
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m" && wifi-menu
##### TEST      ######
#####  SELECT THE MIRRORS          #####
pacman --noconfirm --needed -S reflector

#sudo reflector -l 100 -f 50 -c BE -c NL -c FR -c DE -c GB --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new && rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist && sudo cp /tmp/mirrorlist /etc/pacman.d
#reflector --protocol --lastest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo reflector --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
sudo pacman -Syy
