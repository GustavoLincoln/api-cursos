const express = require('express');
const cors = require('cors');
const cursosRouter = require('./routes/cursos');
const atividadesRouter = require('./routes/atividades');  // Este deve lidar com atividades

const app = express();

app.use(cors());
app.use(express.json());

// Rota para cursos
app.use('/api/cursos', cursosRouter);

// Rota para atividades
app.use('/api/atividades', atividadesRouter);  // Corrigido para atividades

app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});
