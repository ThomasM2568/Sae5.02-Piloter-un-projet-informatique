import paho.mqtt.client as mqtt
import csv
import datetime

# Paramètres MQTT
mqtt_broker = "10.0.90.200"
mqtt_topic = "RFID"

# Paramètres CSV
csv_file = "log.csv"
lieu = "salle-02"

def on_connect(client, userdata, flags, rc):
    print("Connecté au broker MQTT avec le code de retour : " + str(rc))
    client.subscribe(mqtt_topic)

def on_message(client, userdata, msg):
    badge_id = msg.payload.decode("utf-8")
    date_heure = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Enregistrement des données dans le fichier CSV
    with open(csv_file, mode="a", newline="") as file:
        writer = csv.writer(file)
        writer.writerow([date_heure, badge_id, lieu])
        print(f"Données enregistrées : {date_heure}, {badge_id}, {lieu}")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(mqtt_broker, 1883, 60)

try:
    client.loop_forever()
except KeyboardInterrupt:
    print("Arrêt du script.")

