#!/bin/bash

#Main menu
#echo 1-Display MAC address
#echo -e "2-Change your network addr (wlan)"
#echo 3-Change your
#read option


network_addr=$( sudo lshw -C network | grep "serial" )
network_f=${network_addr//serial:}
network=($network_f)

logical_names=$(sudo lshw -C network | grep "logical name" )
names_f=${logical_names//logical name:}
names=($names_f)

#ip link ls
#sudo lshw -C network       -info sobre os network
#ifconfig | grep ether  -mostra apenas os MACaddr


#logic/ process

#NEED to be DONE


















#functions

display() {
	echo  N  	 Names  	  Address
	counter=0
	until [ $counter -eq ${#network[@]} ]; do
		echo $counter: ${names[$counter]}  / ${network[$counter]}
		let counter++
	done
}



#NEED TO BE EDITED

random_MAC() {
	sudo ifconfig $network down
	sudo macchanger -r $network
	sudo ifconfig $network up
	sleep 2
	echo Your MAC address changed
}


reset_MAC() {
	sudo ifconfig $network down
	sudo macchanger -p $network
	sudo ifconfig $network up
	echo Your MAC address is normal again
}

