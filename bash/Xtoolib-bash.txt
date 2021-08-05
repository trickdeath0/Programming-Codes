#!/bin/bash

	##x-terminal-emulator##

###############################################
##########		 XtoolibAuto 		##########
#############################################

XtoolibAuto()
{
	clear
	echo -e "A folder has been created in root/Desktop/ that will contain the results"
	command mkdir -p /root/Desktop/Xtoolib
	sleep 0.5
	echo -e " "
	echo -e "Recon"
	echo -e " "
	
	## Netdiscover 
	echo -e "[~] Starting  Netdicover Scan"
	echo -e " "
	echo -e "for example: 192.168.1.0/24 "
	read -p "Enter your adapter's name: " ip
	echo -e " "
	gnome-terminal -- netdiscover -r $ip; echo "Press CTRL + C When you Finish the SCAN! *IMPORTANT* :"
	echo -e " "
	sleep 3
	
	## Nmap
	echo -e "[~] Starting  Nmap Scan"
	read -p "Enter Domain or IP Address: " target
	echo -e "This will take a moment... Get some coffee =]"
	command nmap -p- -A $target -oN /root/Desktop/Xtoolib/nmap-$target.txt
	echo -e " "
	
	
	command cd /root/Desktop/Xtoolib/ && touch port-$target.txt
	## Add to grep more info if someting relevent for us { -e "" }
	command cat nmap-$target.txt | cut -d " " -f1-1000 | grep -e "/" -e "ftp-anon" > port-$target.txt
	
	#cut the file and check for port 80, 443
	
	## Nikto
	x-terminal-emulator --execute nikto -h http://$target -o /root/Desktop/Xtoolib/nikto-$target.txt
	
	## Dirb
	x-terminal-emulator --execute dirb  http://$target -o /root/Desktop/Xtoolib/dirb-$target.txt
	

	## Create new file of all url
	command touch /root/Desktop/Xtoolib/weblist-$target.txt
	command cat nikto-$target.txt | cut -d ":"  -f2 | grep "/" | cut -d " " -f3 > weblist-$target.txt
	## Append to the file before new site that nikto don't discover.
	command cat dirb-$target.txt | cut -d " " -f 2 | grep "http" >> weblist-$target.txt && cat dirb-$target.txt | cut -d " " -f 3 | grep "http" >> weblist-$target.txt
	
	clear
	echo "Finish recon"
	echo "======================================================================================================================"
	echo -e " "
	echo -e "Nmap results..."
	command cat port-$target.txt
	echo -e " "
	echo "======================================================================================================================"
	echo -e " "
	echo -e "Nikto & dirb results..."
	command cat weblist-$target.txt | sort

}


###############################################
##########		 XtoolibMan 		##########
#############################################

XtoolibMan()
{ 
	while :
	 do
		clear
		
		echo "Welcome the the Xtoolib, This tool for help for pentesing "
		echo "Chose your option below:"
		echo "[1] Use namp to scan victim computer"
		echo "[2] Use nikto to scan web service"
	    echo "[3] Use dirbuster to get info about source open in the web-server"
		echo "[4] Start geany editors"
		echo "[6] Exit/Stop"
		echo "======================="
		echo -n "Enter your menu choice [1-6]: "
		read input
		case $input in
		
		1) echo "Nmap" ; read ;;
		2) echo "Nikto" ; read ;;
		3) echo "Dirbuster" ; read ;;
		4) geany ;;
		6) exit 0 ;;
		*) echo "Opps!!! Please select choice 1,2,3,4, or 6";
			echo "Press a key. . ." ; read ;;
		esac
	done
}


###############################################
##########			Logo 			##########
#############################################


logo()
{
	echo "
		▄       ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄  
	   ▐░▌     ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ 
		▐░▌   ▐░▌  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌           ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
		 ▐░▌ ▐░▌       ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌     ▐░▌       ▐░▌
		  ▐░▐░▌        ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌
		   ▐░▌         ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌     ▐░░░░░░░░░░▌ 
		  ▐░▌░▌        ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌
		 ▐░▌ ▐░▌       ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌     ▐░▌       ▐░▌
		▐░▌   ▐░▌      ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
	   ▐░▌     ▐░▌     ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ 
		▀       ▀       ▀       ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀  
			  
		# ===== #
		# Created Aug 2021 | Copyright (c) 2021 - 2021 Shay Giladi.
		# Update ----- 2021
		# ===== #
																						  
		"
}


###############################################
##########			Main 			##########
#############################################

main()
{ 
	while :
	 do		
		clear
		logo
		
		echo "Welcome the the Xtoolib, This tool for help for pentesing "
		echo "Chose your option below:"
		echo "[1] use Auto PenTesting tools"
		echo "[2] use Manual PenTesting tools"
		echo "[3] Exit"
		read input
		case $input in
		  1) XtoolibAuto ; read ;;
		  2) XtoolibMan ; read ;;
		  3) exit 0 ;;
		  *) echo "Opps!!! Please select choice 1,2 or 3";
			 echo "Press a key. . ." ; read ;;
		esac
	done
}


## code start here ##
main
#####################

