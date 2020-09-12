#!/usr/bin/env python

import requests
import re
import urlparse


target_url = "https://google.com"
target_links = []

def extract_link_from(url):
    response = requests.get(target_url)
    return re.finall('(?:href=")(.*)"', response.content)

def crawl(url)
    href_links = extract_link_from(url)
    for link in href_links:
        link = urlparse.urljoin(url, link)

        if "#" in link:
            link = link.split("#")[0]

        if target_url in link and link not in target_links:
            target_links.append(link)
            print(link)
            crawl(link)


crawl(target_url)
