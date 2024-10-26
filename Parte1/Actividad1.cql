-- Crear el keyspace
CREATE KEYSPACE biblioteca
WITH durable_writes = true 
AND replication = {'class' : 'SimpleStrategy', 'replication_factor' : 1};

-- Crear las tablas
CREATE TABLE biblioteca.Libro (
    ISBN TEXT,
    titulo TEXT,
    anio INT,  -- Cambiar 'año' a 'anio'
    temas SET<TEXT>,
    PRIMARY KEY (ISBN)
);

CREATE TABLE biblioteca.Ejemplar (
    numero UUID,
    status TEXT,
    ISBN TEXT,
    PRIMARY KEY (numero)
);

CREATE TABLE biblioteca.Usuario (
    DNI TEXT,
    nombre TEXT,
    calle TEXT,
    ciudad TEXT,
    PRIMARY KEY (DNI)
);

CREATE TABLE biblioteca.Autor (
    cod UUID,
    nombre TEXT,
    premios SET<TEXT>,
    PRIMARY KEY (cod)
);

CREATE TABLE biblioteca.Editorial (
    cod UUID,
    nombre TEXT,
    direccion TEXT,
    pais_cod UUID,
    PRIMARY KEY (cod)
);

CREATE TABLE biblioteca.Pais (
    cod UUID,
    nombre TEXT,
    PRIMARY KEY (cod)
);

CREATE TABLE biblioteca.Autor_Libro (
    autor_cod UUID,
    libro_ISBN TEXT,
    PRIMARY KEY (autor_cod, libro_ISBN)
);

CREATE TABLE biblioteca.Editorial_Libro (
    editorial_cod UUID,
    libro_ISBN TEXT,
    PRIMARY KEY (editorial_cod, libro_ISBN)
);

CREATE TABLE biblioteca.Prestamo (
    ejemplar_numero UUID,
    usuario_DNI TEXT,
    fecha DATE,
    PRIMARY KEY (ejemplar_numero, fecha)
);

-- Insertar algunos libros
INSERT INTO biblioteca.Libro (ISBN, titulo, anio, temas) 
VALUES ('978-3-16-148410-0', 'El Quijote', 1605, {'Aventura', 'Clasico'});

INSERT INTO biblioteca.Libro (ISBN, titulo, anio, temas) 
VALUES ('978-0-307-26368-2', '1984', 1949, {'Distopia', 'Ciencia Ficcion'});

INSERT INTO biblioteca.Libro (ISBN, titulo, anio, temas) 
VALUES ('978-0-14-028329-7', 'Orgullo y Prejuicio', 1813, {'Romance', 'Clasico'});

INSERT INTO biblioteca.Libro (ISBN, titulo, anio, temas) 
VALUES ('978-0-452-28423-4', 'Matar a un Ruiseñor', 1960, {'Drama', 'Derechos Civiles'});

INSERT INTO biblioteca.Libro (ISBN, titulo, anio, temas) 
VALUES ('978-0-06-088328-7', 'Cien Años de Soledad', 1967, {'Realismo Magico', 'Novela'});

-- Insertar algunos autores
INSERT INTO biblioteca.Autor (cod, nombre, premios) 
VALUES (uuid(), 'Gabriel Garcia Marquez', {'Premio Nobel', 'Premio Romulo Gallegos'});

INSERT INTO biblioteca.Autor (cod, nombre, premios) 
VALUES (uuid(), 'Miguel de Cervantes', {'Premio Nobel'});

INSERT INTO biblioteca.Autor (cod, nombre, premios) 
VALUES (uuid(), 'George Orwell', {'Premio Hugo'});

INSERT INTO biblioteca.Autor (cod, nombre, premios) 
VALUES (uuid(), 'Jane Austen', {'Premio Autora del Año'});

INSERT INTO biblioteca.Autor (cod, nombre, premios) 
VALUES (uuid(), 'Harper Lee', {'Premio Pulitzer'});

-- Insertar más editoriales en la tabla Editorial
INSERT INTO biblioteca.Editorial (cod, nombre, direccion, pais_cod) 
VALUES (uuid(), 'Penguin Books', '123 Penguin St, Londres', uuid());

INSERT INTO biblioteca.Editorial (cod, nombre, direccion, pais_cod) 
VALUES (uuid(), 'Random House', '456 Random Ave, Nueva York', uuid());

INSERT INTO biblioteca.Editorial (cod, nombre, direccion, pais_cod) 
VALUES (uuid(), 'Secker & Warburg', '789 Secker Rd, Londres', uuid());

-- Insertar algunos ejemplares
INSERT INTO biblioteca.Ejemplar (numero, status, ISBN) 
VALUES (uuid(), 'Bueno', '978-3-16-148410-0');

INSERT INTO biblioteca.Ejemplar (numero, status, ISBN) 
VALUES (uuid(), 'Regular', '978-0-06-088328-7');

INSERT INTO biblioteca.Ejemplar (numero, status, ISBN) 
VALUES (uuid(), 'Nuevo', '978-0-307-26368-2');  -- 1984

INSERT INTO biblioteca.Ejemplar (numero, status, ISBN) 
VALUES (uuid(), 'Usado', '978-0-14-028329-7');  -- Orgullo y Prejuicio

INSERT INTO biblioteca.Ejemplar (numero, status, ISBN) 
VALUES (uuid(), 'Bueno', '978-0-452-28423-4');  -- Matar a un Ruiseñor

-- Insertar algunos usuarios
INSERT INTO biblioteca.Usuario (DNI, nombre, calle, ciudad) 
VALUES ('12345678A', 'Juan Perez', 'Calle Falsa 123', 'Madrid');

INSERT INTO biblioteca.Usuario (DNI, nombre, calle, ciudad) 
VALUES ('87654321B', 'Maria Gomez', 'Avenida Siempre Viva', 'Bogotá');

INSERT INTO biblioteca.Usuario (DNI, nombre, calle, ciudad) 
VALUES ('56789012C', 'Luis Fernandez', 'Calle del Sol 45', 'Barcelona');

INSERT INTO biblioteca.Usuario (DNI, nombre, calle, ciudad) 
VALUES ('34567890D', 'Ana Martinez', 'Av. Libertad 67', 'Lima');

INSERT INTO biblioteca.Usuario (DNI, nombre, calle, ciudad) 
VALUES ('23456789E', 'Carlos Gutierrez', 'Calle Mayor 101', 'Buenos Aires');

-- Insertar algunos préstamos
INSERT INTO biblioteca.Prestamo (ejemplar_numero, usuario_DNI, fecha)
VALUES (uuid(), '12345678A', '2024-01-15');

INSERT INTO biblioteca.Prestamo (ejemplar_numero, usuario_DNI, fecha)
VALUES (uuid(), '56789012C', '2024-02-20');  -- Luis Fernandez

INSERT INTO biblioteca.Prestamo (ejemplar_numero, usuario_DNI, fecha)
VALUES (uuid(), '34567890D', '2023-12-01');  -- Ana Martinez

INSERT INTO biblioteca.Prestamo (ejemplar_numero, usuario_DNI, fecha)
VALUES (uuid(), '23456789E', '2024-03-10');  -- Carlos Gutierrez

-- Relacionar más autores con libros en la tabla Autor_Libro
INSERT INTO biblioteca.Autor_Libro (autor_cod, libro_ISBN) 
VALUES (uuid(), '978-0-307-26368-2');  -- George Orwell - 1984

INSERT INTO biblioteca.Autor_Libro (autor_cod, libro_ISBN) 
VALUES (uuid(), '978-0-14-028329-7');  -- Jane Austen - Orgullo y Prejuicio

INSERT INTO biblioteca.Autor_Libro (autor_cod, libro_ISBN) 
VALUES (uuid(), '978-0-452-28423-4');  -- Harper Lee - Matar a un Ruiseñor

-- Relacionar más editoriales con libros en la tabla Editorial_Libro
INSERT INTO biblioteca.Editorial_Libro (editorial_cod, libro_ISBN) 
VALUES (uuid(), '978-0-307-26368-2');  -- Random House - 1984

INSERT INTO biblioteca.Editorial_Libro (editorial_cod, libro_ISBN) 
VALUES (uuid(), '978-0-14-028329-7');  -- Penguin Books - Orgullo y Prejuicio

INSERT INTO biblioteca.Editorial_Libro (editorial_cod, libro_ISBN) 
VALUES (uuid(), '978-0-452-28423-4');  -- Secker & Warburg - Matar a un Ruiseñor

