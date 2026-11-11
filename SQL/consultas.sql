USE clinica_veterinaria
-- 1. Consultar la agenda de citas veterinarias
SELECT cita.fecha_hora,
mascota.nombre AS mascota,
cliente.nombre AS propietario,
tipo_servicio.nombre AS servicio,
empleado.nombre AS empleado,
cita.estado
FROM cita, mascota, cliente, tipo_servicio, empleado
WHERE cita.id_mascota = mascota.id_mascota
AND mascota.cc = cliente.cc
AND cita.id_tipo_servicio = tipo_servicio.id_tipo_servicio
AND cita.id_empleado = empleado.id_empleado
ORDER BY cita.fecha_hora ASC;


-- 2. Consultar el historial de atencion de una mascota
SELECT mascota.nombre AS mascota,
cita.fecha_hora,
tipo_servicio.nombre AS servicio,
empleado.nombre AS empleado,
cita.observaciones
FROM mascota, cita, tipo_servicio, empleado
WHERE mascota.id_mascota = cita.id_mascota
AND cita.id_tipo_servicio = tipo_servicio.id_tipo_servicio
AND cita.id_empleado = empleado.id_empleado
AND mascota.id_mascota = 1
AND cita.estado = 'COMPLETADA'
ORDER BY cita.fecha_hora DESC;


-- 3. Consultar los servicios veterinarios mas solicitados
SELECT tipo_servicio.nombre AS servicio,
COUNT(cita.id_cita) AS cantidad_citas
FROM tipo_servicio, cita
WHERE tipo_servicio.id_tipo_servicio = cita.id_tipo_servicio
AND cita.estado != 'CANCELADA'
GROUP BY tipo_servicio.id_tipo_servicio,
tipo_servicio.nombre
ORDER BY cantidad_citas DESC;


-- 4. Consultar los empleados con mas citas atendidas
SELECT empleado.nombre AS empleado,
cargo.nombre AS cargo,
COUNT(cita.id_cita) AS citas_atendidas
FROM empleado, cargo, cita
WHERE empleado.id_cargo = cargo.id_cargo
AND empleado.id_empleado = cita.id_empleado
AND cita.estado = 'COMPLETADA'
GROUP BY empleado.id_empleado,
empleado.nombre, cargo.nombre
ORDER BY citas_atendidas DESC;


-- 5. Consultar los clientes que mas utilizan los servicios
SELECT cliente.nombre AS cliente,
cliente.telefono,
COUNT(cita.id_cita) AS total_citas
FROM cliente, mascota, cita
WHERE cliente.cc = mascota.cc
AND mascota.id_mascota = cita.id_mascota
AND cita.estado = 'COMPLETADA'
GROUP BY cliente.cc,
cliente.nombre, cliente.telefono
ORDER BY total_citas DESC;


-- 6. Consultar los productos mas vendidos
SELECT producto.nombre AS producto,
SUM(detalle_venta.cantidad) AS unidades_vendidas,
SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_ventas
FROM producto, venta, detalle_venta
WHERE producto.id_producto = detalle_venta.id_producto
AND venta.id_venta = detalle_venta.id_venta
GROUP BY producto.id_producto, producto.nombre
ORDER BY unidades_vendidas DESC;


-- 7. Consultar los ingresos mensuales por ventas
SELECT DATE_FORMAT(venta.fecha, '%Y-%m') AS mes,
COUNT(DISTINCT venta.id_venta) AS cantidad_ventas,
SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS ingresos_totales
FROM venta, detalle_venta
WHERE venta.id_venta = detalle_venta.id_venta
GROUP BY DATE_FORMAT(venta.fecha, '%Y-%m')
ORDER BY mes ASC;


-- 8. Consultar los productos con inventario bajo
SELECT producto.nombre AS producto,
producto.tipo,
producto.cantidad_stock,
producto.precio_venta
FROM producto
WHERE producto.cantidad_stock < 30
ORDER BY producto.cantidad_stock ASC;


-- 9. Consultar el consumo de insumos por empleado
SELECT empleado.nombre AS empleado,
producto.nombre AS insumo,
SUM(acceso_insumo.cantidad) AS cantidad_utilizada
FROM empleado, producto, acceso_insumo
WHERE empleado.id_empleado = acceso_insumo.id_empleado
AND producto.id_producto = acceso_insumo.id_producto
AND producto.tipo = 'INSUMO'
GROUP BY empleado.id_empleado,
empleado.nombre, producto.id_producto, producto.nombre
ORDER BY cantidad_utilizada DESC;


-- 10. Consultar los proveedores con mayor volumen de compras
SELECT proveedor.nombre AS proveedor,
SUM(detalle_suministro.cantidad) AS productos_comprados,
SUM(detalle_suministro.cantidad * detalle_suministro.precio_compra) AS inversion_total
FROM proveedor, suministro, detalle_suministro
WHERE proveedor.id_proveedor = suministro.id_proveedor
AND suministro.id_suministro = detalle_suministro.id_suministro
GROUP BY proveedor.id_proveedor, proveedor.nombre
ORDER BY inversion_total DESC;

