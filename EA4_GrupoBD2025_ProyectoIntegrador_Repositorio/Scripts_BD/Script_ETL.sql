


-- 1. Creación data mart final (modelo estrella)

CREATE DATABASE modelo_estrellaDB;
GO

-- 2. Creación de la TABLAS PARA modelo_estrellaDB

USE modelo_estrellaDB;
GO
-- Tabla dimensión Producto

CREATE TABLE dimension_Producto (
    ID_producto INT PRIMARY KEY,
    nombre NVARCHAR(100),
    dimensiones NVARCHAR(100),
    descripcion NVARCHAR(MAX),
    categoria INT,
);

-- Tabla dimensión Categoría

CREATE TABLE dimension_Categoria (
    Id_categoria INT PRIMARY KEY,
    Desc_categoria NVARCHAR(100),
    descripcion_texto NVARCHAR(255),  
);

-- Tabla dimensión Tiempo

CREATE TABLE dimension_Tiempo (
    Id_tiempo INT PRIMARY KEY,
    fecha_pedido DATE,
);

-- Tabla Hechos

CREATE TABLE hechos_Ventas (
    ID_producto INT,
    Id_categoria INT,
    Id_tiempo INT,
    cantidad INT,
    precio_unidad DECIMAL(10,2),
    FOREIGN KEY (ID_producto) REFERENCES dimension_Producto(ID_producto),
    FOREIGN KEY (Id_categoria) REFERENCES dimension_Categoria(Id_categoria),
    FOREIGN KEY (Id_tiempo) REFERENCES dimension_Tiempo(Id_tiempo)
);

--3 Inserción de datos

-- Insertar datos en dimensión_categoria

INSERT INTO dimension_Categoria (Id_categoria, Desc_categoria, descripcion_texto)
SELECT Id_Categoria, Desc_Categoria, descripcion_texto
FROM jardineria_staging.dbo.Categoria_staging;

-- Insertar datos en dimensión_Producto

INSERT INTO dimension_Producto (ID_producto, nombre, dimensiones, descripcion, categoria)
SELECT ID_producto, nombre, dimensiones, descripcion, Categoria
FROM jardineria_staging.dbo.Producto_staging;

-- Insertar datos en dimensión Tiempo

INSERT INTO dimension_Tiempo (Id_tiempo, fecha_pedido)
SELECT Id_tiempo, fecha_pedido
FROM jardineria_staging.dbo.Tiempo_staging;

-- Insertar datos en Hechos_Ventas

INSERT INTO hechos_Ventas (ID_producto, Id_categoria, Id_tiempo, cantidad, precio_unidad)
SELECT ID_producto, Id_categoria, Id_tiempo, cantidad, precio_unidad
FROM jardineria_staging.dbo.Hechos_staging