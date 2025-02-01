//Ficha 2721427 Analisis y desarrollo de software API GA7-220501096-AA5-EV02
//Proyecto CCM Control y consumo de material
//Integrantes: Caren Carillo
//             Cristhian Rocha
//             Jeison Contreras


const express = require('express');
const bodyParser = require('body-parser');
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(express.static('public')); // Carpeta donde están los archivos estáticos


// Importar rutas
const authRoutes = require('./routes/auth');
const registroRoutes = require('./routes/registros');
const usuariosRoutes = require('./routes/usuarios');
const casosRoutes = require('./routes/casos');

// Ruta para el inicio
app.get('/inicio', (req, res) => {
    res.sendFile(__dirname + '/public/inicio.html'); // Redirige a inicio.html en la carpeta public
});


// Usar rutas
app.use('/auth', authRoutes);
app.use('/registros', registroRoutes);
app.use('/usuarios', usuariosRoutes);
app.use('/casos', casosRoutes);

// Servidor
app.listen(3000, () => {
    console.log(`Servidor escuchando en http://localhost:3000`);
});
