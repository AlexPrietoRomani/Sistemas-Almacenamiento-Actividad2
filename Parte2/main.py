from conexion import obtener_conexion
from clases import Libro, Autor

# Conectar a Cassandra
session = obtener_conexion()

# Función para crear las tablas usando el archivo CrearTablas.cql
def crear_tablas():
    try:
        with open("/2da convocatoria/Parte1/CrearTablas.cql", "r") as f:
            comandos = f.read().split(";")
            for comando in comandos:
                if comando.strip():
                    session.execute(comando.strip())
    except Exception as e:
        print(f"Error al crear tablas: {e}")

# Funciones para gestión de datos en Cassandra usando objetos de las clases
def insertar_libro():
    try:
        # Solicitar datos del libro al usuario
        isbn = input("Dame el ISBN del libro: ")
        titulo = input("Dame el título del libro: ")
        autor = input("Dame el autor del libro: ")
        anio = int(input("Dame el año de publicación: "))
        temas = input("Introduce los temas del libro (separados por coma): ").split(',')
        editorial = input("Dame el nombre de la editorial: ")

        # Crear un objeto Libro usando la clase
        libro = Libro(isbn, titulo, autor, anio, set(temas), editorial)

        # Insertar el libro en la base de datos
        insert_statement = session.prepare(
            "INSERT INTO SoporteLibro (ISBN, Titulo, Autor, AnioPublicacion, Temas, Editorial) VALUES (?, ?, ?, ?, ?, ?)"
        )
        session.execute(insert_statement, [libro.isbn, libro.titulo, libro.autor, libro.anio, libro.temas, libro.editorial])

        print("Libro insertado exitosamente.")

    except ValueError as ve:
        print(f"Error en los datos introducidos: {ve}")
    except Exception as e:
        print(f"Error al insertar el libro en la base de datos: {e}")

def actualizar_anio_publicacion_libro():
    try:
        # Solicitar ISBN y nuevo año de publicación
        isbn = input("Dame el ISBN del libro que deseas actualizar: ")
        nuevo_anio = int(input("Dame el nuevo año de publicación: "))

        # Preparar y ejecutar la actualización en la base de datos
        update_statement = session.prepare("UPDATE SoporteLibro SET AnioPublicacion = ? WHERE ISBN = ?")
        session.execute(update_statement, [nuevo_anio, isbn])

        print("Año de publicación actualizado exitosamente.")

    except ValueError as ve:
        print(f"Error en los datos introducidos: {ve}")
    except Exception as e:
        print(f"Error al actualizar el año de publicación: {e}")

def borrar_autores_por_premio():
    try:
        # Solicitar el nombre del premio al usuario
        premio = input("Introduce el nombre del premio: ")

        # Preparar y ejecutar la eliminación en la base de datos
        delete_statement = session.prepare("DELETE FROM Tabla7 WHERE Premio_Nombre = ?")
        session.execute(delete_statement, [premio])

        print(f"Autores que ganaron el premio '{premio}' han sido eliminados.")

    except Exception as e:
        print(f"Error al intentar borrar autores: {e}")

def consultar_libro_por_isbn():
    try:
        isbn = input("Dame el ISBN del libro a consultar: ")
        
        # Prepara la consulta para buscar el libro por ISBN
        select_statement = session.prepare("SELECT * FROM SoporteLibro WHERE ISBN = ?")
        
        # Ejecuta la consulta en Cassandra
        filas = session.execute(select_statement, [isbn])
        
        # Imprime los resultados si se encuentra el libro
        encontrado = False
        for fila in filas:
            libro = Libro(fila.isbn, fila.titulo, fila.autor, fila.aniopublicacion, fila.temas, fila.editorial)
            print(f"Título: {libro.titulo}, Autor: {libro.autor}, Año: {libro.anio}, Temas: {libro.temas}")
            encontrado = True
        
        if not encontrado:
            print("No se encontró ningún libro con ese ISBN.")

    except Exception as e:
            print(f"Error al consultar el libro: {e}")
            
def insertar_autor():
    try:
        # Solicitar nombre, nacionalidad y premios
        nombre = input("Dame el nombre del autor: ")
        nacionalidad = input("Dame la nacionalidad del autor: ")
        premios = input("Introduce los premios del autor (separados por coma): ").split(',')

        # Crear un objeto Autor usando la clase
        autor = Autor(nombre, nacionalidad, set(premios))

        # Insertar el Autor en la base de datos
        insert_statement = session.prepare(
            "INSERT INTO Autores (Nombre, Nacionalidad, Premios) VALUES (?, ?, ?)"
        )
        session.execute(insert_statement, [autor.nombre, autor.nacionalidad, autor.premios])

        print("Autor insertado exitosamente.")

    except Exception as e:
        print(f"Error al insertar el autor: {e}")

def consultar_libro_por_autor():
    try:
        autor = input("Dame el nombre del autor para consultar sus libros: ")
        select_statement = session.prepare("SELECT * FROM SoporteLibro WHERE Autor = ?")
        filas = session.execute(select_statement, [autor])
        
        encontrado = False
        for fila in filas:
            libro = Libro(fila.isbn, fila.titulo, fila.autor, fila.aniopublicacion, fila.temas, fila.editorial)
            print(f"Título: {libro.titulo}, ISBN: {libro.isbn}, Año: {libro.anio}, Temas: {libro.temas}")
            encontrado = True
        
        if not encontrado:
            print("No se encontraron libros para ese autor.")

    except Exception as e:
        print(f"Error al consultar libros por autor: {e}")

# Interfaz de usuario para interactuar con el sistema
def main():
    try:
        crear_tablas()
        while True:
            print("\n1. Insertar libro")
            print("2. Actualizar año de publicación de un libro")
            print("3. Borrar autores según premio")
            print("4. Consultar libro por ISBN")
            print("5. Insertar autor")
            print("6. Consultar libros por autor")
            print("0. Cerrar aplicación")
            
            opcion = input("Selecciona una opción: ")
            if opcion == "1":
                insertar_libro()
            elif opcion == "2":
                actualizar_anio_publicacion_libro()
            elif opcion == "3":
                borrar_autores_por_premio()
            elif opcion == "4":
                consultar_libro_por_isbn()
            elif opcion == "5":
                insertar_autor()
            elif opcion == "6":
                consultar_libro_por_autor()
            elif opcion == "0":
                print("Cerrando la aplicación...")
                session.shutdown()
                break
            else:
                print("Opción incorrecta. Intenta nuevamente.")
    except Exception as e:
        print(f"Error en la aplicación: {e}")
    finally:
        # Mantener el contenedor activo, incluso si hay errores
        while True:
            pass

if __name__ == "__main__":
    main()