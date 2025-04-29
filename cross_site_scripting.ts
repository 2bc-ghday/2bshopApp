// This code directly embeds user-provided data from the name query parameter into the HTML response without any sanitization

const express = require('express');
const app = express();
const port = 3000;

app.get('/greet', (req, res) => {
  const name = req.query.name;
  res.send(`<h1>Hello, ${name}!</h1>`);
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});