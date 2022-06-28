*** Settings ***
Documentation     Simple Excel automation
Test Teardown    Close All Excel Documents
Library    ExcelLibrary

*** Test Cases ***
Read Data Test
    Open Excel Document    Test_messages.xlsx    TMXLS
    ${sheets}    Get List Sheet Names
    FOR    ${sheet}    IN    @{sheets}
        Log    ${sheet}
    END
