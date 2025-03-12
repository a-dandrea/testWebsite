import mysql.connector

def connect_db():
   # Connect to MySQL
   connection = mysql.connector.connect(
      host="localhost",      # Your MySQL host (default is localhost)
      user="root",           # Your MySQL username
      password="password",   # Your MySQL password
      database="fitness_tracker"  # Your database name
   )
   return connection
