#-------------------------------------------
#              Module Import
#-------------------------------------------

import paho.mqtt.client as mqtt
import csv
import mariadb

#-------------------------------------------
#               Functions
#-------------------------------------------

def MariaDB_obj(yml_file):
    with open(yml_file, "r") as fichier_yaml:
        config = yaml.safe_load(fichier_yaml)

    try:
        connection = mysql.connector.connect(
                user=config['database']['user'],
                password=config['database']['password'],
                host=config['database']['host'],
                database=config['database']['name'],
                raise_on_warnings=config['database']['raise_on_warnings']
            )
        return mysql.connector.connect(**config)
    except:
        return ""


def check_card(fichier_csv,MariaDB_connector):
    fichier_csv = config['database']['dbname']

    if(MariaDB_connector.is_connected()):
        print("toto")





#-------------------------------------------
#                   Main
#-------------------------------------------

def main():
  '''
  @args:
  None

  @output:
  Hello World
  '''
  print("Hello World")

if __name__ == '__main__':
  main()
