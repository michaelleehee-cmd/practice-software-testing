*** Settings ***
Resource          ../resources/keywords.robot
Suite Setup       Configure Screenshot Directory
Test Teardown     Capture Screenshot With Timestamp

*** Test Cases ***
User Can Place Order CoD
    Open Browser To Base URL
    Load Stored User
    Login user 
    Add Products To Cart Handtool
    Add Products To Cart Powertool
    Go to shoppingcart
    Validate Cart Totals    
    Proceed To Checkout
    Payment CoD
    Close Browser

User Can Place Order Banktransfer
    Open Browser To Base URL
    Load Stored User
    Login user 
    Add Products To Cart Handtool
    Add Products To Cart Powertool
    Go to shoppingcart  
    Validate Cart Totals
    Proceed To Checkout
    Payment Banktransfer
    Close Browser

User Can Place Order Creditcard
    Open Browser To Base URL
    Load Stored User
    Login user 
    Add Products To Cart Handtool
    Add Products To Cart Powertool
    Go to shoppingcart
    Validate Cart Totals    
    Proceed To Checkout
    Payment Creditcard
    Close Browser

User Can Place Order Buy Now Pay Later
    Open Browser To Base URL
    Load Stored User
    Login user 
    Add Products To Cart Handtool
    Add Products To Cart Powertool
    Go to shoppingcart
    Validate Cart Totals    
    Proceed To Checkout
    Payment BNPL
    Close Browser
