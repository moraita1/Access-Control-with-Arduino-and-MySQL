USE DB_TFG;
INSERT INTO TB_TARJETA (UID_TARJETA) VALUES ('034D6011'), ('E770E312'), ('6297C44D'), ('5146A147'), ('21803D47'), 
('C176A209'), ('A3F4FA4D'), ('02C8A150'), ('E67A81B3'), ('8F562492'), 
('3E98B2F6'), ('A71B660D'), ('F5435FE2'), ('D182778C'), ('9C230A12'),('9C230A47');
INSERT INTO TB_USUARIO(nombre_usuario, apellido1_usuario, apellido2_usuario, correo_electronico, tipo_usuario, cod_tarjeta)
VALUES ('Juan', 'García', 'Pérez', 'jgperez@lasalleinstitucion.es', 'alumno', 10),
('María', 'Hernández', 'López', 'mhlópez@lasalleinstitucion.es', 'alumno', 11),
('Pedro', 'Martínez', 'González', 'pmgonzalez@lasalleinstitucion.es', 'alumno', 12),
('Ana', 'González', 'Fernández', 'agfernandez@lasalleinstitucion.es', 'alumno', 13),
('Luis', 'Sánchez', 'García', 'lsgarcia@lasalleinstitucion.es', 'alumno', 14),
('Lucía', 'Jiménez', 'Ramírez', 'ljramirez@lasalleinstitucion.es', 'alumno', 15),
('Pablo', 'Gutiérrez', 'Ortega', 'pgortega@lasalleinstitucion.es', 'alumno', 16),
('Marina', 'Muñoz', 'Castillo', 'mmcalle@lasalleinstitucion.es', 'profesor', 2),
('Antonio', 'Serrano', 'Jiménez', 'asjimenez@lasalleinstitucion.es', 'profesor', 3),
('Carmen', 'López', 'Ruiz', 'clruiz@lasalleinstitucion.es', 'profesor', 4),
('Francisco', 'García', 'Romero', 'fgromero@lasalleinstitucion.es', 'profesor', 5),
('Sara', 'Fernández', 'Jiménez', 'sfjimenez@lasalleinstitucion.es', 'profesor', 6),
('Juan José', 'Martín', 'González', 'jjmgonzalez@lasalleinstitucion.es', 'profesor', 7),
('Elena', 'Pérez', 'Sánchez', 'epsanchez@lasalleinstitucion.es', 'profesor', 8),
('David', 'Ruiz', 'García', 'drgarcia@lasalleinstitucion.es', 'profesor', 9);
INSERT INTO TB_PROFESOR (COD_PROFESOR, DEPARTAMENTO, NIVEL_ENSEÑANZA_EDUCATIVA)
VALUES (8, 'Departamento de redes', 'GRADO_SUPERIOR'),
(9, 'Departamento de sistemas', 'GRADO_SUPERIOR'),
(10, 'Departamento de informatica', 'GRADO_SUPERIOR'),
(11, 'Departamento de redes', 'GRADO_SUPERIOR'),
(12, 'Departamento de sistemas', 'GRADO_SUPERIOR'),
(13, 'Departamento de informatica', 'GRADO_SUPERIOR'),
(14, 'Departamento de redes', 'GRADO_SUPERIOR'),
(15, 'Departamento de sistemas', 'GRADO_SUPERIOR');
INSERT INTO TB_CLASE (NOMBRE_CLASE, PLANTA, EDIFICIO)
VALUES ('Roja', 1, 'FP'),
('Verde', 2, 'FP'),
('Azul', 1, 'FP'),
('Amarilla', 2, 'FP'),
('Naranja', 1, 'FP'),
('Morada', 2, 'FP');
INSERT INTO TB_CICLO (NOMBRE_CICLO) 
VALUES ('GS EI'), 
('GS ASIR'), 
('GS AyF');
INSERT INTO TB_MODULO(NOMBRE_MODULO,HORAS_TOTALES,CURSO,COD_CICLO,COD_CLASE,COD_PROFESOR) VALUES
('Fundamentos del Hardware', 240, 1, 2, 3, 8),
('Gestión de bases de datos', 280, 1, 2, 3, 9),
('Implantación de sistemas operativos', 300, 1, 2, 3, 9),
('Lenguajes de marcas', 220, 1, 2, 3, 11),
('Planificación y administración de redes', 200, 1, 2, 3, 12),
('FOL', 250, 1, 2, 3, 13),
('Administración de SGBD', 250, 2, 2, 6, 9),
('Administración de sistemas operativos', 280, 2, 2, 6, 9),
('Empresa e iniciativa emprendedora', 260, 2, 2, 6, 13),
('Implantación de aplicaciones web', 240, 2, 2, 6, 11),
('Seguridad y alta disponibilidad', 300, 2, 2, 6, 13),
('Servicios de red e Internet', 220, 2, 2, 6, 12);
INSERT INTO TB_ALUMNO_MATRICULA_MODULO(COD_ALUMNO, COD_MODULO, COD_CICLO) 
VALUES (1, 1, 2),
(1, 2, 2),(1, 3, 2),(1, 4, 2),(1, 5, 2),(1, 6, 2),
(2, 1, 2),(2, 2, 2),(2, 3, 2),(2, 4, 2),(2, 5, 2),
(2, 6, 2),(3, 1, 2),(3, 2, 2),(3, 3, 2),(3, 4, 2),
(3, 5, 2),(3, 6, 2),(4, 7, 2),(4, 8, 2),(4, 9, 2),
(4, 10, 2),(4, 11, 2),(4, 12, 2),(5, 7, 2),
(5, 8, 2),(5, 9, 2),(5, 10, 2),(5, 11, 2),(5, 12, 2),
(6, 7, 2),(6, 8, 2),(6, 9, 2),(6, 10, 2),(6, 11, 2),
(6, 12, 2),(7, 7, 2),(7, 8, 2),(7, 9, 2),(7, 10, 2),
(7, 11, 2),(7, 12, 2);  
INSERT INTO TB_HORARIO (DIA_SEMANA, HORA_INICIO,ID_DIA)
VALUES
('LUNES', '8:30',0),('LUNES', '9:25',0),('LUNES', '10:20',0),('LUNES', '11:45',0),('LUNES', '12:40',0),('LUNES', '13:35',0),
('MARTES', '8:30',1),('MARTES', '9:25',1),('MARTES', '10:20',1),('MARTES', '11:45',1),('MARTES', '12:40',1),('MARTES', '13:35',1),
('MIERCOLES', '8:30',2),('MIERCOLES', '9:25',2),('MIERCOLES', '10:20',2),('MIERCOLES', '11:45',2),('MIERCOLES', '12:40',2),('MIERCOLES', '13:35',2),
('JUEVES', '8:30',3),('JUEVES', '9:25',3),('JUEVES', '10:20',3),('JUEVES', '11:45',3),('JUEVES', '12:40',3),('JUEVES', '13:35',3),
('VIERNES', '8:30',4),('VIERNES', '9:25',4),('VIERNES', '10:20',4),('VIERNES', '11:45',4),('VIERNES', '12:40',4),('VIERNES', '13:35',4);
INSERT INTO TB_MODULO_SE_IMPARTE_HORARIO (COD_HORARIO, COD_MODULO, COD_CICLO)
VALUES
(1, 1, 2), (2, 1, 2), (3, 3, 2), (4, 4, 2), (5, 4, 2), (6, 6, 2),
(7, 5, 2), (8, 5, 2), (9, 2, 2), (10, 4, 2), (11, 5, 2), (12, 1, 2),
(13, 6, 2), (14, 5, 2), (15, 5, 2), (16, 4, 2), (17, 3, 2), (18, 1, 2),
(19, 1, 2), (20, 2, 2), (21, 3, 2), (22, 3, 2), (23, 5, 2), (24, 4, 2),
(25, 3, 2), (26, 5, 2), (27, 1, 2), (28, 1, 2), (29, 2, 2), (30, 2, 2),
(1, 7, 2), (2, 7, 2), (3, 9, 2), (4, 10, 2), (5, 10, 2), (6, 12, 2),
(7, 12, 2), (8, 12, 2), (9, 10, 2), (10, 7, 2), (11, 8, 2), (12, 8, 2),
(13, 12, 2), (14, 8, 2), (15, 11, 2), (16, 10, 2), (17, 10, 2), (18, 9, 2),
(19, 12, 2), (20, 12, 2), (21, 7, 2), (22, 8, 2), (23, 8, 2), (24, 10, 2),
(25, 7, 2), (26, 11, 2), (27, 9, 2), (28, 7, 2), (29, 8, 2), (30, 10, 2);