#!/bin/bash
set -e
##### TEST      ######

#####  SELECT THE MIRRORS          #####

sudo pacman -S --noconfirm --needed reflector

sudo reflector -l 100 -f 50 -c BE -c NL -c FR -c DE -c GB --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new && rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist && sudo cp /tmp/mirrorlist /etc/pacman.d

cat /etc/pacman.d/mirrorlist

sudo pacman -Syu





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
