*** Settings ***
Documentation     Testing Robot Framework basic syntax. *Doc Test* _This should be italic_
Test Setup       Log    I'm setup    DEBUG
Test Teardown    Log    I'm Teardown INFO
Library           OperatingSystem

Default Tags      positive

*** Variables ***
${var1}    4
${var2}    6
@{VARLIST}    4    6
@{LONGLIST}    Hello, world!
...            Lorem ipsum
...            dolor sit amet, consectetur adipiscing elit
...            Other typical output
&{VARDICT}    list=@{VARLIST}
${esccharvar}    \x34

*** Test Cases ***
My First Test
    [Documentation]    That's just the test documentation
    Should Be Equal    4    4

Test With Variables
    Should Not Be Equal    ${var1}    ${var2}
    Should Be Equal    ${var1}    ${VARLIST}[0]
    Should Be Equal    ${var2}    ${VARLIST}[1]

Test With Dictionary
    Should Be Equal As Integers    ${VARLIST}[0]    ${VARDICT}[list][0]

Test With Tag
    [Tags]    Always
    Should Not Be Equal    ${var1}    ${var2}

Test Variable With Escape Chars
    [Documentation]    This test shows that variables are text not
    ...                integers and usage of escape characters
    Should Be Equal    ${var1}    ${esccharvar}

Test With Custom Teardown
    Log    No teardown!    INFO
    [Teardown]    NONE

Test with Custom Setup
    [Setup]    NONE
    Log    NoSetup!


*** Keywords ***
My Keyword
    [Arguments]    ${path}
    Directory Should Exist    ${path}
