-- Creación del keyspace alexprieto
CREATE KEYSPACE alexprieto WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Uso del keyspace
USE alexprieto;

-- Creación de tablas según los requisitos y consultas previas
CREATE TABLE IF NOT EXISTS Tabla1 (
    Libro_AnioPublicacion INT,
    Libro_Titulo TEXT,
    Libro_Autor TEXT,
    Libro_Editorial TEXT,
    Libro_ISBN TEXT,
    PRIMARY KEY (Libro_AnioPublicacion, Libro_Titulo)
);

CREATE TABLE IF NOT EXISTS Tabla2 (
    Libro_Titulo TEXT,
    Ejemplar_Numero UUID,
    Ejemplar_Estado TEXT,
    Ejemplar_FechaIngreso DATE,
    PRIMARY KEY (Libro_Titulo, Ejemplar_Numero)
);

CREATE TABLE IF NOT EXISTS Tabla3 (
    Autor_Nombre TEXT,
    Libro_Titulo TEXT,
    Libro_ISBN TEXT,
    Libro_AñoPublicacion INT,
    PRIMARY KEY (Autor_Nombre, Libro_Titulo)
);

CREATE TABLE IF NOT EXISTS Tabla4 (
    Libro_Titulo TEXT,
    Ejemplar_Numero UUID,
    Usuario_ID UUID,
    Prestamo_Fecha DATE,
    PRIMARY KEY (Libro_Titulo, Ejemplar_Numero, Usuario_ID)
);

CREATE TABLE IF NOT EXISTS Tabla5 (
    Usuario_Ciudad TEXT,
    Usuario_ID UUID,
    Usuario_Nombre TEXT,
    Usuario_Email TEXT,
    PRIMARY KEY (Usuario_Ciudad, Usuario_ID)
);

CREATE TABLE IF NOT EXISTS Tabla6 (
    Ejemplar_Numero UUID,
    Prestamo_Fecha DATE,
    Prestamo_UsuarioID UUID,
    PRIMARY KEY (Ejemplar_Numero, Prestamo_Fecha)
);

CREATE TABLE IF NOT EXISTS Tabla7 (
    Premio_Nombre TEXT,
    Autor_Nombre TEXT,
    Autor_Pais TEXT,
    Autor_FechaNacimiento DATE,
    PRIMARY KEY (Premio_Nombre, Autor_Nombre)
);

CREATE TABLE IF NOT EXISTS Tabla8 (
    Prestamo_Fecha DATE,
    Ejemplar_Numero UUID,
    Usuario_ID UUID,
    PRIMARY KEY (Prestamo_Fecha, Ejemplar_Numero, Usuario_ID)
);

-- Creación de la tabla SoporteLibro
CREATE TABLE IF NOT EXISTS SoporteLibro (
    ISBN text PRIMARY KEY,
    Titulo text,
    Autor text,
    AnioPublicacion int,
    Temas set<text>,
    Editorial text
);

-- Tabla de soporte para usuarios
CREATE TABLE IF NOT EXISTS SoporteUsuario (
    Usuario_ID UUID PRIMARY KEY,
    Nombre TEXT,
    Direccion TEXT,
    Telefono TEXT,
    Ciudad TEXT
);
