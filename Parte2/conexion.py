from cassandra.cluster import Cluster
import time

def obtener_conexion():
    cluster = None
    while not cluster:
        try:
            # Usa el nombre del servicio del contenedor de Cassandra
            cluster = Cluster(['cassandra'])
            session = cluster.connect()

            # Comprobar si el keyspace ya existe
            keyspaces = session.execute("SELECT keyspace_name FROM system_schema.keyspaces")
            if 'alexprieto' not in [ks.keyspace_name for ks in keyspaces]:
                # Crear el keyspace si no existe
                session.execute("""
                    CREATE KEYSPACE alexprieto 
                    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}
                """)

            # Conectar al keyspace
            session.set_keyspace('alexprieto')
            print("Conexión a Cassandra exitosa")
            return session
        except Exception as e:
            print(f"Intentando conectar a Cassandra, esperando... {e}")
            time.sleep(5)