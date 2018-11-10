#!/bin/bash
##### TEST      ######
#####  SELECT THE MIRRORS          #####
pacman --noconfirm --needed -S reflector

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

#sudo reflector -l 100 -f 50 -c BE -c NL -c FR -c DE -c GB --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new
#rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist 
#sudo cp /tmp/mirrorlist /etc/pacman.d

sudo reflector -l 100 -f 50 --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new
rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist
sudo cp /tmp/mirrorlist /etc/pacman.d


cat /etc/pacman.d/mirrorlist
sudo pacman -Syu
