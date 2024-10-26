# Gestión de Libros con Cassandra y Python

Este proyecto es una aplicación de gestión de libros implementada usando **Cassandra** como sistema de base de datos NoSQL y **Python** para la lógica de aplicación. El proyecto se despliega utilizando **Docker** para facilitar la configuración y ejecución del entorno completo.

## Estructura del Proyecto

La estructura del proyecto está organizada de la siguiente manera:

```
/2da convocatoria
│
├── Parte1/
│   ├── Actividad1.cql          # Archivo original de creación de la base de datos
│   ├── Consultas_tablas.txt    # Descripción de las tablas requeridas
│   └── CrearTablas.cql         # Archivo final para la creación del keyspace y las tablas
│
├── Parte2/
│   ├── main.py                 # Código Python para gestionar datos en Cassandra
│   ├── clases.py               # Definición de clases para entidades y relaciones
│   └── conexion.py             # Código para la conexión con Cassandra
│   └── Dockerfile              # Dockerfile para el entorno Python
│
├── Parte3/
│   ├── migracion.cql           # Definición de la tabla "aire" y otros detalles
│   ├── migracion_comandos.txt  # Comandos para realizar la migración con DataStax Bulk Loader
│   ├── calidadAire.csv         # Archivo CSV para la migración
│   └── reporte_migracion.pdf   # Documento PDF con capturas y explicación de la migración
│
├── docker-compose.yml          # Docker Compose para desplegar todo el proyecto
└── README.md                   # Documentación del proyecto
```


## Descripción del Proyecto

El proyecto consiste en una aplicación para gestionar libros en una base de datos NoSQL Cassandra. Se implementan las siguientes funcionalidades:

1. **Insertar libros**: Permite al usuario agregar nuevos libros a la base de datos, proporcionando detalles como ISBN, título, autor, año de publicación, temas y editorial.
2. **Actualizar libros**: Permite actualizar la información de un libro existente, como el año de publicación.
3. **Eliminar registros**: Permite eliminar registros específicos basados en ciertos criterios, como autores que han ganado un premio específico.
4. **Consultar libros**: Permite consultar información de libros por su ISBN.

## Instalación y Configuración

### Requisitos Previos

- **Docker**: Debes tener Docker y Docker Compose instalados en tu máquina. Puedes seguir las instrucciones en [Docker](https://docs.docker.com/get-docker/).
- **Python 3.9 o superior** (si deseas ejecutar scripts localmente).

### Configuración del Entorno

1. **Clonar el repositorio**:
    ```bash
    git clone https://github.com/AlexPrietoRomani/Sistemas-Almacenamiento-Actividad2
    cd 2da convocatoria
    ```

2. **Construir y ejecutar el entorno Docker**:
    ```bash
    docker-compose up --build
    ```

3. **Verificar el estado de los contenedores**:
    ```bash
    docker-compose ps
    ```

   Asegúrate de que ambos contenedores (`cassandra_db` y `python_app`) estén en estado `Up`.

4. **Acceder a la Aplicación**:
   Si necesitas interactuar con la aplicación manualmente, puedes acceder al contenedor de `python-app`:
   ```bash
   docker exec -it python_app bash
   python main.py
    ```

## Uso de la Aplicación

Una vez que la aplicación esté ejecutándose, verás un menú interactivo con las siguientes opciones:
    ```
    1. Insertar libro
    2. Actualizar año de publicación de un libro
    3. Borrar autores según premio
    4. Consultar libro por ISBN
    0. Cerrar aplicación
    ```

### Ejemplos de Operaciones
1. Insertar un libro:
    - Elige la opción 1 y proporciona la información requerida.
2. Actualizar año de publicación:
    - Elige la opción 2, ingresa el ISBN del libro y el nuevo año.
3. Eliminar autores según premio:
    - Elige la opción 3 e ingresa el nombre del premio.
4. Consultar libro por ISBN:
    - Elige la opción 4 e ingresa el ISBN del libro para ver sus detalles.

## Migración de Datos

**Parte 3: Migración de Datos de Calidad del Aire**

Para realizar la migración de datos del archivo calidadAire.csv a Cassandra:

1. Asegúrate de que Cassandra esté en ejecución:

   ```bash
    docker exec -it cassandra_db cqlsh
    ```  
2. Usar el comando de DataStax Bulk Loader:

   ```bash
    dsbulk load -k alexprieto -t aire -url /2da convocatoria/Parte3/calidadAire.csv -delim ',' -header true
   ```

3. Consulta de datos migrados:

   ```bash
    docker exec -it cassandra_db cqlsh -e "SELECT * FROM alexprieto.aire;"
   ```

## Problemas Comunes

Error: unconfigured table SoporteLibro

Si recibes este error, asegúrate de haber ejecutado correctamente los scripts de creación de tablas. Puedes ejecutar el script manualmente conectándote a cqlsh y usando el archivo CrearTablas.cql.

## Autor

Este proyecto fue desarrollado como parte de un ejercicio práctico de gestión de bases de datos NoSQL en el curso de Sistemas de almacenamiento y gestión Big Data.
