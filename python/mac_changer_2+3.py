#!/usr/bin/evn python

import subprocess  # echo in the terminal
import optparse  # docostring
import re  # get specific item from interface


def get_arguments():
    parase = optparse.OptionParser()
    parase.add_option("-i", "--interface", dest="interface", help="Interface to change MAC address")
    parase.add_option("-m", "--mac", dest="new_mac", help="New MAC adress")
    (options, arguments) = parase.parse_args()
    if not options.interface:
        parase.error("[-] Please specify an interface, use --help for more info.")
    elif not options.new_mac:
        parase.error("[-] Please specify a new mac, use --help for more info.")
    return options


def change_mac(interface, new_mac):
    print("[+] Changing MAC adderss for " + interface + " to " + new_mac)
    subprocess.call(["ifconfig", interface, "down"])
    subprocess.call(["ifconfig", interface, "hw", "ether", new_mac])
    subprocess.call(["ifconfig", interface, "up"])


def get_current_mac(interface):
    ifconfig_result = subprocess.check_output(["ifconfig", interface])
    mac_address_search_result = re.search(r"\w\w:\w\w:\w\w:\w\w:\w\w:\w\w", ifconfig_result)

    if mac_address_search_result:
        return mac_address_search_result.group(0)
    else:
        print("[-] Could not read MAC address")


options = get_arguments()
current_mac = get_current_mac(options.interface)
print("Current MAC = " + str(current_mac))

change_mac(options.interface, options.new_mac)

current_mac = get_current_mac(options.interface)
if current_mac == options.new_mac:
    print("[+] MAC address was successfuly changed to" + current_mac)
else:
    print("[-] MAC address did not get changed" )



# 08:00:27:7f:81:bc

############################################################################
'''the same line up but dont can handle the user input'''
# interface = raw_input("interface > ")
# new_mac = raw_input("new MAC > ")

##interface = options.interface
##new_mac = options.new_mac

# subprocess.call("ifconfig " + interface + " down", shell=True)
# subprocess.call("ifconfig " + interface + " hw ether " + new_mac, shell=True)
# subprocess.call("ifconfig " + interface + " up", shell=True)
############################################################################
