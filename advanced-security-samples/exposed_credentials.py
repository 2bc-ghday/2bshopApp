# credentials.py

# WARNING: Hardcoding credentials in source code is a security risk!
# These are for demonstration purposes only and should NEVER be used in production.

DATABASE_HOST = "localhost"
DATABASE_USER = "admin"
DATABASE_PASSWORD = "P@$$wOrd123"
DATABASE_NAME = "mydatabase"

API_KEY = "YOUR_SUPER_SECRET_API_KEY_HERE"
SECRET_KEY = "aVeryLongAndSecretStringThatShouldBeKeptSafe"

SMTP_SERVER = "smtp.example.com"
SMTP_PORT = 587
SMTP_USERNAME = "user@example.com"
SMTP_PASSWORD = "anotherSecretPassword"

# Example function that might use these credentials (insecurely)
def connect_to_database():
    print(f"Connecting to database: {DATABASE_USER}@{DATABASE_HOST}/{DATABASE_NAME}")
    # In a real application, you would use these to establish a connection
    # with a database library (e.g., psycopg2 for PostgreSQL, mysql.connector for MySQL).
    pass

def call_external_api(data):
    headers = {"Authorization": f"Bearer {API_KEY}"}
    print(f"Calling API with headers: {headers}, data: {data}")
    # In a real application, you would use a library like 'requests' to make an API call.
    pass

def send_email(recipient, subject, body):
    print(f"Sending email to {recipient} via {SMTP_SERVER} as {SMTP_USERNAME}")
    # In a real application, you would use the 'smtplib' library to send emails.
    pass

if __name__ == "__main__":
    connect_to_database()
    call_external_api({"message": "Hello"})
    send_email("test@example.com", "Test Email", "This is a test.")