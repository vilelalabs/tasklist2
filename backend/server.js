const express = require('express');
const { Client } = require('pg');
require('dotenv').config();

const swaggerUi = require('swagger-ui-express'),
    swaggerDocument = require('./swagger.json');

const app = express();
app.use(express.json());
app.use(
    '/api-docs',
    swaggerUi.serve,
    swaggerUi.setup(swaggerDocument)
);

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});


const client = new Client({
    host: '192.168.15.79',
    port: 5432,
    user: 'user',
    password: 'password',
    database: 'task_manager',

});

client.connect();

app.get('/data', (req, res) => {
    client.query(`SELECT * FROM tasks
                    ORDER BY
                    CASE WHEN status != 'stopped' THEN 1 ELSE 2 END,
                    id ASC;`,
        (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).send('Erro interno do servidor');
            }
            if (result.rows.length === 0) {
                res.status(204).send('Nenhuma tarefa encontrada.');
                return
            }
            res.status(200).send(result.rows);
        });
});

app.post('/data', (req, res) => {
    const { name } = req.body;
    const status = 'unitialized';

    if (!name) {
        res.status(400).send('Nome da tarefa é obrigatório.');
        return;
    }

    client.query(`INSERT INTO tasks (name, status) VALUES ($1,$2)`, [name, status], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Erro interno do Servidor.');
        }
        res.status(201).send('Tarefa Criada.');
    });
});

app.put('/data', (req, res) => {
    const { id, status, updated_at } = req.body;
    if (status !== 'playing' && status !== 'paused' && status !== 'stopped' && status !== 'unitialized') {
        res.status(400).send('Status Inválido.');
    }
    // find id in database
    client.query(`SELECT * FROM tasks WHERE id = $1`, [id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Erro interno do servidor.');
        }
        if (result.rows.length === 0) {
            res.status(404).send('Tarefa não encontrada.');
        }
    });

    const finished_at = (status === 'stopped') ? updated_at : null

    client.query(`UPDATE tasks SET status = $1, updated_at = $2, finished_at = $3 WHERE id = $4`, [status, updated_at, finished_at, id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Erro interno do servidor.');
        }
        res.status(200).send('Status atualizado.');
    });
});

app.put('/data/updatetimer', (req, res) => {
    const { id, timer } = req.body;

    // find id in database
    client.query(`SELECT * FROM tasks WHERE id = $1`, [id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Erro interno do servidor.');
        }
        if (result.rows.length === 0) {
            res.status(404).send('Tarefa não encontrada.');
        }
    });

    client.query(`UPDATE tasks SET timer = $1 WHERE id = $2`, [timer, id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send('Erro interno do servidor.');
        }
        res.status(200).send('Timer da tarefa atualizado.');
    });
});


app.delete('/data', (req, res) => {
    const { id } = req.query;

    if (!id) {
        res.status(400).send('ID inválido.');
        return;
    }

    client.query(`DELETE FROM tasks WHERE id = $1`, [id], (err, result) => {
        if (err) {
            res.status(500).send('Erro interno do servidor.');
            return;
        }

        if (result.rowCount === 0) {
            res.status(404).send('Tarefa não encontrada.');
            return;
        }

        res.status(200).send('Tarefa excluída com sucesso.');
    });

});



app.listen(3001, () => {
    console.log('Server is running on port 3001');
});