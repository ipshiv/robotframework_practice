*** Settings ***
Documentation     Testing Robot Framework basic syntax. *Doc Test* _This should be italic_
...
Default Tags      positive

*** Variables ***
${var1}    4
${var2}    6
@{VARLIST}    4    6
&{VARDICT}    list=@{VARLIST}

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
