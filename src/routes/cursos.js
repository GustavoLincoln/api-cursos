const express = require('express');
const { PrismaClient } = require('@prisma/client');
const redis = require('ioredis');

const prisma = new PrismaClient();
const router = express.Router();
const redisClient = new redis();

// Verifica se o Redis está conectado corretamente
redisClient.on('connect', () => {
    console.log('Conectado ao Redis');
});

redisClient.on('error', (err) => {
    console.error('Erro no Redis:', err);
});

// Rota GET para listar cursos
router.get('/', async (req, res) => {
    const cacheKey = 'cursos-lista';

    try {
        // Verificar se a lista de cursos está no cache
        const cachedCursos = await redisClient.get(cacheKey);

        if (cachedCursos) {
            console.log('Retornando cursos do cache');
            return res.json(JSON.parse(cachedCursos));  // Retorna do cache
        }

        // Caso não esteja no cache, faz a consulta no banco de dados
        const cursos = await prisma.curso.findMany({
            include: {
                unidades: true, // Inclui unidades com cada curso
            },
        });

        // Armazena a resposta no Redis com validade de 10 segundos (exemplo para teste)
        await redisClient.setex(cacheKey, 10, JSON.stringify(cursos));

        // Retorna a resposta para o cliente
        console.log('Retornando cursos do banco');
        res.json(cursos);
    } catch (error) {
        console.error('Erro ao buscar cursos:', error);
        res.status(500).json({ error: 'Erro ao listar cursos' });
    }
});

// router.get('/', async (req, res) => {
//     const cursos = await prisma.curso.findMany();
//     res.json(cursos);
//   });

module.exports = router;
