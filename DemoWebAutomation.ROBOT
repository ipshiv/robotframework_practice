*** Settings ***
Documentation    Trying Selenium lib and test automation
Test Teardown    Close All Browsers
Library    SeleniumLibrary
Resource    WebKeywords.resource

*** Test Cases ***
Search On Tori
    [Documentation]    Next script does:
    ...                1. Opens tori.fi
    ...                2. Accepts cookies
    ...                3. Searches for levysoitin
    ...                4. Accepts cookies again
    ...                5. Showes results for 5s
    Open Browser    https://www.tori.fi    firefox
    Accept Cookies On Tori    sp_message_iframe_433571    sp_choice_type_11
    Input Text    id=frontSearch    levysoitin
    Click Element    xpath://*[text()='Hae']
    Accept Cookies On Tori    sp_message_iframe_433571    sp_choice_type_11
    Sleep    5
