# This script demonstrates a SQL injection vulnerability
# in a Python application using SQLite.
import sqlite3

def get_user_data(username):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    # Explicitly demonstrate the vulnerability with string concatenation
    query = "SELECT * FROM users WHERE username = '" + username + "'"
    print("Executing query:", query)  # Log the query for clarity
    cursor.execute(query)
    result = cursor.fetchone()
    conn.close()
    return result

# Example usage (vulnerable)
user = input("Enter username: ")
user_data = get_user_data(user)
print(user_data)