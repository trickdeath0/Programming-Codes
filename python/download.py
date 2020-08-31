#!/usr/bin/env python
import requests

def download(url):
    get_request = requests.get(url)
    file_name = url.split("/")[-1]
    with open(file_name,"wb") as out_file:
        out_file.write(get_request.content)

download("image.jpg") #for ex. https://image.shutterstock.com/image-photo/bright-spring-view-cameo-island-260nw-1048185397.jpg
