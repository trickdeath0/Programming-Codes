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
	
	
	## nmap-$target - result from nmap
	## port-$target - result for only port without a lot information
	## enum-$target - only vulnerable port

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
	command nmap -p- -A $target -oN /root/Desktop/Xtoolib/nmap-$target.txt
	echo -e " "
	
	
	command cd /root/Desktop/Xtoolib/ && touch port-$target.txt
	## Add to grep more info if someting relevent for us { -e "" }
	command cat nmap-$target.txt | cut -d " " -f1-1000 | grep -e "/" -e "ftp-anon" > port-$target.txt
	
	##cut the file and check for port http|https -> ssl only port number for nikto and dirb
	command touch http-$target.txt && cat nmap-$target.txt | cut -d ":" -f2 | grep -e "http" -e "ssl" | awk '{print $1;}' | cut -d'/' -f1 > http-$target.txt
	
	
	## Nikto
	echo -e "\e[93m[~] Starting  Nikto Scan\e[36m"
	## build loop for all http open and scan them
	cat http-$target.txt | while read line; do x-terminal-emulator --execute nikto -h http://$target:$line -o /root/Desktop/Xtoolib/nikto-$target.txt; done
	
	## Dirb
	echo -e "\e[93m[~] Starting  Dirb Scan\e[36m"
	## build loop for all http open and scan them
	cat http-$target.txt | while read line; do x-terminal-emulator --execute dirb http://$target:$line -o /root/Desktop/Xtoolib/dirb-$target.txt; done
	

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
	echo "nmapResult, searchsploit, hydra, wpscan and more...."
	echo -e "\e[36m "
	echo -e " "
	
	## An open port that can be vulnerable
	echo -e "\e[93m[~] Checking for vulnerable nmap sources that can help late\e[36m"
	sleep 1
	
#	## Option 1 more easy, have bug...
#	## Need to download list from github about specipc URL { With GitHub I have bug....}
#	#command git clone https://github.com/trickdeath0/Xtoolib.git && mv /root/Desktop/Xtoolib/Xtoolib/searchex.txt /root/Desktop/Xtoolib/searchex.txt && rm -r Xtoolib
#	#command grep -Ff "searchex.txt" "nmap-$target.txt"
	

	## Option 2 work, need to add to this command new info from nmap...
#	## Stores in the file all the ports that are vulnerable
#	#command echo -e "vsftpd\nOpenSSH\nsmtpd\nBIND\nApache httpd\nSamba smbd\nProFTPD\nMySQL\nPostgreSQL\nUnrealIRCd\npache Jserv\nApache Tomcat\nNode.js\nRuby\n" > /root/Desktop/Xtoolib/searchex.txt
#	#command grep '^[1-9]' nmap-$target.txt | while read line; do grep -e "$line" -f searchex.txt; done > enum-$target.txt
	
	
	command cat nmap-$target.txt | grep -e "vsftpd" -e "OpenSSH" -e "smtpd" -e "BIND" -e "Apache httpd" -e "Samba smbd" -e "ProFTPD" -e "MySQL" -e "PostgreSQL" -e "UnrealIRCd" -e "pache Jserv" -e "Apache Tomcat" -e "Node.js" -e "Ruby" > enum-$target.txt

	echo -e "[+] Found all vulnerable sources"
	echo -e " "
	
	
#	## need to sreach for exploit in searchsloit
#	## do a if statmant for each enum
#	#command awk '{print $4}' enum-$target.txt | while read line; do searchsploit $line; done
	
	
	
	## Choose which port you want to check for vulnerabilities
	portsOpen
	
	
	echo -e " "
	clear
	command rm searchex.txt
	echo "[⁂] Finish Enumeration reports"
	echo "======================================================================================================================"
	echo -e " "
	echo -e "\e[1m[+] Searchsploit results...\e[21m"
	#command awk '{print $4,$5,$6,$7,$8,$9,$10}' enum-$target.txt
	echo -e " "
	echo "======================================================================================================================"
	echo -e " "
	echo -e "XXXX results..."
	#command cat weblist-$target.txt | sort -u
	read -n 1 -s -r -p "Press any key to continue"
	

}


###############################################
##########		   portsOpen 		##########
#############################################

portsOpen(){
	
	while :
	 do	
		echo -e "\e[93m[~] Select the port number you want to check from the option below:\e[36m"
		command awk '{print $1,$4,$5,$6,$7,$8,$9,$10}' enum-$target.txt	
		echo -e "\n\e[1mSelect 999 to finish the enumeration step\e[21m"
		echo -e " "
		read input
		if [[ $input -eq 999 ]]; then
			break
			
		## more esay but again didn't work for me
		#elif [ $input -eq `cat enum-$target.txt | cut -d "/" -f1 | grep -e "$input"` ]; then
			#if [ $input -eq `cat enum-$target.txt | cut -d "/" -f1 | grep -e "^21$"` ];
			#if [ `cat searchex.txt | grep "vsftpd"` -eq `awk '{print $4}' enum-10.0.2.5.txt | grep "vsftpd"` ]; then 
			
		
		elif [[ $input -eq 21 || $input -eq 22 || $input -eq 25 || $input -eq 53 || $input -eq 80 || $input -eq 139 || $input -eq 445 || $input -eq 666 || $input -eq 8180  ]]; then
			## port 21 FTP
			if [ 21 -eq $input ]; then
				echo -e " "
				echo "Chose your option below:"
				echo "[1] Try to connect"
				echo "[2] Search for vulnerabilities by searchsploit"
				read input
				case $input in
				  1) ## In the future create an automatic login
					 command cat port-$target.txt | grep -e "Anonymous" && echo -e "\n\e[0;31m[+] Anonymous:root or root:root\e[0;36m\n" && ftp $target ;;
				  2) command searchsploit vsftpd `awk '{print $5}' enum-$target.txt | tr -d [:alpha:] | cut -c1-2 |sed -n 1p` && sleep 5 ;;
				  *) echo "Opps!!! Please select choice 1 or 2";
					 echo "Press a key. . ." ; read ;;
				esac
				 
			## port 22 SSH	
			elif [ 22 -eq $input ]; then
				echo -e " "
				echo "Chose your option below:"
				echo "[1] Try to connect"
				echo "[2] Search for vulnerabilities by searchsploit"
				read input
				case $input in
				  1) ## In the future create an automatic login
					 command ssh $target ;;
				  2) command searchsploit OpenSSH `awk '{print $5}' enum-$target.txt | tr -d [:alpha:] | cut -c1-2 |sed -n 2p` && sleep 5 ;;
				  *) echo "Opps!!! Please select choice 1 or 2";
					 echo "Press a key. . ." ; read ;;
				esac 
				
			## port 25 SMTP
			elif [ 25 -eq $input ]; then
				echo -e " "
				echo "Chose your option below:"
				echo "[1] Try to connect"
				echo "[2] Search for vulnerabilities by searchsploit"
				read input
				case $input in
				  1) ## In the future create an automatic login
					 command telnet $target ;;
				  2) command searchsploit Postfix smtp && sleep 5 ;;
				  *) echo "Opps!!! Please select choice 1 or 2";
					 echo "Press a key. . ." ; read ;;
				esac 
			
			# Port 53 Domain Bind	
			elif [ 53 -eq $input ]; then
				searchsploit isc bind  `awk '{print $4,$5}' enum-$target.txt | tr -d [:alpha:] | cut -c1-2` && sleep 5
				
			# Port 80 http Apache	
			elif [ '80' -eq $input ]; then
				echo -e " "
				echo "Chose your option below:"
				echo "[1] Open the browser site"
				echo "[2] Search for vulnerabilities by searchsploit"
				read input
				case $input in
				  1) command xdg-open http://$target ;;
				  2) command searchsploit Apache http && sleep 5 ;;
				  *) echo "Opps!!! Please select choice 1 or 2";
					 echo "Press a key. . ." ; read ;;
				esac 
			
			# Port 139 Samba smb	
			elif [ 139 -eq $input ]; then
				echo "Samba" 
				
			# Port 445 Samba smb	
			elif [ 445 -eq $input ]; then
				echo "Samba"
				
			# Port 666 http Node.js		
			elif [ 666 -eq $input ]; then
				command searchsploit Node.js && sleep 5
				
				
			elif [ '2121' -eq $input ]; then
				echo "ProFTPD" 
			elif [ 3306 -eq $input ]; then
				echo "MySQL"
			elif [ 5432 -eq $input ]; then
				echo "PostgreSQL" 	
			elif [ 6667 -eq $input ]; then
				echo "UnrealIRCd"
			elif [ 6697 -eq $input ]; then
				echo "UnrealIRCd" 	
			elif [ '8009' -eq $input ]; then
				echo "Apache Jserv"
			elif [ '8180' -eq $input ]; then
				echo "Apache Tomcat" 	
				command xdg-open http://$target:$input
			elif [ 8787 -eq $input ]; then
				echo "Ruby" 								
			else
				echo "need to make more"
			fi
			

		else
			echo -e "\e[91m[-] Please select a port number from the list\e[36m"
		fi
		
		
		
		## swich case...
		#case $input in
		#  `awk '{ a[NR] = $0; } END { for (i=1; i<=NR; ++i) print i }' enum-$target.txt`) echo " Check port a[$i]" ; read ;;
		#  x) break ;;
		#  *) echo "Please select a number from the list";
		#	 echo "Press a key. . ." ; read ;;
		#esac
		#clear
		echo -e " "
	done
	 
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

