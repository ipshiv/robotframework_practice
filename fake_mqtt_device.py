from ast import While
import random
import time
import json

from paho.mqtt import client as mqtt_client


broker = "broker.emqx.io"
port = 1883
topic_sub = "huld/rfmqtt/sub"
topic_pub = "huld/rfmqtt/pub"

dev_id = 54
is_on = True
lvl = 0
# generate client ID with pub prefix randomly
client_id = f"python-mqtt-{random.randint(0, 1000)}"


def connect_mqtt():
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    def parse_mqtt_msg(client, msg):
        global dev_id
        global is_on
        global lvl

        if msg["id"] != dev_id:
            return

        msg_response = ""
        if msg["cmd"] == "on":
            print("INFO - on")
            try:
                if msg["val"] == "true":
                    is_on = True
                elif msg["val"] == "false":
                    is_on = False
                else:
                    print("INFO - not valid message")
                    msg_response = '{"id":%d, "cmd":"%s", "err":39}' % (
                        dev_id,
                        msg["cmd"],
                    )
            except:
                msg_response = '{"id":%d, "cmd":"%s", "err":45}' % (dev_id, msg["cmd"])
            else:
                msg_response = '{"id":%d, "on":"%s"}' % (dev_id, str(is_on).lower())
            finally:
                print("INFO - Response >> " + msg_response)

        elif msg["cmd"] == "get_status":
            print("INFO - get_status >>" + str(is_on))
            msg_response = '{"id":%d, "on":"%s"}' % (dev_id, str(is_on).lower())
        elif msg["cmd"] == "lvl":
            print("INFO - lvl")
            try:
                if msg["val"] <= 255 and msg["val"] >= 0:
                    lvl = msg["val"]
                else:
                    print("INFO - not valid message")
                    msg_response = '{"id":%d, "cmd":"%s", "err":39}' % (
                        dev_id,
                        msg["cmd"],
                    )
            except:
                msg_response = '{"id":%d, "cmd":"%s", "err":45}' % (dev_id, msg["cmd"])
            else:
                msg_response = '{"id":%d, "lvl":%d}' % (dev_id, lvl)
            finally:
                print("INFO - Response >> " + msg_response)
        elif msg["cmd"] == "get_lvl":
            print("INFO - get_lvl >> " + str(lvl))
            msg_response = '{"id":%d, "lvl":%d}' % (dev_id, lvl)
        else:
            print("INFO - not valid message")
        if msg_response != "":
            client.publish(
                topic_pub,
                msg_response,
            )

    def on_message(client, userdata, message):
        print("<< Message received " + message.payload.decode())
        msg = {}
        try:
            msg = json.loads(message.payload.decode())
        except json.JSONDecodeError:
            print("!!!! - ERR: not JSON format")
        else:
            parse_mqtt_msg(client, msg)

    client = mqtt_client.Client(client_id)
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect(broker, port)
    return client


def publish(client, msg_count):
    time.sleep(1)
    msg = '{"id":%d,"temp":%d}' % (dev_id, msg_count * 2 + msg_count)
    result = client.publish(topic_pub, msg)
    status = result[0]
    if status == 0:
        print(f">> Send `{msg}` to topic `{topic_pub}`")
    else:
        print(f">> Failed to send message to topic {topic_pub}")


def run():
    client = connect_mqtt()
    client.subscribe(topic_sub, qos=0)
    client.publish(
        topic_pub,
        '{"emei": 123456789, "status": 1}',
    )
    client.loop_start()
    for i in range(0, 10):
        publish(client, i)
    time.sleep(30)


if __name__ == "__main__":
    run()
