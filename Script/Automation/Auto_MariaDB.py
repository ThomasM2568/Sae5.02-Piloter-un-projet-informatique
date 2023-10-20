import csv
import mysql.connector
from mysql.connector import Error
import yaml

#------------------------------------------------------------
#                    Database Data
#------------------------------------------------------------

with open("config_db.yml", "r") as fichier_yaml:
    config = yaml.safe_load(fichier_yaml)

try:
    connection = mysql.connector.connect(
            user=config['database']['user'],
            password=config['database']['password'],
            host=config['database']['host'],
            database=config['database']['name'],
            raise_on_warnings=config['database']['raise_on_warnings']
        )
except:
    pass

#------------------------------------------------------------
#                        Opening file
#                      & MariaDB connexion
#------------------------------------------------------------

#fichier_csv = 'db.csv'
fichier_csv = config['database']['dbname']

try:
    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        cursor = connection.cursor()
        
        with open(fichier_csv, 'r') as fichier:
            csv_reader = csv.DictReader(fichier)
            for ligne in csv_reader:
                action = ligne['Action']
                nom = ligne['Nom']
                prenom = ligne['Prenom']
                occupation = ligne['Occupation']
                numero_carte = ligne['N°_Carte']
              
                #------------------------------------------------------------
                #                     Modifying database
                #------------------------------------------------------------
                #Action add +
                if (action == '+'):
                    
                    query = "INSERT INTO Personnel (Nom, Prenom, Occupation, N°_Carte) VALUES (%s, %s, %s, %s)"
                    values = (nom, prenom, occupation, numero_carte)
                    cursor.execute(query, values)
                    connection.commit()
                    print(f"Insertion : {nom} {prenom} - {occupation}")

                #Action remove -
                elif (action == '-'):
                    
                    query = "DELETE FROM Personnel WHERE N°_Carte = %s"
                    values = (numero_carte,)
                    cursor.execute(query, values)
                    connection.commit()
                    print(f"Suppression : {nom} {prenom} - {occupation}")

except Error as e:
    #In order to avoid error
    print("Error :", e)
finally:
    #Close DB connexion when execution is finished
    if (connection.is_connected()):
        cursor.close()
        connection.close()
