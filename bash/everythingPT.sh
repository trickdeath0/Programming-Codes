#!/bin/bash

## Created by Shay Giladi
## Last edit 22/08/2022

###########################################################################
#
#
#
#
#
###########################################################################


########################    Start here    #################################

Start()
{
	Logo
	echo ""
	echo "Starting download everything you need :)"
	
	
	## Check for root privilage
	if [ "$EUID" -ne 0 ]
	  then FILE_NAME="/home/${USER}/Desktop"
	  	sudo apt update
	else
	  FILE_NAME="/${USER}/Desktop"
	  apt update
	fi
	

	cd "$FILE_NAME"
	Web 		# Web
	cd "$FILE_NAME"
	PE		# Linux & Windows
	cd "$FILE_NAME"
	SE		# OSINT,...
	cd "$FILE_NAME"
	AD		# Active Directory
	cd "$FILE_NAME"
	Mobile		# Android & iOS
	cd "$FILE_NAME"
	#Forensics	# Forensics
	cd "$FILE_NAME"
	RE		# Reverse Engineering
	cd "$FILE_NAME"
	#Malware		# Malware Reserch
	cd "$FILE_NAME"
	
	
	echo ""
	echo ""	
	echo "[~] EverythingPT finish..."
	echo "[~] See you next time"

}

Web(){
	echo "[+] Start download Web Tools..."
	mkdir -p Web && cd Web
	echo "[*] Make a shortlink for all seclist"
	#ln -s /usr/share/webshells/ /usr/share/webshells/
	echo "[+] seclist complete"
	
	echo "[*] Download CMSmap"
	git clone https://github.com/Dionach/CMSmap
	cd CMSmap
	pip3 install .
	cd .. && echo "[+] CMSmap complete"
		
	echo "[*] Download Git Tools"
	mkdir -p Git_Tool && cd Git_Tool
	git clone https://github.com/internetwache/GitTools.git
	git clone https://github.com/HightechSec/git-scanner
	cd git-scanner
	sudo cp gitscanner.sh /usr/bin/gitscanner && sudo chmod +x /usr/bin/gitscanner && cd ..
	cd .. && echo "[+] GitTools complete"
	
	echo "[*] Download SubDomins Tools"
	mkdir -p SubDomins && cd SubDomins
	git clone https://github.com/aboul3la/Sublist3r.git
	cd Sublist3r && sudo pip install -r requirements.txt && cd ..
	#####go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
	git clone https://github.com/codingo/VHostScan.git
	cd VHostScan && python3 setup.py install
	cd ../../ && echo "[+] SubDomins complete"
	
	echo "[*] Download WebShell"
	mkdir -p WebShell && cd WebShell
	wget https://raw.githubusercontent.com/F1uffyGoat/php-cmd-exec-webshell/master/exiftool%20code
	cd .. && echo "[+] WebShell complete"
	
	echo "[*] Download XSS Tools"
	mkdir -p XSS && cd XSS
	git clone https://github.com/s0md3v/XSStrike.git
	cd .. && echo "[+] XSS complete"
	
	echo "[*] Download SQL Tools"
	mkdir -p SQL && cd SQL
	echo "[*] Download NoSQL Tools"
	git clone https://github.com/codingo/NoSQLMap.git	
	cd NoSQLMap && python setup.py install
	cd .. && echo "[+] NoSQL complete"
	sudo apt install jsql-injection
	cd .. && echo "[+] XSSSQLcomplete"
	
	echo "[*] Download RCE Tools"
	mkdir -p RCE && cd RCE
	echo "[*] Download RCE for PHP"
	mkdir -p PHP && cd PHP
	git clone https://github.com/flast101/php-8.1.0-dev-backdoor-rce.git
	cd .. && echo "[+] RCE for PHP"
	cd .. && echo "[+] RCE Tools"
	
}


PE(){
	echo "[+] Start download Privilege Escalation Tools..."
	echo "[+] Start download Linux PE Tools..."
	mkdir -p Linux-PE && cd Linux-PE
	echo "[+] linux-exploit-suggester"
	wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
	git clone https://github.com/jondonas/linux-exploit-suggester-2.git
	echo "[+] linux-exploit-suggester complete"
	
	echo "[+] linpeas"
	wget curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
	echo "[+] linpeas complete"
	
	echo "[+] enum4linux"
	sudo apt install enum4linux
	echo "[+] enum4linux complete"
	
	echo "[+] Kernel Exploit"
	mkdir -p Kernel_exploit && cd Kernel_exploit
	wget https://gist.githubusercontent.com/KrE80r/42f8629577db95782d5e4f609f437a54/raw/71c902f55c09aa8ced351690e1e627363c231b45/c0w.c
	cd .. && echo "[+] Kernel Exploit complete"
	
	echo "[+] CVE"
	mkdir -p CVE && cd CVE
	git clone https://github.com/randorisec/CVE-2022-34918-LPE-PoC.git
	cd CVE-2022-34918-LPE-PoC
	make
	cd .. && echo "[+] CVE complete"
	
	cd "$FILE_NAME"
	echo "[+] Start download Windows PE Tools..."
	mkdir -p Windows-PE && cd Windows-PE	
	echo "[+] winpeas"
	git clone https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS
	echo "[+] winpeas complete"
	
	echo "[+] unicorn"
	git clone https://github.com/trustedsec/unicorn.git
	echo "[+] unicorn complete"
	
	echo "[+] Windows-PE-Tools [Moriel]"
	git clone https://github.com/MorielHarush/Windows-PE-Tools.git
	echo "[+] Windows-PE-Tools [Moriel] complete"
	
	echo "[+] hoaxshell"
	git clone https://github.com/t3l3machus/hoaxshell
	cd ./hoaxshell
	sudo pip3 install -r requirements.txt
	chmod +x hoaxshell.py
	cd .. && echo "[+] hoaxshell complete"
}


SE(){
	echo "[+] Start download Social Engineering Tools..."
	mkdir -p SE && cd SE
	echo "[+] socialscan"
	pip install socialscan
	echo "[+] socialscan complete"
	
	echo "[+] h8mail"
	pip3 install h8mail
	echo "[+] h8mail complete"
	
	echo "[+] rustscan"
	dpkg -i rustscan_2.0.1_amd64.deb
	echo "[+] rustscan complete"
	
	#echo "[+] rustscan"
	#dpkg -i rustscan_2.0.1_amd64.deb
	#echo "[+] rustscan complete"
	
	echo "[+] Start download OSNIT Tools..."
	mkdir -p OSNIT && cd OSNIT
	echo "[+] Cheat Sheet Osint"
	git clone https://github.com/sinwindie/OSINT.git
	echo "[+] Cheat Sheet Osint complete"
	
	echo "[+] Depix"
	pip install git+https://github.com/beurtschipper/Depix
	echo "[+] Depix complete"
	
	echo "[+] userrecon"
	git clone https://github.com/issamelferkh/userrecon.git
	echo "[+] userrecon complete"
	
	echo "[+] sterra"
	pip install sterra
	echo "[+] sterra complete"
	
	echo "[+] httrack"
	sudo apt install httrack
	echo "[+] httrack complete"
	
	mkdir -p DeepWeb && cd DeepWeb
	echo "[+] Darkdump"
	git clone https://github.com/josh0xA/darkdump
	cd darkdump
	python3 -m pip install -r requirements.txt
	cd ../..
	echo "[+] Darkdump complete"
	
}

AD(){
	echo "[+] Start download Active Directory Tools..."
	mkdir -p AD && cd AD
	echo "[+] Red-Team-Tools [Moriel]"
	git clone https://github.com/MorielHarush/Red-Team-Tools.git
	echo "[+] Red-Team-Tools [Moriel] complete"
	
	echo "[+] AD description password finder"
	git clone https://github.com/AssuranceMaladieSec/AD-description-password-finder.git
	cd AD-description-password-finder && pip3 install -r requirements.txt
	cd .. && echo "[+] AD description password finder complete"
	
	echo "[+] BruteSharkCli"
	wget https://github.com/odedshimon/BruteShark/releases/latest/download/BruteSharkCli
	echo "[+] BruteSharkCli complete"

}


Mobile(){
	echo ""
}


RE(){
	echo "[+] Start download Reversing Engineering Tools..."
	mkdir -p RE && cd RE
	echo "[+] ImHex"
	wget https://github.com/WerWolv/ImHex/releases/download/v1.21.2/imhex-1.21.2.deb
	dpkg -i imhex-1.21.2.deb
	echo "[+] ImHex complete"
	
	

}




Logo(){
	echo '8888888888                                    888    888      d8b                   8888888b.  88888888888'
	echo '888                                           888    888      Y8P                   888   Y88b     888    '
	echo '888                                           888    888                            888    888     888    '
	echo '8888888    888  888  .d88b.  888d888 888  888 888888 88888b.  888 88888b.   .d88b.  888   d88P     888    '
	echo '888        888  888 d8P  Y8b 888P"   888  888 888    888 "88b 888 888 "88b d88P"88b 8888888P"      888    '
	echo '888        Y88  88P 88888888 888     888  888 888    888  888 888 888  888 888  888 888            888    '
	echo '888         Y8bd8P  Y8b.     888     Y88b 888 Y88b.  888  888 888 888  888 Y88b 888 888            888    '
	echo '8888888888   Y88P    "Y8888  888      "Y88888  "Y888 888  888 888 888  888  "Y88888 888            888    '
        echo '                            888                                   888                       '
        echo '                       Y8b d88P                              Y8b d88P                       '
       	echo '                        "Y88P"                                "Y88P"                        '
	echo ''
	echo '____ ____ ____ ____ ___ ____ ___     ___  _   _    ____ _  _ ____ _   _    ____ _ _    ____ ___  _'
	echo '|    |__/ |___ |__|  |  |___ |  \    |__]  \_/     [__  |__| |__|  \_/     | __ | |    |__| |  \ |'
	echo '|___ |  \ |___ |  |  |  |___ |__/    |__]   |      ___] |  | |  |   |      |__] | |___ |  | |__/ |' 
	echo ''
	echo ''
	echo 'Update: 22/08/2022'
}

Start
