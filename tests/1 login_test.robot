*** Settings ***
Resource          ../resources/keywords.robot
Suite Setup       Configure Screenshot Directory
Test Teardown     Capture Screenshot With Timestamp

*** Test Cases ***
Create User And Sign In
    Open Browser To Base URL
    Create And Remember User
    Login user
    Close Browser   

User can't Login
    Open Browser To Base URL
    Login User Failure
    Close Browser

Login Existing User
    Open Browser To Base URL
    Load Stored User
    Login user
    Close Browser