#!/bin/bash

	##x-terminal-emulator##
	
	## Note Do not touch ##
	# Change / delete #
	
	## Color:
	## \e[91m - red
	## \e[0;31m - Dark red 
	## \e[32m - Blue green
	## \e[36m - Blue
	## \e[93m - Orenge
	## \e[1m - Bold 
	## \e[21m - Normal

###############################################
##########		 XtoolibAuto 		##########
#############################################

XtoolibAuto()
{
#################################################################################################################################################################################################################################	
	echo -e " "
	echo "[⁂] Start Recon"
	echo "======================================================================================================================"
	echo -e "A folder has been created in root/Desktop/ that will contain the results"
	command mkdir -p /root/Desktop/Xtoolib
	sleep 0.5
	echo -e " "
	echo -e "\e[91m[⁑] The scanning stage includes the following tools: [⁑]"
	echo "Netdiscover, Nmap, Nikto and Dirb"
	echo -e "\e[36m "
	echo -e " "
	
	 read -r -p "[+] Do you want to use Netdiscover? [Y/n] " response
	 response=${response,,} # tolower
	 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
	 
		## Netdiscover 
		echo -e "\e[93m[~] Starting  Netdicover Scan"
		echo -e "\e[36m "
		echo -e "for example: 192.168.1.0/24 "
		read -p "Enter your adapter's name: " ip
		echo -e " "
		gnome-terminal -- netdiscover -r $ip; echo "Press CTRL + C When you Finish the SCAN! *IMPORTANT* :"
		echo -e " "
		sleep 3
	else
		echo -e "\e[0;31m[-] Skip"
		echo -e "\e[36m "
	 fi
	
	## Nmap
	echo -e "\e[93m[~] Starting  Nmap Scan\e[36m"
	read -p "Enter Domain or IP Address: " target
	echo -e "This will take a moment... Get some coffee =]"
	#command nmap -p- -A $target -oN /root/Desktop/Xtoolib/nmap-$target.txt
	echo -e " "
	
	
	command cd /root/Desktop/Xtoolib/ && touch port-$target.txt
	## Add to grep more info if someting relevent for us { -e "" }
	command cat nmap-$target.txt | cut -d " " -f1-1000 | grep -e "/" -e "ftp-anon" > port-$target.txt
	
	##cut the file and check for port http|https -> ssl only port number for nikto and dirb
	command touch http-$target.txt && cat nmap-$target.txt | cut -d ":" -f2 | grep -e "http" -e "ssl" | awk '{print $1;}' | cut -d'/' -f1 > http-$target.txt
	
	
	## Nikto
	echo -e "\e[93m[~] Starting  Nikto Scan\e[36m"
	## build loop for all http open and scan them
	#cat http-$target.txt | while read line; do x-terminal-emulator --execute nikto -h http://$target:$line -o /root/Desktop/Xtoolib/nikto-$target.txt; done
	
	## Dirb
	echo -e "\e[93m[~] Starting  Dirb Scan\e[36m"
	## build loop for all http open and scan them
	#cat http-$target.txt | while read line; do x-terminal-emulator --execute dirb http://$target:$line -o /root/Desktop/Xtoolib/dirb-$target.txt; done
	

	## Create new file of all url
	command touch /root/Desktop/Xtoolib/weblist-$target.txt
	command cat nikto-$target.txt | cut -d ":"  -f2 | grep "/" | cut -d " " -f3 > weblist-$target.txt
	## Append to the file before new site that nikto don't discover.
	command cat dirb-$target.txt | cut -d " " -f 2 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" >> weblist-$target.txt && cat dirb-$target.txt | cut -d " " -f 3 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" >> weblist-$target.txt
	
	clear
	echo "[⁂] Finish Recon reports"
	echo "======================================================================================================================"
	echo -e " "
	echo -e "\e[1m[+] Nmap results...\e[21m"
	command cat port-$target.txt
	echo -e " "
	echo "======================================================================================================================"
	echo -e " "
	echo -e "\e[1m[+] Nikto & dirb results...\e[21m"
	command cat weblist-$target.txt | sort -u && rm http-$target.txt
	read -n 1 -s -r -p "Press any key to continue"
	
#################################################################################################################################################################################################################################
	
	clear
	echo -e " "
	echo "[⁂] Start Enumeration"
	echo "======================================================================================================================"
	echo -e "\e[91m[⁑] The enumeration stage includes the following tools: [⁑]"
	echo "nmapResult, hydra, wpscan and more...."
	echo -e "\e[36m "
	echo -e " "
	
	## An open port that can be vulnerable
	echo -e "\e[93m[~] Checking for vulnerable nmap sources that can help late\e[36m"
	
	## Option 1 more easy, have bug...
	## Need to download list from github about specipc URL { With GitHub I have bug....}
	#command git clone https://github.com/trickdeath0/Xtoolib.git && mv /root/Desktop/Xtoolib/Xtoolib/searchex.txt /root/Desktop/Xtoolib/searchex.txt && rm -r Xtoolib
	#command grep -Ff "searchex.txt" "nmap-$target.txt"
	

	## Option 2 work, need to add to this command new info from nmap...
	command cat nmap-$target.txt | grep -e "vsftpd" -e "OpenSSH" -e "smtpd" -e "BIND" -e "Apache httpd" -e "Samba smbd" -e "ProFTPD" -e "MySQL" -e "PostgreSQL" -e "UnrealIRCd" -e "pache Jserv" -e "Apache Tomcat" -e "Node.js" -e "Ruby" > searchex.txt
	command grep '^[1-9]' nmap-$target.txt | while read line; do grep -e "$line" -f searchex.txt; done > enum-$target.txt
	
	
	
	## need to sreach for exploit in searchsloit
	## do a if statmant for each enum
	#command awk '{print $4}' enum-$target.txt | while read line; do searchsploit $line; done
	
	
	
	## need to check for web source code
	
	
	echo -e " "
	#clear
	echo "[⁂] Finish Enumeration reports"
	echo "======================================================================================================================"
	echo -e " "
	echo -e "\e[1m[+] Searchsploit results...\e[21m"
	command awk '{print $4,$5,$6,$7,$8,$9,$10}' enum-$target.txt
	echo -e " "
	echo "======================================================================================================================"
	echo -e " "
	echo -e "XXXX results..."
	#command cat weblist-$target.txt | sort -u
	read -n 1 -s -r -p "Press any key to continue"
	

}


###############################################
##########		   Before 			##########
#############################################

before()
{ 
	clear
	echo -e "\e[0;31m Ethical use only \e[0m"
	echo -e "\e[36mThe program includes Scanning, Enumeration, Explosion and Privilege Escalation"
	sleep 1
	XtoolibAuto
}


###############################################
##########			Logo 			##########
#############################################


logo()
{
	echo -e "\e[32m
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
		# Created Aug 2021 | Copyright (c) 2021 Shay Giladi.
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
		
		echo "Welcome the the Xtoolib, This auto tool will help you for pentesing "
		echo "Chose your option below:"
		echo "[1] use Auto PenTesting tools"
		echo "[2] Exit"
		read input
		case $input in
		  1) before ; read ;;
		  2) exit 0 ;;
		  *) echo "Opps!!! Please select choice 1 or 2";
			 echo "Press a key. . ." ; read ;;
		esac
	done
}


## code start here ##
main
#####################

