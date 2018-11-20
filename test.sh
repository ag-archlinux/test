#!/bin/bash
set -e
#####  CHECKING CONNECTION                     #####  
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || (echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m";wifi-menu;exit;)
#####  INPUTS                                  #####
read -p "What is your RAM (G)? " RAM_IN
RAM=$(bc <<< "$RAM_IN * 1.5")
read -p "What is your ROOT_SPACE (G)? " ROOT_SPACE
read -p "Enter your hostname: " COMPUTER_NAME
#####  SET THE KEYBOARD LAYOUT     #####
#####  VERIFY THE BOOT MODE        #####
if [-d "/sys/firmware/efi/efivars"]; then
    echo "UEFI"
    FORMATBOOT = $("mkfs.fat -F32 /dev/sda1")
else
    echo "BIOS"
    FORMATBOOT = $("mkfs.ext4 /dev/sda1")
fi
#####  UPDATE THE SYSTEM CLOCK     #####
timedatectl set-ntp true
#####  PARTITION THE DISK          #####
cat<<EOF | fdisk /dev/sda
o
n
p


+500M
n
p


+${RAM}G
n
p


+${ROOT_SPACE}G
n
p



w
EOF
#####  FORMAT THE PARTITIONS       #####
yes | ${FORMATBOOT} 
yes | mkfs.ext4 /dev/sda3
yes | mkfs.ext4 /dev/sda4
mkswap /dev/sda2
swapon /dev/sda2
mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir -p /mnt/home
mount /dev/sda4 /mnt/home
lsblk
read -p "Press any key..."
#####  SELECT THE MIRRORS          #####
#####  cp -vf /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
#####  pacman -Syy
#####  pacman --noconfirm --needed -S python glibc rsync curl
#####  pacman --noconfirm --needed -S reflector
#####  reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist
#####  pacman -Syy
#####  nano /etc/pacman.d/mirrorlist
#####  read -p "Press any key..."
#####  INSTAL THE BASE PACKAGES    #####
pacstrap /mnt base base-devel
#####  FSTAB                       #####
genfstab -U /mnt >> /mnt/etc/fstab
#####  MY FUNCTIONS                #####
curl -O https://raw.githubusercontent.com/ag-archlinux/ag-archlinux/master/functions.sh && bash functions.sh
#####  CHROOT                      #####
curl https://raw.githubusercontent.com/ag-archlinux/ag-archlinux/master/chroot.sh > /mnt/chroot.sh 
arch-chroot /mnt bash chroot.sh
rm /mnt/chroot.sh
#####  UMOUNT                      #####
umount -R /mnt
#####  REBOOT                      #####
question_yesno "Reboot computer (y/n)? " "reboot" ""
#####  GO TO CHROOT ENVIRONMENT
question_yesno "Return to chroot environment (y/n)? " "arch-chroot /mnt" ""
echo "####################     INSTALLATION FINISHED     ####################"
#while [ -z "$ROOT_PASSWORD" ]
#do
#    echo "Please enter a root password:"
#    read -s PASSWORD1
#    echo "Please re-enter the root password to confirm:"
#    read -s PASSWORD2
#
#    if [ "$PASSWORD1" = "$PASSWORD2" ]; then
#        ROOT_PASSWORD=$PASSWORD1
#    else
#        color1='\033[0;36m'
#        color2='\033[0;0m'
#        echo ""
#        echo -e "${color1}Passwords did not match!${color2}"
#    fi
#done
