const express = require('express');
const router = express.Router();
const connection = require('../db/connection');
const multer = require('multer');
const fs = require('fs');
const Papa = require('papaparse');


// Configuración de multer para subir archivos CSV
const upload = multer({ dest: 'uploads/' });

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


// Ruta para cargar archivo CSV y registrar casos masivamente
router.post('/cargarCasosCSV', upload.single('archivo'), (req, res) => {
    if (!req.file) {
        return res.status(400).json({ message: 'No se subió ningún archivo.' });
    }

    const filePath = req.file.path;

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error al leer el archivo:', err);
            return res.status(500).json({ message: 'Error al procesar el archivo.' });
        }

        Papa.parse(data, {
            header: true,
            skipEmptyLines: true,
            complete: async (result) => {
                const casos = result.data;
                let insertados = 0;
                let duplicados = 0;
                let errores = 0;

                for (const caso of casos) {
                    const { id_caso, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso } = caso;

                    if (!id_caso || !nombre_cliente || !direccion_caso || !fecha_caso || !ciudad_caso) {
                        errores++;
                        continue;
                    }

                    try {
                        const existeCaso = await new Promise((resolve, reject) => {
                            connection.query('SELECT id_casos FROM casos WHERE id_casos = ?', [id_caso], (err, results) => {
                                if (err) reject(err);
                                resolve(results.length > 0);
                            });
                        });

                        if (existeCaso) {
                            duplicados++;
                            continue;
                        }

                        await new Promise((resolve, reject) => {
                            connection.query('INSERT INTO casos (id_casos, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso) VALUES (?, ?, ?, ?, ?)',
                                [id_caso, nombre_cliente, direccion_caso, fecha_caso, ciudad_caso],
                                (err) => {
                                    if (err) reject(err);
                                    resolve();
                                });
                        });

                        insertados++;
                    } catch (error) {
                        console.error('Error en la inserción:', error);
                        errores++;
                    }
                }

                fs.unlink(filePath, (err) => {
                    if (err) console.error('Error al eliminar el archivo:', err);
                });

                res.json({ message: `Carga finalizada. Insertados: ${insertados}, Duplicados: ${duplicados}, Errores: ${errores}` });
            }
        });
    });
});


module.exports = router;

