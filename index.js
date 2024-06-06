const express = require('express');
const app = express();
const port = 3000;

app.get('/api/v1/welcome', (req, res) => {
    res.send('Hello world');
});

app.listen(port, '0.0.0.0', () => {
    console.log(`Server is running on http://localhost:${port}`);
});
