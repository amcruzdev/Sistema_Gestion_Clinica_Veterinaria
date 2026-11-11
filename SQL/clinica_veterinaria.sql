CREATE DATABASE clinica_veterinaria;
USE clinica_veterinaria;

CREATE TABLE CLIENTE (
	cc VARCHAR(12),
	nombre VARCHAR(80) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	correo VARCHAR(100),
	PRIMARY KEY(cc)
);

CREATE TABLE ESPECIE (
	id_especie INTEGER AUTO_INCREMENT,
	nombre VARCHAR(40) UNIQUE NOT NULL,
	PRIMARY KEY(id_especie)
);

CREATE TABLE RAZA (
	id_raza INTEGER AUTO_INCREMENT,
	nombre VARCHAR(60) NOT NULL,
	id_especie INTEGER NOT NULL,
	PRIMARY KEY(id_raza),
	FOREIGN KEY(id_especie) REFERENCES ESPECIE(id_especie)
);

CREATE TABLE MASCOTA (
	id_mascota INTEGER AUTO_INCREMENT,
	nombre VARCHAR(60) NOT NULL,
	sexo ENUM('M','H') NOT NULL, # M: MACHO, H: HEMBRA
	peso_kg DECIMAL(5,2) NOT NULL,
	cc VARCHAR(12) NOT NULL,
	id_raza INTEGER NOT NULL,
	PRIMARY KEY(id_mascota),
	FOREIGN KEY(cc) REFERENCES CLIENTE(cc),
	FOREIGN KEY(id_raza) REFERENCES RAZA(id_raza)
);

CREATE TABLE TIPO_SERVICIO (
	id_tipo_servicio INTEGER AUTO_INCREMENT,
	nombre VARCHAR(40) NOT NULL UNIQUE,
	duracion INTEGER NOT NULL,
	PRIMARY KEY(id_tipo_servicio)
);

CREATE TABLE CARGO(
	id_cargo INTEGER AUTO_INCREMENT,
	nombre VARCHAR(40) NOT NULL UNIQUE,
	PRIMARY KEY(id_cargo)
);

CREATE TABLE EMPLEADO(
	id_empleado INTEGER AUTO_INCREMENT,
	nombre VARCHAR(40) NOT NULL,
	id_cargo INTEGER NOT NULL,
	PRIMARY KEY(id_empleado),
	FOREIGN KEY(id_cargo) REFERENCES CARGO(id_cargo)
);

CREATE TABLE HORARIO(
	id_horario INTEGER AUTO_INCREMENT,
	inicio TIME NOT NULL,
	fin TIME NOT NULL,
	dia ENUM('LUN','MAR','MIE','JUE','VIE','SAB','DOM') NOT NULL,
	id_empleado INTEGER NOT NULL, 
	PRIMARY KEY(id_horario),
	FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado)	
);

CREATE TABLE CITA(
	id_cita INTEGER AUTO_INCREMENT,
	fecha_hora DATETIME NOT NULL,
	estado ENUM('PROGRAMADA','COMPLETADA','CANCELADA') NOT NULL,
	id_mascota INTEGER NOT NULL,
	origen ENUM('AGENDADA','INMEDIATA') NOT NULL,
	observaciones VARCHAR(300),
	id_tipo_servicio INTEGER NOT NULL,
	id_empleado INTEGER NOT NULL,
	PRIMARY KEY(id_cita),
	FOREIGN KEY(id_mascota) REFERENCES MASCOTA(id_mascota),
	FOREIGN KEY(id_tipo_servicio) REFERENCES TIPO_SERVICIO(id_tipo_servicio), 	
	FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado)
);


CREATE TABLE PRODUCTO (
	id_producto INTEGER AUTO_INCREMENT,
	nombre VARCHAR(80) NOT NULL,
	tipo ENUM('INSUMO','CATALOGO') NOT NULL,
	cantidad_stock INTEGER NOT NULL,
	precio_venta DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(id_producto)	
);


CREATE TABLE ACCESO_INSUMO(
	id_ac_insumo INTEGER AUTO_INCREMENT,
	id_empleado INTEGER NOT NULL,
	id_producto INTEGER NOT NULL,
	cantidad INTEGER NOT NULL,
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id_ac_insumo),
	FOREIGN KEY(id_producto) REFERENCES PRODUCTO(id_producto),
	FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id_empleado)
	
);

CREATE TABLE VENTA(
	id_venta INTEGER AUTO_INCREMENT,
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
	cc VARCHAR(12) NOT NULL,
	PRIMARY KEY(id_venta),
	FOREIGN KEY(cc) REFERENCES CLIENTE(cc)

);

CREATE TABLE DETALLE_VENTA(
	id_detalle_venta INTEGER AUTO_INCREMENT,
	id_venta INTEGER NOT NULL,
	cantidad INTEGER NOT NULL,
	precio_unitario DECIMAL(10,2),
	id_producto INTEGER NOT NULL,
	PRIMARY KEY(id_detalle_venta),
	FOREIGN KEY(id_venta) REFERENCES VENTA(id_venta),
	FOREIGN KEY(id_producto) REFERENCES PRODUCTO(id_producto)
);


CREATE TABLE PROVEEDOR(
	id_proveedor INTEGER AUTO_INCREMENT,
	nombre VARCHAR(80) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	correo VARCHAR(100),
	PRIMARY KEY(id_proveedor)
);

CREATE TABLE SUMINISTRO(
	id_suministro INTEGER AUTO_INCREMENT,
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
	id_proveedor INTEGER NOT NULL,
	PRIMARY KEY(id_suministro),
	FOREIGN KEY(id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE DETALLE_SUMINISTRO(
	id_detalle_suministro INTEGER AUTO_INCREMENT,
	id_suministro INTEGER NOT NULL,
	cantidad INTEGER NOT NULL,
	id_producto INTEGER NOT NULL,
	precio_compra DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(id_detalle_suministro),
	FOREIGN KEY(id_suministro) REFERENCES 
SUMINISTRO(id_suministro),
	FOREIGN KEY(id_producto) REFERENCES PRODUCTO(id_producto)
);