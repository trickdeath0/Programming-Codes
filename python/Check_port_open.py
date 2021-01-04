#!/usr/bin/env python

from socket import *
from termcolor import colored

sock = socket(AF_INET, SOCK_STREAM)
setdefaulttimeout(2)

ip =  input("[+] Enter the IP address: ")
#port = int(input("[+] Enter the port number: "))

def portscanner(port):
    if sock.connect_ex((ip, port)):
        print (colored("[!!] Port", port, "is closed"), 'red')
    else:
        print (colored("[+] Port", port, "is open"), 'green')

for port in range(1,100):
    portscanner(port)
