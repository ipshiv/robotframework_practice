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
    ${inputdata}    Read Data From xlsx    Tori_search.xlsx    Sheet1    2    3    5
    Log    ${inputdata}
    Open Browser    https://www.tori.fi    firefox
    Accept Cookies On Tori    sp_message_iframe_433571    sp_choice_type_11
    Input Text    id=frontSearch    ''
    Click Element    xpath://*[text()='Hae']
    FOR    ${num}    ${data}    IN ENUMERATE    @{inputdata}[request]
        Accept Cookies On Tori    sp_message_iframe_433571    sp_choice_type_11
        Input Text    id=searchtext    ${data}
        Click Element    id=searcharea_expanded
        Select From List By Label    id=searcharea_expanded    ${inputdata}[area][${num}]
        List Selection Should Be    id=searcharea_expanded    ${inputdata}[area][${num}]
        Click Element    xpath://*[text()='Hae']
    END
