#!/bin/bash
##### TEST      ######
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || (echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m";wifi-menu;exit)
#####  SELECT THE MIRRORS          #####
question_yesno "Reboot (y/n)?" reboot
#pacman --noconfirm --needed -S reflector
#nano /etc/pacman.d/mirrorlist  
#sudo pacman -Syy
question_yesno(){
NEXT=0
while[$NEXT != 1] do
  read -p "$1" ANSWER
  case "$ANSWER" in 
    [yY][eE][sS]|[yY]) 
      $2
      NEXT=1     
      ;;
    [nN][oO]|[nN])
      $3
      NEXT=1
      ;;
  esac
done
}
