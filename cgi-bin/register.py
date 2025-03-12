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
confirm_password = form.getvalue("confirm_password")

# Password hashing
def hash_password(password):
   return hashlib.sha256(password.encode()).hexdigest()

# Function to check if user already exists
def user_exists(username):
   conn = connect_db()
   cursor = conn.cursor()
   cursor.execute("SELECT * FROM users WHERE username=%s", (username,))
   user = cursor.fetchone()
   conn.close()
   return user is not None

# Function to register user
def register_user(username, password):
   hashed_password = hash_password(password)
   conn = connect_db()
   cursor = conn.cursor()
   cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, hashed_password))
   conn.commit()
   conn.close()

# Handle the registration logic
if username and password and confirm_password:
   if password == confirm_password:
      if user_exists(username):
         print("Content-type: text/html\n")
         print("<html><body><p style='color: red;'>Username already taken. Please choose another one.</p></body></html>")
      else:
         register_user(username, password)
         print("Content-type: text/html\n")
         print("<html><body><p style='color: green;'>Registration successful! You can now <a href='/html/login.html'>login</a>.</p></body></html>")
   else:
      print("Content-type: text/html\n")
      print("<html><body><p style='color: red;'>Passwords do not match.</p></body></html>")
else:
   print("Content-type: text/html\n")
   print("<html><body><p style='color: red;'>Please fill in all fields.</p></body></html>")
