const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;

// Configuração do banco de dados
const db = mysql.createConnection({
  host: 'localhost',
  user: 'efsantos_disc',
  password: 'Kyew1802',
  database: 'efsantos_disc_sysmanager'
});

db.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL');
});

app.get('/', (req, res) => {
  res.send('Sistema SaaS com múltiplos tenants');
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
