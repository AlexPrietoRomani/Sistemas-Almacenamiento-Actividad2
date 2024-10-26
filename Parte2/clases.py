# Clase que representa un libro en el sistema
class Libro:
    def __init__(self, isbn, titulo, autor, anio, temas, editorial):
        self.isbn = isbn
        self.titulo = titulo
        self.autor = autor
        self.anio = anio
        self.temas = temas
        self.editorial = editorial

# Clase que representa un autor en el sistema
class Autor:
    def __init__(self, nombre, nacionalidad, premios):
        self.nombre = nombre
        self.nacionalidad = nacionalidad
        self.premios = premios