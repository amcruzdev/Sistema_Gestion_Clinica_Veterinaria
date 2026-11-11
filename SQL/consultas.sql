USE clinica_veterinaria
-- 1. Consultar la agenda de citas veterinarias
SELECT CITA.fecha_hora,
MASCOTA.nombre AS mascota,
CLIENTE.nombre AS propietario,
TIPO_SERVICIO.nombre AS servicio,
EMPLEADO.nombre AS empleado,
CITA.estado
FROM CITA, MASCOTA, CLIENTE, TIPO_SERVICIO, EMPLEADO
WHERE CITA.id_mascota = MASCOTA.id_mascota
AND MASCOTA.cc = CLIENTE.cc
AND CITA.id_tipo_servicio = TIPO_SERVICIO.id_tipo_servicio
AND CITA.id_empleado = EMPLEADO.id_empleado
ORDER BY CITA.fecha_hora ASC;
 
 
-- 2. Consultar el historial de atencion de una mascota
SELECT MASCOTA.nombre AS mascota,
CITA.fecha_hora,
TIPO_SERVICIO.nombre AS servicio,
EMPLEADO.nombre AS empleado,
CITA.observaciones
FROM MASCOTA, CITA, TIPO_SERVICIO, EMPLEADO
WHERE MASCOTA.id_mascota = CITA.id_mascota
AND CITA.id_tipo_servicio = TIPO_SERVICIO.id_tipo_servicio
AND CITA.id_empleado = EMPLEADO.id_empleado
AND MASCOTA.id_mascota = 1
AND CITA.estado = 'COMPLETADA'
ORDER BY CITA.fecha_hora DESC;
 
 
-- 3. Consultar los servicios veterinarios mas solicitados
SELECT TIPO_SERVICIO.nombre AS servicio,
COUNT(CITA.id_cita) AS cantidad_citas
FROM TIPO_SERVICIO, CITA
WHERE TIPO_SERVICIO.id_tipo_servicio = CITA.id_tipo_servicio
AND CITA.estado != 'CANCELADA'
GROUP BY TIPO_SERVICIO.id_tipo_servicio,
TIPO_SERVICIO.nombre
ORDER BY cantidad_citas DESC;
 
 
-- 4. Consultar los empleados con mas citas atendidas
SELECT EMPLEADO.nombre AS empleado,
CARGO.nombre AS cargo,
COUNT(CITA.id_cita) AS citas_atendidas
FROM EMPLEADO, CARGO, CITA
WHERE EMPLEADO.id_cargo = CARGO.id_cargo
AND EMPLEADO.id_empleado = CITA.id_empleado
AND CITA.estado = 'COMPLETADA'
GROUP BY EMPLEADO.id_empleado,
EMPLEADO.nombre, CARGO.nombre
ORDER BY citas_atendidas DESC;
 
 
-- 5. Consultar los clientes que mas utilizan los servicios
SELECT CLIENTE.nombre AS cliente,
CLIENTE.telefono,
COUNT(CITA.id_cita) AS total_citas
FROM CLIENTE, MASCOTA, CITA
WHERE CLIENTE.cc = MASCOTA.cc
AND MASCOTA.id_mascota = CITA.id_mascota
AND CITA.estado = 'COMPLETADA'
GROUP BY CLIENTE.cc,
CLIENTE.nombre, CLIENTE.telefono
ORDER BY total_citas DESC;
 
 
-- 6. Consultar los productos mas vendidos
SELECT PRODUCTO.nombre AS producto,
SUM(DETALLE_VENTA.cantidad) AS unidades_vendidas,
SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario) AS total_ventas
FROM PRODUCTO, VENTA, DETALLE_VENTA
WHERE PRODUCTO.id_producto = DETALLE_VENTA.id_producto
AND VENTA.id_venta = DETALLE_VENTA.id_venta
GROUP BY PRODUCTO.id_producto, PRODUCTO.nombre
ORDER BY unidades_vendidas DESC;
 
 
-- 7. Consultar los ingresos mensuales por ventas
SELECT DATE_FORMAT(VENTA.fecha, '%Y-%m') AS mes,
COUNT(DISTINCT VENTA.id_venta) AS cantidad_ventas,
SUM(DETALLE_VENTA.cantidad * DETALLE_VENTA.precio_unitario) AS ingresos_totales
FROM VENTA, DETALLE_VENTA
WHERE VENTA.id_venta = DETALLE_VENTA.id_venta
GROUP BY DATE_FORMAT(VENTA.fecha, '%Y-%m')
ORDER BY mes ASC;
 
 
-- 8. Consultar los productos con inventario bajo
SELECT PRODUCTO.nombre AS producto,
PRODUCTO.tipo,
PRODUCTO.cantidad_stock,
PRODUCTO.precio_venta
FROM PRODUCTO
WHERE PRODUCTO.cantidad_stock < 30
ORDER BY PRODUCTO.cantidad_stock ASC;
 
 
-- 9. Consultar el consumo de insumos por empleado
SELECT EMPLEADO.nombre AS empleado,
PRODUCTO.nombre AS insumo,
SUM(ACCESO_INSUMO.cantidad) AS cantidad_utilizada
FROM EMPLEADO, PRODUCTO, ACCESO_INSUMO
WHERE EMPLEADO.id_empleado = ACCESO_INSUMO.id_empleado
AND PRODUCTO.id_producto = ACCESO_INSUMO.id_producto
AND PRODUCTO.tipo = 'INSUMO'
GROUP BY EMPLEADO.id_empleado,
EMPLEADO.nombre, PRODUCTO.id_producto, PRODUCTO.nombre
ORDER BY cantidad_utilizada DESC;
 
 
-- 10. Consultar los proveedores con mayor volumen de compras
SELECT PROVEEDOR.nombre AS proveedor,
SUM(DETALLE_SUMINISTRO.cantidad) AS productos_comprados,
SUM(DETALLE_SUMINISTRO.cantidad * DETALLE_SUMINISTRO.precio_compra) AS inversion_total
FROM PROVEEDOR, SUMINISTRO, DETALLE_SUMINISTRO
WHERE PROVEEDOR.id_proveedor = SUMINISTRO.id_proveedor
AND SUMINISTRO.id_suministro = DETALLE_SUMINISTRO.id_suministro
GROUP BY PROVEEDOR.id_proveedor, PROVEEDOR.nombre
ORDER BY inversion_total DESC;
