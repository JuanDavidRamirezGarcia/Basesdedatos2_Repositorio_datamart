
---Nota: Para que funcione el Script se debe ejecutar por partes: 
-- primero crear base de datos jardineria_staging
--segundo crear Tablas Staging
-- tercero insertar datos en las tablas


-- 1. Crear la base de datos Staging

CREATE DATABASE jardineria_staging;
GO

USE jardineria_staging;
GO


-- 2. Creación TABLAS STAGING


-- Tabla Staging Producto
CREATE TABLE Producto_staging (
    ID_producto INT PRIMARY KEY,
    nombre NVARCHAR(100),
    dimensiones NVARCHAR(100),
    descripcion NVARCHAR(MAX),
    categoria INT,
    fecha_carga DATETIME DEFAULT GETDATE()
);

-- Tabla Staging Categoría
CREATE TABLE Categoria_staging (
    Id_categoria INT PRIMARY KEY,
    Desc_categoria NVARCHAR(100),
    descripcion_texto NVARCHAR(255),
    fecha_carga DATETIME DEFAULT GETDATE()
);

-- Tabla Staging Tiempo
CREATE TABLE Tiempo_staging (
    Id_tiempo INT PRIMARY KEY,
    fecha_pedido DATE,
    fecha_carga DATETIME DEFAULT GETDATE()
);

-- Tabla Staging Hechos
CREATE TABLE Hechos_staging (
    ID_producto INT,
    Id_categoria INT,
    Id_tiempo INT,
    cantidad INT,
    precio_unidad DECIMAL(10,2),
    fecha_carga DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ID_producto) REFERENCES Producto_staging(ID_producto),
    FOREIGN KEY (Id_categoria) REFERENCES Categoria_staging(Id_categoria),
    FOREIGN KEY (Id_tiempo) REFERENCES Tiempo_staging(Id_tiempo)
);


-- 3. INSERCIÓN DE DATOS


-- Insertar datos en Categoría Staging
INSERT INTO Categoria_staging (Id_categoria, Desc_categoria, descripcion_texto)
SELECT Id_Categoria, Desc_Categoria, descripcion_texto
FROM jardineria.dbo.Categoria_producto;

-- Insertar datos en Producto Staging
INSERT INTO Producto_staging (ID_producto, nombre, dimensiones, descripcion, categoria)
SELECT ID_producto, nombre, dimensiones, descripcion, Categoria
FROM jardineria.dbo.producto;

-- Insertar datos en Tiempo Staging
INSERT INTO Tiempo_staging (Id_tiempo, fecha_pedido)
SELECT DISTINCT ROW_NUMBER() OVER(ORDER BY fecha_pedido) AS Id_tiempo, fecha_pedido
FROM jardineria.dbo.pedido;

-- Insertar datos en Hechos Staging
INSERT INTO Hechos_staging (ID_producto, Id_categoria, Id_tiempo, cantidad, precio_unidad)
SELECT 
    dp.ID_producto,
    p.Categoria AS Id_categoria,
    t.Id_tiempo,
    dp.cantidad,
    dp.precio_unidad
FROM jardineria.dbo.detalle_pedido dp
JOIN jardineria.dbo.producto p ON dp.ID_producto = p.ID_producto
JOIN jardineria.dbo.pedido pe ON dp.ID_pedido = pe.ID_pedido
JOIN Tiempo_staging t ON pe.fecha_pedido = t.fecha_pedido;
