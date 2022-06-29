*** Settings ***
Documentation    Useful and reusable Keywords
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections

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
        TRY
            Click Button    class=${buttonclass}
        EXCEPT
            Log    No Button!!!
        END
        Log    Button found, agreed with cookie policy!
    END
    Switch Window

Read Data From xlsx
    [Documentation]    Reads Columns and returns them as a Dictionary
    ...                with fields named as in XLSX header
    ...                workbook - workbook's name including extension
    ...                sheet - sheet's name
    ...                firstcolumn - column to start reading from (starting from 1)
    ...                coulmnstoread - num of columns containing data (should be more than 0)
    ...                maxdatarange -  max number of rows to read
    [Arguments]    ${workbook}    ${sheet}    ${firstcolumn}    ${coulmnstoread}    ${maxdatarange}
    &{retdict}    Create Dictionary
    IF    ${coulmnstoread} == 0
        RETURN    &{retdict}
    END
    IF    '${workbook}' == ''
        RETURN    &{retdict}
    END
    IF    '${sheet}' == ''
        RETURN    &{retdict}
    END
    Open Excel Document    ${workbook}    wb
    Get Sheet    ${sheet}
    ${colunminheader}    Evaluate    ${firstcolumn} - 1
    ${headers}   Read Excel Row    1    ${colunminheader}    ${coulmnstoread}
    FOR    ${count}    ${header}    IN ENUMERATE    @{headers}
        Log    ${header}
        ${columntoread}    Evaluate    ${firstcolumn} + ${count}
        ${items}    Read Excel Column    ${columntoread}    1    ${maxdatarange}
        Set To Dictionary    ${retdict}    ${header}=${items}
    END
    RETURN    &{retdict}
