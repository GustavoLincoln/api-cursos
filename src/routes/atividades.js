const express = require('express');
const { PrismaClient } = require('@prisma/client');
const redis = require('ioredis');

const prisma = new PrismaClient();
const router = express.Router();
const redisClient = new redis();

// Adicionar atividade
router.post('/:unidadeId/atividades', async (req, res) => {
  const { titulo, descricao } = req.body;
  const { unidadeId } = req.params;

  try {
    const atividade = await prisma.atividade.create({
      data: {
        titulo,
        descricao,
        unidadeId: parseInt(unidadeId),
      },
    });

    res.status(201).json(atividade);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao adicionar atividade' });
  }
});

// Consultar resultados de atividades
router.get('/:atividadeId/resultados', async (req, res) => {
  const { atividadeId } = req.params;

  try {
    const resultados = await prisma.resultadoAtividade.findMany({
      where: {
        atividadeId: parseInt(atividadeId),
      },
    });

    res.json(resultados);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao consultar resultados' });
  }
});

module.exports = router;
