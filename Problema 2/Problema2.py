# Angel David Cuellar
# 23 de Mayo de 2021

# Importamos la libreria
import psycopg2

# Definimos funcion que ejecuta la query en postgres
def ejecutar(db, file, dest):
    # Nos conectamos a la base de datos autenticandonos con los datos
    conn = psycopg2.connect(user="postgres",
                            password="bely1ch0-",
                            host="127.0.0.1",
                            port="5432",
                            database=db)
    cur = conn.cursor()
    # Leemos el archivo
    read = open(file, "r").read()
    # Customizamos la query 
    query = "CREATE TABLE %s AS (%s)" % (dest, read)
    # Ejecutamos la query
    cur.execute(query)
    # Hacemos los cambios en la base de datos
    conn.commit()
    

def menu():
    # Creamos un menu basico con prints e inputs para interactuar con el usuario
    print("BIENVENIDO A ESTE PROGRAMA")
    print("")
    name = input("Por favor ingrese el nombre de la base de datos:")
    print("")
    print("Ingrese el nombre del archivo .sql a ejecutar. Porfavor fijese que el")
    file = input("Archivo este en el mismo directorio que este programa: ")
    print("")
    destino = input("Ingrese el nombre de la base de datos de destino: ")

    ejecutar(name, file, destino)
    
    print("")
    print("Tu programa ha sido exitosamente ejecutado y tu resultado se guardo en "+ destino)
    print("GRACIAS POR USAR ESTE PROGRAMA")

menu()



