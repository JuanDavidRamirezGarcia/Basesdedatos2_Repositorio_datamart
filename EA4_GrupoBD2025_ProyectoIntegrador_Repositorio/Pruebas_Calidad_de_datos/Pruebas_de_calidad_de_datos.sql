--Pruebas de validación de calidad de datos

--Detectando valores nulos y duplicados

--Tabla: dimension_categoría

select * from dimension_Categoria
WHERE Id_categoria IS NULL;

select * from dimension_Categoria
WHERE Desc_categoria IS NULL;

select * from dimension_Categoria
WHERE descripcion_texto IS NULL;

SELECT Id_categoria, Desc_categoria,descripcion_texto, 
(COUNT(*)) as duplicate_count FROM dimension_Categoria
GROUP BY Id_categoria,Desc_categoria,descripcion_texto
having count(*) > 1;


--Tabla: dimension_Productos

select * from dimension_Producto
WHERE ID_producto IS NULL;

select * from dimension_Producto
WHERE nombre IS NULL;

select * from dimension_Producto
WHERE descripcion IS NULL;

select * from dimension_Producto
WHERE categoria IS NULL;

SELECT ID_producto, nombre, dimensiones, descripcion,categoria,
(COUNT(*)) as duplicate_count FROM dimension_Producto
GROUP BY ID_producto, nombre, dimensiones, descripcion,categoria
having count(*) > 1;

--Tabla: dimension_Tiempo

select * from dimension_Tiempo
where id_tiempo is null;

select * from dimension_Tiempo
where fecha_pedido is null;

SELECT Id_tiempo, fecha_pedido,
(COUNT(*)) as duplicate_count FROM dimension_Tiempo
GROUP BY Id_tiempo, fecha_pedido
having count(*) > 1;


--Tabla: hechos_ventas

select * from hechos_Ventas
where ID_producto is null;

select * from hechos_Ventas
where Id_categoria is null;

select * from hechos_Ventas
where Id_tiempo is null;

select * from hechos_Ventas
where cantidad is null;

select * from hechos_Ventas
where precio_unidad is null;

SELECT ID_producto, id_categoria, id_tiempo, cantidad, precio_unidad,
(COUNT(*)) as duplicate_count FROM hechos_Ventas
GROUP BY ID_producto, id_categoria, id_tiempo, cantidad, precio_unidad
having count(*) > 1;

--Producto más vendido

select top 1 hv.ID_producto, dp.nombre, sum(hv.cantidad) as Cantidad_total from hechos_Ventas as hv
join dimension_Producto as dp on dp.ID_producto=hv.ID_producto
group by hv.ID_producto,dp.nombre
order by Cantidad_total desc;


--Categoria con más productos
select top 1 hv.Id_categoria, dc.Desc_categoria, sum(hv.cantidad) as cantidad_total 
from hechos_Ventas as hv
join dimension_Categoria as dc on dc.Id_categoria = hv.Id_categoria
group by hv.Id_categoria, dc.Desc_categoria
order by cantidad_total desc;


-- año con más ventas

select top 1  year(dt.fecha_pedido) as ventas_anual, sum(cantidad*precio_unidad) as total_ventas from hechos_Ventas as hv
join dimension_Tiempo as dt on dt.Id_tiempo=hv.Id_tiempo
group by year(dt.fecha_pedido)
order by total_ventas desc;