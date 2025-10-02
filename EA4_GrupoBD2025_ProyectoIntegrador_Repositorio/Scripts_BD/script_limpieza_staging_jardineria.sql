

-- Limpiando tabla Producto_Staging

-- Reemplazar nulos en dimensiones con 'SIN-DIMENSION'
UPDATE Producto_staging
SET dimensiones = ISNULL(dimensiones, 'SIN-DIMENSION');

-- Asegurar que todos usen '-' en lugar de '/'
UPDATE Producto_staging
SET dimensiones = REPLACE(dimensiones, '/', '-');

-- Reemplazar nulos en descripcion con 'SIN-DESCRIPCION'
UPDATE Producto_staging
SET descripcion = ISNULL(descripcion, 'SIN-DESCRIPCION');