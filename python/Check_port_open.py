#!/usr/bin/env python

from socket import *
ip =  raw_input("Enter the IP address: ")
port = input("Enter the port number: ")
sock = socket(AF_INET, SOCK_STREAM)
if sock.connect_ex((ip, port)):
    print "Port", port, "is closed"
else:
    print "Port", port, "is open"
