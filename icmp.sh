#!/bin/bash

# User must run the script as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root"
	exit 1
fi

distro=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')

if [[ $distro != "ubuntu" ]]; then
	echo "distro not supported please use ubuntu"
	exit 1
fi

echo "+--------------------------------------------------+"
echo "|                         B Y                      |"
echo "|                  D E V S P A C E X               |"
echo "|            ---------------------------           |"
echo "|                      Main Menu                   |"
echo "+--------------------------------------------------+"
echo " Select one of the following options"
echo "  1.  Server tunnel (ipv4)"
echo "  2.  Remove the tunnel"
echo "  3.  Exit"
read -r -p "Please select one [1-2-3-4-5-6]: " -e OPTION
case $OPTION in
1)
sudo iptables -A INPUT -p icmp -j DROP
    echo "Saving iptables rules..."
  ;;
  2)
iptables -t nat -L --line-numbers
  ;;
    3)
    exit
    echo "Your exit now ."
      ;;
esac
