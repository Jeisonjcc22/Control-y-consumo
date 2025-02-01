const express = require('express');
const router = express.Router();
const connection = require('../db/connection');

// Ruta para insertar un equipo
router.post('/insertarEquipo', (req, res) => {
    const { id_usuario, id_casos, fecha_registro, id_equipo, observaciones } = req.body;

    // Verificar que el usuario exista
    const queryUsuario = 'SELECT * FROM usuarios WHERE id_usuario = ?';
    connection.query(queryUsuario, [id_usuario], (err, results) => {
        if (err) {
            console.error('Error al verificar usuario:', err);
            return res.status(500).send('Error al verificar usuario');
        }
        if (results.length === 0) {
            return res.status(400).send('El usuario no existe');
        }

        // Verificar que el caso exista
        const queryCaso = 'SELECT * FROM casos WHERE id_casos = ?';
        connection.query(queryCaso, [id_casos], (err, results) => {
            if (err) {
                console.error('Error al verificar caso:', err);
                return res.status(500).send('Error al verificar caso');
            }
            if (results.length === 0) {
                return res.status(400).send('El caso no existe');
            }

            // Verificar que el equipo exista
            const queryEquipo = 'SELECT * FROM equipos WHERE id_equipo = ?';
            connection.query(queryEquipo, [id_equipo], (err, results) => {
                if (err) {
                    console.error('Error al verificar equipo:', err);
                    return res.status(500).send('Error al verificar equipo');
                }
                if (results.length === 0) {
                    return res.status(400).send('El equipo no existe');
                }

                // Si todo es válido, proceder a la inserción
                const queryInsert = 'INSERT INTO movimientos (id_usuario, id_casos, fecha_movimientos, id_equipo, observaciones) VALUES (?, ?, ?, ?, ?)';
                connection.query(queryInsert, [id_usuario, id_casos, fecha_registro, id_equipo, observaciones], (err, results) => {
                    if (err) {
                        console.error('Error al insertar equipo:', err);
                        return res.status(500).send('Error al insertar equipo');
                    }
                    res.send('Registro de equipo insertado correctamente');
                });
            });
        });
    });
});


// Ruta para insertar un material
router.post('/insertarMaterial', (req, res) => {
    const { id_usuario, id_casos, fecha_registro, id_material, cantidad, observaciones } = req.body;

    // Verificar que el usuario exista
    const queryUsuario = 'SELECT * FROM usuarios WHERE id_usuario = ?';
    connection.query(queryUsuario, [id_usuario], (err, results) => {
        if (err) {
            console.error('Error al verificar usuario:', err);
            return res.status(500).send('Error al verificar usuario');
        }
        if (results.length === 0) {
            return res.status(400).send('El usuario no existe');
        }

        // Verificar que el caso exista
        const queryCaso = 'SELECT * FROM casos WHERE id_casos = ?';
        connection.query(queryCaso, [id_casos], (err, results) => {
            if (err) {
                console.error('Error al verificar caso:', err);
                return res.status(500).send('Error al verificar caso');
            }
            if (results.length === 0) {
                return res.status(400).send('El caso no existe');
            }

            // Verificar que el material exista
            const queryMaterial = 'SELECT * FROM materiales WHERE id_material = ?';
            connection.query(queryMaterial, [id_material], (err, results) => {
                if (err) {
                    console.error('Error al verificar material:', err);
                    return res.status(500).send('Error al verificar material');
                }
                if (results.length === 0) {
                    return res.status(400).send('El material no existe');
                }

                // Si todo es válido, proceder a la inserción
                const queryInsert = 'INSERT INTO movimientos (id_usuario, id_casos, fecha_movimientos, id_material, cantidad_material, observaciones) VALUES (?, ?, ?, ?, ?, ?)';
                connection.query(queryInsert, [id_usuario, id_casos, fecha_registro, id_material, cantidad, observaciones], (err, results) => {
                    if (err) {
                        console.error('Error al insertar material:', err);
                        return res.status(500).send('Error al insertar material');
                    }
                    res.send('Registro de material insertado correctamente');
                });
            });
        });
    });
});



//Ruta para obtener los registros de la tabla movimientos

router.get('/getRegistros', (req, res) => {
    const { id_usuario, rol } = req.query; // Obtener ID de usuario y rol

    console.log('ID de usuario recibido:', id_usuario, 'Rol:', rol);

    if (!id_usuario || !rol) {
        return res.status(400).send('ID de usuario o rol no proporcionado');
    }

    let query;
    let params = [];

    if (rol === 'admin' || rol === 'supervisor') {
        // Si el rol es administrador o supervisor, obtiene todos los registros
        query = 'SELECT * FROM movimientos';
    } else {
        // Si es usuario normal, filtra por ID de usuario
        query = 'SELECT * FROM movimientos WHERE id_usuario = ?';
        params = [id_usuario];
    }

    connection.query(query, params, (err, results) => {
        if (err) {
            console.error('Error al obtener registros:', err);
            return res.status(500).send('Error al obtener registros');
        }
        res.json(results);
    });
});


module.exports = router;
