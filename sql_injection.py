# This script demonstrates a SQL injection vulnerability
# in a Python application using SQLite.
import sqlite3

def get_user_data(username):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    query = "SELECT * FROM users WHERE username = '" + username + "'"
    cursor.execute(query)
    result = cursor.fetchone()
    conn.close()
    return result

# Example usage (vulnerable)
user = input("Enter username: ")
user_data = get_user_data(user)
print(user_data)