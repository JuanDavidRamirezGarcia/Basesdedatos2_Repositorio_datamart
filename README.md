#  Proyecto integrador repositorio de todas las actividades

Este repositorio contiene todas las actividades y entregables del curso Bases de Datos II.
En el vas a encontrar los informes de las tres evidencias de aprendizaje, backups de las bases de datos trabajadas y los scripts 
de la creación de las bases de datos, creación de tablas, consultas y de limpieza y transformación de datos.

## Organización del repositorio.

- **Bakups_ModeloEstrella_Jardineria_Staging/**  
  Contiene los respaldos de las bases de datos trabajadas en el curso:
  - jardineriaBD.bak : Base de datos original
  - jardineria_staging.bak: El area staging creada para optimizar, limpiar y transformar los datos de la base de datos **JardineriaBD**
  - modelo_estrellaDB.bak: Data mart final donde trasladamos los datos organizados y limpiados desde el areá staging, el cual se usa para responder a las
    Preguntas del negocio. 
  

- **`Informes_evidencias_de_aprendizaje/`**  
  Esta carpeta incluye los informes de las actividades de aprendizaje del curso:
  
    - EA1_GrupoBD2025_ModeloEstrella_Jardineria
    - EA2_GrupoBD2025_staging_Jardineria
    - EA3_GrupoBD2025_ProcesoETL

- **`Pruebas_Calidad_de_datos/`**  
  Contiene los scripts de consultas realizadas sobre la base de datos **modelo_estrellaDB**, enfocadas en las pruebas de calidad de datos.  
  Entre las validaciones y análisis incluidos se encuentran:  

  - Revisión de datos nulos y duplicados.  
  - Consultas para identificar el **producto más vendido**.  
  - Determinación de la **categoría con mayor número de productos**.  
  - Obtención del **año con más productos vendidos**.  

Estas pruebas permiten evaluar la consistencia e integridad de la base de datos.

- **`Scripts_BD/`**  
  Carpeta con los **scripts SQL** utilizados a lo largo de las evidencias de aprendizaje.  
  Incluye creación de tablas, inserción de datos, consultas, vistas, procedimientos almacenados y otros ejercicios prácticos.



