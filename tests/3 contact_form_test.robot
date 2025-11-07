*** Settings ***
Resource          ../resources/keywords.robot
Suite Setup       Configure Screenshot Directory
Test Teardown     Run Keywords    Capture Screenshot With Timestamp    AND    Close Browser

*** Test Cases ***
User Can Submit Contact Form
    Open Browser To Base URL
    Fill and Submit Contact Form 
