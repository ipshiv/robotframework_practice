*** Settings ***
Documentation     Simple Excel automation
Test Teardown    Close All Excel Documents
Library    ExcelLibrary
Library    Collections

*** Variables ***
${ROWSTOREAD}    15
${groups_len}    0
@{groups}

*** Test Cases ***
Read Data Test
    Open Excel Document    Test_messages.xlsx    TMXLS
    ${sheets}    Get List Sheet Names
    FOR    ${sheet}    IN    @{sheets}
        Log    ${sheet}
    END

Read Write Test
    [Documentation]    This simple script does next useful things:
    ...                1. Opens Test_table.xlsx
    ...                2. Copies data from second (message body) and third (message topic or group) columns
    ...                3. Creates list of dictionaries for each topic as 'id' and related messages as 'items'
    ...                4. For each topic creates sheet in new Workbook
    ...                5. Copies messages to sheet
    ...                //TODO Refactoring. Group new topic creation in User Keyword
    Open Excel Document    Test_table.xlsx    TTXLSX
    Get Sheet    Sheet1
    ${message_list}    Read Excel Column    2     1    ${ROWSTOREAD}    Sheet1
    ${group_list}    Read Excel Column    3     1    ${ROWSTOREAD}    Sheet1
    FOR    ${index}    ${element}    IN ENUMERATE    @{message_list}
        IF    '${element}' == 'None'    BREAK
        Log    ${index}: ${element} >> ${group_list}[${index}]
        IF    ${groups_len} == 0
            @{new_list}    Create List   ${element}
            &{new_dict}    Create Dictionary    id=${group_list}[${index}]    items=@{new_list}
            Append To List    ${groups}    ${new_dict}
        ELSE
            Set Local Variable    ${is_found}    0
            FOR    ${group}    IN    @{groups}
                Log    ${group}[id]
                IF    '${group}[id]' == '${group_list}[${index}]'
                    Log    Found ${group}[id]
                    Append To List    ${group}[items]   ${element}
                    Set Local Variable    ${is_found}    1
                END
            END
            IF    ${is_found} == 0
                @{new_list}    Create List   ${element}
                &{new_dict}    Create Dictionary    id=${group_list}[${index}]    items=@{new_list}
                Append To List    ${groups}    ${new_dict}
            END
        END
        Set Global Variable    ${groups_len}    1
    END
    Create Excel Document    outxls
    Switch Current Excel Document    outxls
    FOR    ${element}    IN    @{groups}
        Log    Group: ${element}[id] >> Group: ${element}[items]
        Create Sheet    ${element}[id]
        Write Excel Column    1    ${element}[items]    0    ${element}[id]
    END
    Save Excel Document    Result.xlsx
