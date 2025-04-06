// filepath: /Users/markvalman/Desktop/sql_injection.ts
// This script demonstrates a SQL injection vulnerability
// in a TypeScript application using SQLite.
import sqlite3 from 'sqlite3';

function getUserData(username: string): any {
    const db = new sqlite3.Database('users.db');
    return new Promise((resolve, reject) => {
        // Explicitly demonstrate the vulnerability with string concatenation
        const query = `SELECT * FROM users WHERE username = '${username}'`;
        console.log("Executing query:", query); // Log the query for clarity
        db.get(query, (err, row) => {
            db.close();
            if (err) {
                reject(err);
            } else {
                resolve(row);
            }
        });
    });
}

// Example usage (vulnerable)
const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

readline.question("Enter username: ", (user: string) => {
    getUserData(user)
        .then((userData) => {
            console.log(userData);
            readline.close();
        })
        .catch((error) => {
            console.error("Error:", error);
            readline.close();
        });
});

// = '' OR 1=1; --
// Example of a malicious input that could be used to exploit the vulnerability
// This input would return all users in the database
// Note: This is a demonstration of a vulnerability and should not be used in production code.