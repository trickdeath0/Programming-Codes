# apt install python-pip	#python 2
# apt install python3-pip	#python 3

apt install python-all-dev	#python 2
apt install python3-venv python3-pip	   #python 3


command -v pip		#python 2
command -v pip3		#python 3



If scapy is not installed in your system, then you can use this command to install scapy:

	apt-get install python-scapy

	pip3 install scapy-http

	pip3 install netfilterqueue
	if the last commend doesn't work do this
	->apt install python3-pip git libnfnetlink-dev libnetfilter-queue-dev
	->pip3 install -U git+https://github.com/kti/python-netfilterqueue




in the etidor use this!

If you are using Scapy v1.X:

	from scapy import *
Otherwise, with Scapy V2.X+

	from scapy.all import *

