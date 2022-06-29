*** Settings ***
Documentation    Trying Selenium lib and test automation
Test Teardown    Close All Browsers
Library    SeleniumLibrary
Resource    WebKeywords.resource

*** Test Cases ***
Search On Tori
    [Documentation]    Next script does:
    ...                1. Reads input data from xlsx
    ...                2. Opens tori.fi
    ...                2. Accepts cookies
    ...                3. Searches for data from xlsx selecting region
    ...                4. Accepts cookies again every time tori asks
    ${inputdata}    Read Data From xlsx    Tori_search.xlsx    Sheet1    2    3    5
    Log    ${inputdata}
    Open Browser    https://www.tori.fi    headlessfirefox
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
