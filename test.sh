#!/bin/bash
##### TEST      ######
#####  SELECT THE MIRRORS          #####
pacman --noconfirm --needed -S reflector rsync
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
read -p "Press any key..."
sudo pacman -Syu
dialog --defaultno --title "=>" --yesno "Reboot computer?"  5 30 && reboot
dialog --defaultno --title "=>" --yesno "Return to chroot environment?"  6 30 && arch-chroot /mnt
