#!/bin/bash

# User must run the script as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root"
	exit 1
fi

distro=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
thisServerIP=$(ip a s|sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
networkInterfaceName=$(ip -o -4 route show to default | awk '{print $5}')

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
echo "  3.  View the Forwarded IP (ipv4)"
echo "  4.  Server tunnel (ipv6)"
echo "  5.  View the Forwarded IP (ipv6)"
echo "  6.  Exit"
read -r -p "Please select one [1-2-3]: " -e OPTION
case $OPTION in
1)
sudo iptables -t nat -F
    echo "Your forward port was removed"
  ;;
2)
sudo iptables -A INPUT -p icmp -j DROP
echo "+--------------------------------------------------+"
echo "|                        B Y                       |"
echo "|                 D E V S P A C E X                |"
echo "|           ----------------------------           |"
echo "|                 <Ping is closed>                 |"
echo "+--------------------------------------------------+"
exit
  ;;
    3)
    exit
    echo "Your exit now ."
      ;;
esac
