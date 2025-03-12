#!/usr/bin/python3

import cgi
import cgitb
import hashlib
from db_connector import connect_db

cgitb.enable()

# Get form data
form = cgi.FieldStorage()
username = form.getvalue("username")
password = form.getvalue("password")

# Password hashing function (same as register)
def hash_password(password):
   return hashlib.sha256(password.encode()).hexdigest()

# Function to authenticate user
def authenticate_user(username, password):
   hashed_password = hash_password(password)
   conn = connect_db()
   cursor = conn.cursor()
   cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, hashed_password))
   user = cursor.fetchone()
   conn.close()
   return user is not None

# Handle the login logic
if username and password:
   if authenticate_user(username, password):
      print("Content-type: text/html\n")
      print(f"<html><body><h1>Welcome, {username}!</h1><a href='/html/dashboard.html'>Go to Dashboard</a></body></html>")
   else:
      print("Content-type: text/html\n")
      print("<html><body><p style='color: red;'>Invalid username or password. Please try again.</p></body></html>")
else:
   print("Content-type: text/html\n")
   print("<html><body><p style='color: red;'>Please fill in both fields.</p></body></html>")
