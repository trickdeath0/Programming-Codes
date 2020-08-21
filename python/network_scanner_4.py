#!/usr/bin/env python

import scapy.all as scapy
import argparse


def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--target", dest="target", help="Target IP / IP range/")
    options = parser.parse.parse_args()
    return options


def scan(ip):
    arp_request = scapy.ARP(pdst=ip)
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_request_broadcast = broadcast / arp_request
    answred_list = scapy.srp(arp_request_broadcast, timeout=1, verbose=False)[0]

    clints_list = []
    for element in answred_list:
        client_dict = {"ip": element[1].psrc, "mac": element[1].hwsrc}
        clints_list.append(client_dict)
        print(element[1].psrc + "\t\t" + element[1].hwsrc)
    return clints_list


def print_result(results_list):
    print("IP\t\t\tMAC Adress\n--------------------------------------")
    for client in results_list:
        print(client["ip"] + "\t\t" + client["mac"])


options = get_arguments()
scan_result = scan(options.target)
print_result(scan_result)
