const express = require('express');
const router = express.Router();
const connection = require('../db/connection');

// Ruta para registrar un usuario
router.post('/insertarCaso', (req, res) => {
    const { id_caso, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso } = req.body;

    if (!id_caso|| !nombre_cliente || !direccion_caso|| !fecha_caso|| !ciudad_caso) {
        return res.status(400).json({ message: 'Todos los campos son obligatorios.' });
    }

    const queryCasos = 'SELECT * FROM casos WHERE id_casos = ?';
    connection.query(queryCasos, [id_caso], (err, results) => {
        if (err) {
            console.error('Error al verificar caso:', err);
            return res.status(500).json({ message: 'Error al verificar caso.' });
        }
        if (results.length > 0) {
            return res.status(400).json({ message: 'El caso ya existe.' });
        }

        const queryInsertcasos = 'INSERT INTO casos (id_casos, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso) VALUES (?, ?, ?, ?, ?)';
        connection.query(queryInsertcasos, [id_caso, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso], (err, result) => {
            if (err) {
                console.error('Error al insertar caso:', err);
                return res.status(500).json({ message: 'Error al insertar caso.' });
            }
            res.json({ message: 'Caso insertado exitosamente' });
        });
    });
});

module.exports = router;

