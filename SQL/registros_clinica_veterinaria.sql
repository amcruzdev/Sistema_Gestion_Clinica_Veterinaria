USE clinica_veterinaria
-- 1. CLIENTE
INSERT INTO CLIENTE (cc, nombre, telefono, correo) 
VALUES
	('1098123456', 'Juan Pérez Gómez',      '3101234567', 'juan.perez@correo.com'),
	('1098234567', 'María Rodríguez Silva', '3159876543', 'maria.rodriguez@correo.com'),
	('1098345678', 'Carlos Mendoza Ruiz',   '3201112233', NULL),
	('1098456789', 'Ana Beltrán Castro',    '3004445566', 'ana.beltran@correo.com'),
	('1098567890', 'Luis Ortega Vargas',    '3127778899', 'luis.ortega@correo.com');

-- 2. ESPECIE
INSERT INTO ESPECIE (nombre) 
VALUES
	('Perro'),
	('Gato'),    
	('Conejo'),  
	('Ave'),    
	('Hámster'); 

-- 3. RAZA
INSERT INTO RAZA (nombre, id_especie) 
VALUES
	('Labrador',           1),
	('Criollo',            1),
	('Siamés',             2),
	('Criollo',            2), 
	('Holandés',           3), 
	('Canario',            4), 
	('Sirio',              5),
	('Golden Retriever',   1);

-- 4. MASCOTA
INSERT INTO MASCOTA (nombre, sexo, peso_kg, cc, id_raza) VALUES
	('Firulais', 'M', 28.50, '1098123456', 1),
	('Luna',     'H',  4.20, '1098234567', 3),
	('Rocky',    'M', 22.00, '1098345678', 2),
	('Mishi',    'H',  3.80, '1098456789', 4),
	('Bugs',     'M',  2.10, '1098567890', 5), 
	('Canela',   'H', 30.75, '1098123456', 8); 

-- 5. TIPO_SERVICIO (duracion en minutos)
INSERT INTO TIPO_SERVICIO (nombre, duracion) 
VALUES
	('Consulta general',      30),
	('Vacunación',            20), 
	('Baño y peluquería',     60), 
	('Cirugía menor',         90), 
	('Desparasitación',       15); 

-- 6. CARGO
INSERT INTO CARGO (nombre) 
VALUES
	('Veterinario'),           
	('Auxiliar veterinario'),   
	('Peluquero canino'),      
	('Recepcionista'),          
	('Administrador');         

-- 7. EMPLEADO
INSERT INTO EMPLEADO (nombre, id_cargo) 
VALUES
	('Carlos Ramírez',  1),
	('Laura Martínez',  1), 
	('Andrés Torres',   2),
	('Marta Jiménez',   3), 
	('Julián Herrera',  4), 
	('Sofía Castillo',  5); 

-- 8. HORARIO
INSERT INTO HORARIO (inicio, fin, dia, id_empleado) 
VALUES
	('08:00', '12:00', 'LUN', 1),
	('14:00', '18:00', 'LUN', 1),
	('08:00', '12:00', 'MAR', 1),
	('08:00', '12:00', 'MAR', 2),
	('14:00', '18:00', 'MIE', 2),
	('08:00', '12:00', 'JUE', 2),
	('08:00', '14:00', 'SAB', 4),
	('08:00', '16:00', 'LUN', 3);

-- 9. CITA
INSERT INTO CITA (fecha_hora, estado, id_mascota, origen, observaciones, id_tipo_servicio, id_empleado) 
VALUES
	('2026-11-09 08:00:00', 'COMPLETADA', 1, 'AGENDADA',  'Control anual, sin novedades',            1, 1),
	('2026-11-09 09:00:00', 'COMPLETADA', 2, 'AGENDADA',  'Vacuna aplicada, próxima dosis en 1 año',  2, 1),
	('2026-11-10 08:30:00', 'COMPLETADA', 3, 'INMEDIATA', 'Desparasitación sin cita previa',          5, 2),
	('2026-11-14 09:00:00', 'PROGRAMADA', 4, 'AGENDADA',  NULL,                                       3, 4),
	('2026-11-16 10:00:00', 'PROGRAMADA', 5, 'AGENDADA',  NULL,                                       1, 1),
	('2026-11-11 15:00:00', 'CANCELADA',  6, 'AGENDADA',  'El cliente canceló por viaje',             4, 2);

-- 10. PRODUCTO
INSERT INTO PRODUCTO (nombre, tipo, cantidad_stock, precio_venta) 
VALUES
	('Vacuna séxtuple',            'INSUMO',    40,     45000.00), 
	('Antiparasitario oral',       'INSUMO',    30,     18000.00), 
	('Guantes de látex (caja)',    'INSUMO',    20,     25000.00), 
	('Concentrado perro 10 kg',    'CATALOGO',  25,     95000.00), 
	('Arena para gatos 5 kg',      'CATALOGO',  40,     28000.00), 
	('Collar antipulgas',          'CATALOGO',  30,     35000.00); 

-- 11. ACCESO_INSUMO
INSERT INTO ACCESO_INSUMO (id_empleado, id_producto, cantidad, fecha) 
VALUES
	(1, 1, 1, '2026-11-09 09:05:00'),
	(2, 2, 1, '2026-11-10 08:45:00'),
	(3, 3, 2, '2026-11-09 07:50:00'),
	(1, 3, 1, '2026-11-09 08:00:00'),
	(2, 1, 2, '2026-11-10 10:00:00');

-- 12. VENTA
INSERT INTO VENTA (fecha, cc) 
VALUES
	('2026-11-05 10:15:00', '1098123456'), 
	('2026-11-06 16:40:00', '1098234567'), 
	('2026-11-07 11:20:00', '1098345678'), 
	('2026-11-08 09:30:00', '1098456789'), 
	('2026-11-09 12:10:00', '1098567890'); 

-- 13. DETALLE_VENTA
INSERT INTO DETALLE_VENTA (id_venta, cantidad, precio_unitario, id_producto) 
VALUES
	(1, 1, 95000.00, 4),
	(1, 1, 35000.00, 6),
	(2, 2, 28000.00, 5),
	(3, 1, 95000.00, 4),
	(4, 1, 28000.00, 5),
	(4, 1, 35000.00, 6),
	(5, 3, 18000.00, 2);

-- 14. PROVEEDOR
INSERT INTO PROVEEDOR (nombre, telefono, correo) 
VALUES
	('VetPharma S.A.S.',        '6076341122', 'ventas@vetpharma.com'),
	('Distribuidora Mascotas',  '6076455566', 'pedidos@dmascotas.com'),
	('Insumos Médicos del Norte','6076787788', NULL),
	('Alimentos Animal Plus',   '3105559900', 'contacto@animalplus.com'),
	('Laboratorios Vida',       '6076123456', 'info@labvida.com');

-- 15. SUMINISTRO
INSERT INTO SUMINISTRO (fecha, id_proveedor) 
VALUES
	('2026-10-20 09:00:00', 1), -- 1
	('2026-10-22 10:30:00', 2), -- 2
	('2026-10-25 15:00:00', 3), -- 3
	('2026-10-28 11:15:00', 4), -- 4
	('2026-11-02 08:45:00', 5); -- 5

-- 16. DETALLE_SUMINISTRO
INSERT INTO DETALLE_SUMINISTRO (id_suministro, cantidad, id_producto, precio_compra) 
VALUES
	(1, 50, 1, 30000.00),
	(1, 40, 2, 11000.00),
	(2, 30, 5, 18000.00),
	(2, 30, 6, 22000.00),
	(3, 25, 3, 15000.00),
	(4, 30, 4, 70000.00),
	(5, 20, 1, 31000.00);