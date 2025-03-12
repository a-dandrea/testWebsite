from flask import Flask, request, render_template, redirect, url_for
from db_connector import connect_db
import bcrypt

app = Flask(__name__)


# Route to the home page
@app.route('/')
def home():
   return render_template('index.html')

# Route for user registration
@app.route('/register', methods=['GET', 'POST'])
def register():
   if request.method == 'POST':
      username = request.form['username']
      password = request.form['password']
        
      # Hash the password before storing it
      password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
        
      conn = connect_db()
      cursor = conn.cursor()

      try:
         cursor.execute('INSERT INTO users (username, password_hash) VALUES (%s, %s)', (username, password_hash))
         conn.commit()
         return redirect(url_for('login'))
      except mysql.connector.IntegrityError:
         return 'Username already exists, please choose another.'

      finally:
         conn.close()

   return render_template('register.html')

# Route for user login
@app.route('/login', methods=['GET', 'POST'])
def login():
   if request.method == 'POST':
      username = request.form['username']
      password = request.form['password']
        
      conn = connect_db()
      cursor = conn.cursor()
      cursor.execute('SELECT password_hash FROM users WHERE username = %s', (username,))
      result = cursor.fetchone()

      if result:
         stored_password_hash = result[0]
         if bcrypt.checkpw(password.encode('utf-8'), stored_password_hash):
            return f"Welcome {username}!"
         else:
            return 'Incorrect password!'
      else:
         return 'Username not found!'

      conn.close()

   return render_template('login.html')

if __name__ == '__main__':
   app.run(debug=True)
