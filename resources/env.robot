*** Settings ***
Resource   variables.robot

*** Variables ***
${ENV}         env
${BASE_URL}    ${NONE}

*** Keywords ***
Load Environment
    Run Keyword If    '${ENV}'=='dev'     Set Variable    ${BASE_URL}    https://practicesoftwaretesting.com/
    Run Keyword If    '${ENV}'=='test'    Set Variable    ${BASE_URL}    https://practicesoftwaretesting.com/
    Run Keyword If    '${ENV}'=='stage'   Set Variable    ${BASE_URL}    https://practicesoftwaretesting.com/
    Run Keyword If    '${ENV}'=='prod'    Set Variable    ${BASE_URL}    https://practicesoftwaretesting.com/
