-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-02-2025 a las 22:52:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ccm`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casos`
--

CREATE TABLE `casos` (
  `id_casos` varchar(10) NOT NULL,
  `nombre_cliente` varchar(30) NOT NULL,
  `direccion_caso` varchar(20) NOT NULL,
  `fecha_caso` date NOT NULL,
  `ciudad_caso` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `casos`
--

INSERT INTO `casos` (`id_casos`, `nombre_cliente`, `direccion_caso`, `fecha_caso`, `ciudad_caso`) VALUES
('CS000010', 'Coorserpark', 'Carrera 11 # 69 - 11', '2025-01-31', 'Bogota'),
('CS001000', 'Cencosud', 'Cl. 20 #82 - 52', '2024-11-01', 'Bogota'),
('CS001005', 'Flores de Funza', 'Vereda la Argenita, ', '2024-11-08', 'Funza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id_equipo` varchar(16) NOT NULL,
  `nombre_equipo` varchar(30) NOT NULL,
  `descripcion_equipo` text NOT NULL,
  `cantidad_equipo` int(3) NOT NULL,
  `fabricante_equipo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id_equipo`, `nombre_equipo`, `descripcion_equipo`, `cantidad_equipo`, `fabricante_equipo`) VALUES
('CV2219AN1871', 'Router Juniper SRX 300', 'Router Juniper SRX 300', 1, 'Juniper Networks'),
('FJC0153071', 'Switch Cisco Catalyst 2960', 'Switch Cisco Catalyst 2960', 1, 'Cisco'),
('FTX0197374', 'Router Cisco 1941', 'Router Cisco 1941', 1, 'Cisco'),
('FTX0197375', 'Router Cisco 1941', 'Router Cisco 1941 ', 1, 'Cisco');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_movimiento`
--

CREATE TABLE `equipo_movimiento` (
  `id_equipo` varchar(16) NOT NULL,
  `id_movimiento` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `id_material` int(10) NOT NULL,
  `nombre_material` varchar(20) NOT NULL,
  `descripcion_material` text NOT NULL,
  `cantidad_material` int(3) NOT NULL,
  `fabricante_material` varchar(20) NOT NULL,
  `tipo_material` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`id_material`, `nombre_material`, `descripcion_material`, `cantidad_material`, `fabricante_material`, `tipo_material`) VALUES
(1, 'Cable UTP CAT 6', 'Cable UTP CAT 6 para interiores', 360, 'LANPRO', 'Cable'),
(2, 'Cable UTP CAT 6 Exte', 'Cable UTP CAT 6 Exteriores', 250, 'LANPRO', 'Cable'),
(3, 'Bandeja para rack', 'Bandeja para rack 1 unidad de rack', 10, 'INGERACK', 'Rack'),
(4, 'Gabinete Rack', 'Gabinete Rack para 10 unidades', 2, 'INGERACK', 'Rack');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material_movimiento`
--

CREATE TABLE `material_movimiento` (
  `id_material` int(11) NOT NULL,
  `id_movimiento` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id_movimiento` int(6) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_casos` varchar(10) DEFAULT NULL,
  `fecha_movimientos` date NOT NULL,
  `id_equipo` varchar(16) DEFAULT NULL,
  `id_material` int(3) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `cantidad_material` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id_movimiento`, `id_usuario`, `id_casos`, `fecha_movimientos`, `id_equipo`, `id_material`, `observaciones`, `cantidad_material`) VALUES
(1, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas JS v5', NULL),
(2, 1019154549, 'CS001000', '2025-01-18', NULL, 1, 'Pruebas JS V5', 100),
(3, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas J V5', NULL),
(4, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas JS V5', NULL),
(5, 1032418528, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas JS V5', NULL),
(6, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas', NULL),
(7, 1019154549, 'CS001000', '2025-01-18', NULL, 1, 'Pruebas', 100),
(8, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'ASDA\n', NULL),
(9, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'ASDA\n', NULL),
(10, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'ASDASD', NULL),
(11, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas', NULL),
(12, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas 2', NULL),
(13, 1019154549, 'CS001000', '2025-01-18', 'FTX0197374', NULL, 'Pruebas', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol`) VALUES
('admin'),
('supervisor'),
('usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(12) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `contraseña` varchar(15) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `correo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombres`, `apellidos`, `contraseña`, `rol`, `correo`) VALUES
(697293, 'Carlos', 'Perez', '1234carlos', 'usuario', 'carlos.perez@gmail.com'),
(1003837586, 'Cristhian', 'Rocha', '1234cristhian', 'supervisor', 'cristhian.rocha@gmail.com'),
(1011110251, 'Daniela', 'Blanco', '1234daniela', 'usuario', 'daniela.blanco@gmail.com'),
(1019154549, 'Jeison', 'Contreras', '1234jeison', 'admin', 'jeison.contreras@gmail.com'),
(1032418528, 'Caren', 'Carrillo', '1234caren', 'usuario', 'caren.carillo@gmail.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `casos`
--
ALTER TABLE `casos`
  ADD PRIMARY KEY (`id_casos`),
  ADD UNIQUE KEY `id_casos` (`id_casos`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id_equipo`),
  ADD UNIQUE KEY `id_equipo` (`id_equipo`);

--
-- Indices de la tabla `equipo_movimiento`
--
ALTER TABLE `equipo_movimiento`
  ADD KEY `id_equipo` (`id_equipo`),
  ADD KEY `equipo_movimiento_ibfk_2` (`id_movimiento`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`id_material`);

--
-- Indices de la tabla `material_movimiento`
--
ALTER TABLE `material_movimiento`
  ADD KEY `id_material` (`id_material`),
  ADD KEY `id_movimiento` (`id_movimiento`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `FOREING_CASOS` (`id_casos`),
  ADD KEY `movimientos_ibfk_2` (`id_equipo`),
  ADD KEY `movimientos_ibfk_3` (`id_material`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol`),
  ADD UNIQUE KEY `rol` (`rol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `roles_foreingk` (`rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `id_material` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id_movimiento` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `FOREING_CASOS` FOREIGN KEY (`id_casos`) REFERENCES `casos` (`id_casos`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movimientos_ibfk_2` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movimientos_ibfk_3` FOREIGN KEY (`id_material`) REFERENCES `materiales` (`id_material`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `roles_foreingk` FOREIGN KEY (`rol`) REFERENCES `roles` (`rol`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
