*** Settings ***
Documentation     Fake MQTT device tester
Library    MQTTLibrary
Library    JsonLibrary.py

*** Variables ***
${BROKER}    broker.emqx.io
${PORT}    1883
${CLIENTID}    rf07012022
${PUBTOPIC}    huld/rfmqtt/sub
${SUBTOPIC}    huld/rfmqtt/pub
@{MESSAGES}    {"id":54, "cmd":"on", "val":"true"}    {"id":55, "cmd":"on", "val":"false"}    {"id":54, "cmd":"on", "val":"false"}    {"id":54, "cmd":"get_status"}
...            {"id":54, "cmd":"lvl", "val":"256"}    {"id":54, "cmd":"lvl", "val":""}    {"id":54, "cmd":"lvl", "val":25}    {"id":54, "cmd":"get_lvl"}

*** Test Cases ***
Connect and Receive Json
    [Documentation]    Validates messages, received
    ...                from device's Pub topic
    Connect    ${BROKER}    ${PORT}    ${CLIENTID}
    ${received}    Subscribe    ${SUBTOPIC}    1    0    30
    Sleep    1s
    FOR    ${message}    IN    @{MESSAGES}
       Publish    ${PUBTOPIC}    ${message}    0
       Sleep    1s
    END
    Sleep    5s
    FOR    ${message}    IN    @{received}
        ${is_json_valid}    Validate Json    ${message}
        Log    ${message} >> ${is_json_valid}
        IF    ${is_json_valid} == False    Fail
    END
