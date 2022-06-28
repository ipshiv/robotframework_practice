*** Settings ***
Documentation    Trying Selenium lib and test automation
Test Teardown    Close All Browsers
Library    SeleniumLibrary

*** Test Cases ***
Search On Tori
    [Documentation]    Next script does:
    ...                1. Opens tori.fi
    ...                2. Accepts cookies
    ...                3. Searches for levysoitin
    ...                4. Accepts cookies again
    ...                5. Showes results for 5s
    Open Browser    https://www.tori.fi    firefox
    Maximize Browser Window
    Wait Until Page Contains Element    id=sp_message_iframe_433571
    Select Frame    id=sp_message_iframe_433571
    Click Button    class=sp_choice_type_11
    Switch Window
    Input Text    id=frontSearch    levysoitin
    Click Element    xpath://*[text()='Hae']
    Wait Until Page Contains Element    id=sp_message_iframe_433571
    Select Frame    id=sp_message_iframe_433571
    Click Button    class=sp_choice_type_11
    Sleep    5
