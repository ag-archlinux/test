#!/bin/bash
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m" 
ping -q -w1 -c1 google.com &>/dev/null || wifi-menu
ping -q -w1 -c1 google.com &>/dev/null || kill -s SIGINT <PID>
##### TEST      ######
read -p "Press any key..."
#####  SELECT THE MIRRORS          #####
NEXT=0
while[$NEXT=1]
do
read -p "Reboot (y/n)?" ANSWER
case "$ANSWER" in 
  y|Y ) reboot
        $NEXT=1     
  ;;
  n|N ) $NEXT=1
  ;;
esac
done

#while [ -z "$ROOT_PASSWORD" ]
#do
#    read -p "Continue (y/n)?" choice
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
pacman --noconfirm --needed -S reflector

rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
nano /etc/pacman.d/mirrorlist  
sudo pacman -Syy
