const request = require('supertest');
const express = require('express');

const app = express();
app.get('/api/v1/welcome', (req, res) => {
    res.status(200).send('Siuuuuuuuuu');
});

describe('GET /api/v1/welcome', () => {
    it('Siuuuuuuuuu', (done) => {
        request(app)
            .get('/api/v1/welcome')
            .expect('Siuuuuuuuuu', done);
    });
});
