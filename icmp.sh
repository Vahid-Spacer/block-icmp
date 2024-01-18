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
echo "|                        B Y                       |"
echo "|                 D E V S P A C E X                |"
echo "|           ----------------------------           |"
echo "|                     Main Menu                    |"
echo "+--------------------------------------------------+"
echo " Select one of the following options"
echo "  1.  Block ICMP"
echo "  2.  Remove Block ICMP"
echo "  3.  Exit"
read -r -p "Please select one [1-2-3]: " -e OPTION
case $OPTION in

    1)
        
        sudo iptables -A INPUT -p icmp -j DROP

        # Save iptables rules
        echo -e "${GREEN}Saving iptables rules...${RESET}"
        sudo mkdir -p /etc/iptables/
        sudo iptables-save | sudo tee /etc/iptables/rules.v4
        echo -e "${GREEN}---------------------------------------------------------${RESET}"
        echo -e "${GREEN}                                                 ${RESET}"
        echo -e "${GREEN}               Ping is closed                      $PORTS ${RESET}"
        echo -e "${GREEN}                                                 ${RESET}"
        echo -e "${GREEN}---------------------------------------------------------${RESET}"
        read -p "Back to Main menu? (${GREEN}y${RESET}/${RED}n${RESET}): " answer
        if [ "$answer" == "y" ]; then
        sudo dds-tunnel
        else
        echo "OK"
        echo -e "${CYAN}Exiting...${RESET}"
        exit 0
        fi
        ;;
    2)
        exit
        echo "Your exit now ."
        ;;
esac