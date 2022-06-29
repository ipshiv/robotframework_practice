*** Settings ***
Documentation    Useful and reusable Keywords
Library    SeleniumLibrary

*** Keywords ***
Accept Cookies On Tori
    [Documentation]    Waits for iFrame and accept all Cookies
    [Arguments]    ${frameid}    ${buttonclass}
    Wait Until Page Contains Element    id=${frameid}
    TRY
        Select Frame    id=${frameid}
    EXCEPT  Element with locator 'id=${frameid}' not found.
        Log    I want some cookies
    FINALLY
        Click Button    class=${buttonclass}
        Log    Button found, agreed with cookie policy!
    END
    Switch Window
