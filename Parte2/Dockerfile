# Usa una imagen base de Python
FROM python:3.9-slim

# Instalar librerías necesarias
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Instala la librería de Cassandra
RUN pip install cassandra-driver

# Copia el código de la Parte 2 al contenedor
WORKDIR /app
COPY . /app

# Define el comando por defecto (puedes cambiarlo según sea necesario)
CMD ["python", "main.py"]