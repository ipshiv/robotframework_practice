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

*** Test Cases ***
Connect and Receive Json
    [Documentation]    Validates messages, received
    ...                from device's Pub topic
    Connect    ${BROKER}    ${PORT}    ${CLIENTID}
    ${received}    Subscribe    ${SUBTOPIC}    1    20    15
    Log    ${received}
    FOR    ${message}    IN    @{received}
        ${is_json_valid}    Validate Json    ${message}
        Log    ${message} >> ${is_json_valid}
        IF    ${is_json_valid} == False    Fail
    END
