#!/usr/bin/python3

import cgi
import cgitb

cgitb.enable()

# Display dashboard
def display_dashboard(username):
   print("Content-type: text/html\n")
   print(f"<html><body><h1>Welcome to your Dashboard, {username}</h1></body></html>")

# Assuming user is logged in, we can access the username directly from session or pass it as a parameter
form = cgi.FieldStorage()
username = form.getvalue("username")  # Here, username should be passed after successful login

if username:
   display_dashboard(username)
else:
   print("Content-type: text/html\n")
   print("<html><body><p style='color: red;'>You must be logged in to access the dashboard.</p></body></html>")
