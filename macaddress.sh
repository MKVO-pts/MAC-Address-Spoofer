#!/bin/bash
##
##VARIABLES
clear
echo Information:
echo Ethernet interfaces starts whit "en"
echo Wireless connection starts whit "wl"
echo 
echo Scraping Network info...
network_addr=$( sudo lshw -C network | grep "serial" )
network_f=${network_addr//serial:}
network=($network_f)

echo Verifing MAC addresses names...
logical_names=$(sudo lshw -C network | grep "logical name" )
names_f=${logical_names//logical name:}
names=($names_f)
sleep 2

clear
#CORES
GREEN='\e[92m'
CIAN='\e[96m'
NC='\033[0m' # No Color 
RED='\033[0;31m'



#FUNCTIONS
#

#display the possible names and MAC addresses avaliable to change
#every time the display function is used, a new value to ($choise) will be set
display() {
	counter=0
	until [ $counter -eq ${#network[@]} ]; do
		echo -e " |$counter| ${names[$counter]}  - ${network[$counter]}"
		let counter++
	done
}

#disconect the enthernet, spoof the macaddr and then reconect
random_MAC() {
	sudo ifconfig ${names[$choise]} down 
	sudo macchanger -r ${names[$choise]}
	sudo ifconfig ${names[$choise]} up
	sleep 5
}

#disconect the enthernet, change to the normal addr and then reconect
reset_MAC() {
	sudo ifconfig ${names[$choise]} down
	sudo macchanger -p ${names[$choise]}
	sudo ifconfig ${names[$choise]} up
}


#MAIN MENU
#Ifinite loop, eatch option return call the "menu()" function
menu() {
	clear

	echo -e ${RED} "Made By "
	echo -e " ${CIAN} _______________________________ "
	echo " /                               \ "
	echo -e " ${CIAN}|${GREEN} %     % %    %        %%%%%% ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} %%   %% %   %         %    % ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} % % % % %  %   %    % %    % ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} %  %  % %%%    %    % %    % ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} %     % %  %   %    % %    % ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} %     % %   %   %  %  %    % ${CIAN} |${NC}"
	echo -e " ${CIAN}|${GREEN} %     % %    %   %%   %%%%%% ${CIAN} |${NC}"
	echo -e " ${CIAN}\_______________________________/${NC}"
	echo ""
	
	echo Choose one option:
	echo -e "  ${CIAN}_________________________________________"
	echo -e "  ${CIAN}|  [1] |${GREEN} Spoof your MAC Address (random)${CIAN}|${NC}"
	echo -e "  ${CIAN}|  [2] |${GREEN} Reset to the Original Address ${CIAN} |${NC}"
	echo -e "  ${CIAN}|  [3] |${GREEN} Exit ${CIAN}			  |${NC}"
	echo -e "  ${CIAN}|_______________________________________|"
	echo Select only the number: && read option
	
	
	if [ $option -eq 1 ]; then
		display
		echo -e "Select one option:(The Number)"
		read choise
		random_MAC
		sleep 10
		menu

	elif [ $option -eq 2 ]; then
		display
		echo -e "Select one option:(The Number)"
		read choise
		echo Changing to the default MAC Address...
		sleep 2
		reset_MAC
		sleep 15
		menu

	elif [ $option -eq 3 ]; then
		echo
		echo -e "${RED}Closing the Tool... ${NC}"
		sleep 2
		exit
	else
		echo -e "${RED}Unknown command / option ${NC}"
		echo -e "${RED}Going back to the menu... ${NC}"
		sleep 2
		menu

	fi
}
menu
