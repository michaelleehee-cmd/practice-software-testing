*** Settings ***
Resource          ../resources/keywords.robot
Suite Setup       Configure Screenshot Directory
Test Teardown     Capture Screenshot With Timestamp    

*** Test Cases ***
User Can Submit Contact Form
    Open Browser To Base URL
    Fill and Submit Contact Form
    Close Browser  
