const express = require('express');
const router = express.Router();
const connection = require('../db/connection');

// Ruta para registrar un usuario
router.post('/insertarUsuario', (req, res) => {
    const { id, nombres, apellidos, contrasena, rol, correo } = req.body;

    if (!id || !nombres || !apellidos || !contrasena || !rol || !correo) {
        return res.status(400).json({ message: 'Todos los campos son obligatorios.' });
    }

    const queryUsuario = 'SELECT * FROM usuarios WHERE id_usuario = ?';
    connection.query(queryUsuario, [id], (err, results) => {
        if (err) {
            console.error('Error al verificar usuario:', err);
            return res.status(500).json({ message: 'Error al verificar usuario.' });
        }
        if (results.length > 0) {
            return res.status(400).json({ message: 'El usuario ya existe.' });
        }

        const queryInsert = 'INSERT INTO usuarios (id_usuario, nombres, apellidos, contraseña, rol, correo) VALUES (?, ?, ?, ?, ?, ?)';
        connection.query(queryInsert, [id, nombres, apellidos, contrasena, rol, correo], (err, result) => {
            if (err) {
                console.error('Error al insertar usuario:', err);
                return res.status(500).json({ message: 'Error al insertar usuario.' });
            }
            res.json({ message: 'Usuario creado exitosamente' });
        });
    });
});

module.exports = router;

