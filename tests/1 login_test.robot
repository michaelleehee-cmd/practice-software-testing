*** Settings ***
Resource          ../resources/keywords.robot
Suite Setup       Configure Screenshot Directory
Test Teardown     Run Keywords    Capture Screenshot With Timestamp    AND    Close Browser

*** Test Cases ***
Create User And Sign In
    Open Browser To Base URL
    Create And Remember User
    Login user

User can't Login
    Open Browser To Base URL
    Login User Failure

Login Existing User
    Open Browser To Base URL
    Load Stored User
    Login user