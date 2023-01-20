const express = require('express');
const { Client } = require('pg');
require('dotenv').config();

const app = express();
app.use(express.json());



const client = new Client({
    host: '127.0.0.1',
    port: 5432,
    user: 'user',
    password: 'password',
    database: 'task_manager',

});

client.connect();

app.get('/data', (req, res) => {
    client.query('SELECT * FROM tasks', (err, result) => {
        if (err) {
            console.log(err);
        }
        res.send(result.rows);
    });
});

app.post('/data', (req, res) => {
    const { name } = req.body;
    const status = 'unitialized';
    client.query(`INSERT INTO tasks (name, status) VALUES ($1,$2)`, [name, status], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Error inserting new task');
        }
        res.status(201).send('Task created');
    });
});

app.put('/data', (req, res) => {
    const { id, status, updated_at } = req.body;
    if (status !== 'playing' && status !== 'paused' && status !== 'stopped' && status !== 'unitialized') {
        res.status(400).send('Invalid status');
    }
    // find id in database
    client.query(`SELECT * FROM tasks WHERE id = $1`, [id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Error finding task');
        }
        if (result.rows.length === 0) {
            res.status(404).send('Task not found');
        }
    });

    const finished_at = (status === 'stopped') ? updated_at : null
    console.log(finished_at);

    client.query(`UPDATE tasks SET status = $1, updated_at = $2, finished_at = $3 WHERE id = $4`, [status, updated_at, finished_at, id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Error updating task');
        }
        res.status(200).send('Task updated');
    });
});


app.listen(3001, () => {
    console.log('Server is running on port 3001');
});