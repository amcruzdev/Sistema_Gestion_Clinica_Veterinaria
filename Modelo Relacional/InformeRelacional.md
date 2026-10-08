# Informe conversión diagrama ER a modelo relacional
A partir del diagrama entidad relación elaborado en la primera entrega, se crearon cada una de las tablas necesarias teniendo en cuenta las normas para hacer esta transición. 
Teniendo claro lo anterior, inicialmente se establecieron las siguientes tablas:
1.	MascotaCliente
2.	Historial
3.	Servicios
4.	ClienteCatalogo (compra)
5.	CatalogoAdministrador (opera)
6.	Empleado
7.	Administrador
8.	Catalogo
9.	Inventario
10.	Insumos
11.	Proveedor
12.	InventarioProveedor (suministra)
13.	OperadorInsumos (accede)
14.	Operador
15.	Auxiliar
16.	Peluquera
17.	Veterinario
18.	Recepcionista
19.	Auxiliar
20.	OperadorServicios (realiza)
21.	ClienteServicios (agenda)

### Nota: Los paréntesis indican el nombre de la relación entre ellos.

En cuanto a las tablas producto del modelo E-R extendido se indica lo siguiente: 
1.	MascotaCliente surge de la agregación en la que se involucran Mascota y Cliente
2.	Empleado se especializa en Administrador y Operador. Y a su vez Operador se especializa en Auxiliar, Peluquero, Veterinario, Recepcionista y Auxiliar.
3.	Catalogo se especializa en Inventario e Insumos
Antes de comenzar la explicación de la normalización. Se hace necesario indicar que las especializaciones se solucionaron agregando un atributo tipo a la superentidad debido a que no se tenían atributos específicos por subentidad. Esto se hizo para todos a excepción de Catalogo.
Para Catalogo la subentidad Inventario se renombró por producto y el atributo cantidad y id pasaron a formar parte de la super entidad.
Con servicios también se hizo lo mismo, a pesar de que en el diagrama E-R no se estableció como tal una especialización.
Adicionalmente se creó una nueva entidad (tabla) llamada cita que se relaciona con servicio. Cita se relaciona con Mascota y Cliente y Cita mediante ClienteCita

## Forma Normal 1 
1.	Debido a que Historial (2) tiene un atributo multivaluado, se procede a crear una nueva tabla Soporte
2.	La tabla InventarioProveedor (Suministro) al contar con dos atributos multivaluados como cantidadProducto y PrecioVentaProducto exigía una nueva tabla que en este caso se definió como Detalle_Suministro.
3.	La tabla ClienteProducto (Venta) al contar con PrecioVentaProducto y CantidadProducto se estableció una nueva tabla Detalle_Venta
4.	En Servicio también existía un atributo multivaluado observaciones por lo que se creo una tabla adicional con este mismo nombre.

## Forma Normal 2
1.	Dada la agregación definida en E-R para Mascota y Cliente se hizo necesario eliminar esta y definir por separado las tablas Mascota y Cliente para asegurar que cada uno de los atributos no clave dependieran solo del atributo principal.
Forma Normal 3
1.	Se observó que el atributo tipo de Operador no dependía del id_empleado directamente, sino que dependía del cargo por esa razón se creo una nueva entidad llamada Cargo que se relacionara con operador. Evidentemente fue necesario crear un id para cargo

## Nota final 
Es evidente que el proceso de normalización después de haber hecho la transición del diagrama ER al relacional fue muy reducido, lo cual tiene sentido teniendo en cuenta que los diagramas ER ayudan a garantizar que los datos estén estructuras de forma lógica y consistente, de manera que al realizar el proceso de normalización la cantidad de modificaciones sea mínima
