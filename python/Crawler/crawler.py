#!/usr/bin/env python

import requests
import re
import urlparse


def request(url)
    try:    
        return requests.get("http://" + url)
    except requests.exceptions.ConnectionError:
        pass


target_url = "google.com"

''' search into web similar to dirb/dirbuster/gobuster/wfuzz '''
with open("file_location\common.txt","r") as wordlist_file:
    for line in wordlist_file:
        word = line.strip()
        test_url =  target_url + "/" + word
        response = request(test_url)
        if response:
            print("[+] Discovered subdomain --> " + test_url)
