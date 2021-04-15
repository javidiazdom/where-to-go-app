var express = require('express');
var app = express();
const port = 4040;

app.get('/', (req, res) => {
  res.send('Hello world!');
});

app.listen(4040, () => {
  console.log(`Server listening on port ${4040}`);
});
