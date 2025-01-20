const express = require('express');
const router = express.Router();
const connection = require('../db/connection');

router.post('/login', (req, res) => {
    const { usuario, password } = req.body;

    const query = 'SELECT id_usuario, nombres, apellidos FROM usuarios WHERE id_usuario = ? AND contraseña = ?';
    connection.query(query, [usuario, password], (err, results) => {
        if (err) {
            console.error('Error al validar usuario:', err);
            return res.status(500).json({ success: false, message: 'Error en el servidor' });
        }

        if (results.length > 0) {
            const { id_usuario, nombres, apellidos } = results[0];
            res.json({
                success: true,
                message: 'Inicio de sesión exitoso',
                user: { id_usuario, nombres, apellidos }
            });
        } else {
            res.json({ success: false, message: 'Usuario o contraseña incorrectos' });
        }
    });
});

module.exports = router;
