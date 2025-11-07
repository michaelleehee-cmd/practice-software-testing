*** Settings ***
Library      JSONLibrary
Library      SeleniumLibrary 
Library      OperatingSystem
Library      String
Resource     variables.robot
Resource     locators.robot
Resource     env.robot

*** Keywords ***

#Configures screenshot directory for the test suite
Configure Screenshot Directory
    Set Screenshot Directory    ${EXECDIR}/logs/screenshots

Generate Timestamp
    ${ts}=    Evaluate    __import__('datetime').datetime.now().strftime('%Y%m%d_%H%M%S')
    RETURN  ${ts}

Capture Screenshot With Timestamp
    ${timestamp}=    Generate Timestamp
    Capture Page Screenshot    ${TEST_NAME}_${timestamp}.png


#Generates an unique email address for user creation
Generate Unique Email
    ${random}=    Generate Random String    6    [LETTERS]
    ${email}=     Set Variable              test_${random}@testing.com
    RETURN        ${email}


#Launches browser and opens base URL
Open Browser To Base URL
    Open Browser    ${BASE_URL}    ${BROWSER}  ${browser}_profile=${CURDIR}
    Maximize Browser Window


#Login keywords with valid user credentials
Create And Remember User
    ${email}=    Generate Unique Email
    ${password}=    Set Variable    ${USER_PASSWORD}

    # Save user to JSON file for re-use later
    Create File    data/current_user.json    {"email": "${email}", "password": "${password}"}

    # Make the values available in this test run too
    Set Suite Variable    ${CREATED_EMAIL}     ${email}
    Set Suite Variable    ${CREATED_PASSWORD}  ${password}

    Sign in user   

Load Stored User
    ${user}=    Load JSON From File    data/current_user.json
    Set Suite Variable    ${CREATED_EMAIL}      ${user["email"]}
    Set Suite Variable    ${CREATED_PASSWORD}   ${user["password"]}

Login User Failure
    Wait Until Page Contains Element    ${SIGN_IN_BUTTON}    timeout=5s
    Wait Until Element Is Visible       ${SIGN_IN_BUTTON}    timeout=5s
    Click Element                       ${SIGN_IN_BUTTON}
    Wait Until Element Is Visible       ${EMAIL_FIELD}       timeout=5s
    Input Text                          ${EMAIL_FIELD}       ${USER_EMAIL}
    Input Text                          ${PASSWORD_FIELD}    ${USER_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Wait Until Page Contains            Invalid email or password    timeout=10s

Login user
    Wait Until Page Contains Element    ${SIGN_IN_BUTTON}    timeout=5s
    Wait Until Element Is Visible       ${SIGN_IN_BUTTON}    timeout=5s
    Click Element                       ${SIGN_IN_BUTTON}
    Wait Until Element Is Visible       ${EMAIL_FIELD}       timeout=5s
    Input Text                          ${EMAIL_FIELD}        ${CREATED_EMAIL}
    Input Text                          ${PASSWORD_FIELD}     ${USER_PASSWORD_ALT}
    Click Button                        ${LOGIN_BUTTON}
    Wait Until Page Contains            Here you can manage your profile, favorites and orders.    timeout=10s

Sign in user
    Wait Until Page Contains Element    ${SIGN_IN_BUTTON}             timeout=5s
    Wait Until Element Is Visible       ${SIGN_IN_BUTTON}             timeout=5s
    Click Element                       ${SIGN_IN_BUTTON}
    Wait Until Element Is Visible       ${REGISTER_BUTTON}            timeout=5s    
    Click Element                       ${REGISTER_BUTTON}
    Input Text                          ${CONTACT_LASTNAME_FIELD}     ${LAST_NAME}
    Input Text                          ${CONTACT_FIRSTNAME_FIELD}    ${FIRST_NAME}
    Input Text                          ${DOB_FIELD}                  ${DATE_OF_BIRTH}
    Input Text                          ${STREET_FIELD}               ${STREET}
    Input Text                          ${STATE_FIELD}                ${STATE}
    Input Text                          ${CITY_FIELD}                 ${CITY}
    Input Text                          ${PC_FIELD}                   ${POSTAL_CODE}
    Wait Until Element Is Visible       ${COUNTRY_FIELD}              timeout=5s
    Select From List By Value           ${COUNTRY_FIELD}              ${COUNTRY}
    Input Text                          ${PHONE_FIELD}                ${PHONE}
    Input Text                          ${EMAIL_FIELD}                ${CREATED_EMAIL}
    Input Text                          ${PASSWORD_FIELD}             ${USER_PASSWORD_ALT}
    Wait Until Page Contains Element    ${PASSWORDSTR}                timeout=5s
    Click Button                        ${REG_BUTTON}
    Wait Until Element Is Visible       ${LOGIN_BUTTON}               timeout=10s


#Contactform keywords
Assert File Attached
    [Arguments]    ${locator}    ${file_path}
    ${dir}    ${filename}=    Split Path    ${file_path}
    ${value}=    Get Element Attribute    ${locator}    value
    Should Contain    ${value}    ${filename}   

Get Valid File Path
    [Arguments]    ${relative_path}
    ${path}=    Normalize Path    ${CURDIR}/../${relative_path}
    RETURN       ${path} 

Attach file to contact form
    ${FILE_PATH}=  Get Valid File Path    ${RELATIVE_FILE_PATH}
    Choose File                  ${FILE_INPUT}    ${FILE_PATH}
    Assert File Attached         ${FILE_INPUT}    ${FILE_PATH}

Fill and Submit Contact Form
    Go To                        ${BASE_URL}contact
    Input Text                   ${CONTACT_LASTNAME_FIELD}       ${LAST_NAME} 
    Input Text                   ${CONTACT_FIRSTNAME_FIELD}      ${FIRST_NAME}
    Input Text                   ${CONTACT_EMAIL_FIELD}          ${USER_EMAIL} 
    Input Text                   ${CONTACT_MESSAGE_FIELD}        ${CONTACT_MESSAGE}
    Select From List By Label    ${CONTACT_SUBJECT_FIELD}        ${CONTACT_SUBJECT} 
    Attach file to contact form
    Click Button                 ${CONTACT_SEND_BUTTON}
    Wait Until Page Contains     Thanks for your message! We will contact you shortly.  timeout=5s


#Ordering keywords
Go to shoppingcart
    Scroll Element Into View            ${SHOPPINGCART}
    Wait Until Page Contains Element    ${SHOPPINGCART}
    Wait Until Element Is Visible       ${SHOPPINGCART}
    Wait Until Keyword Succeeds         10x    500ms    Click Element    ${SHOPPINGCART}    

Validate Cart Totals
    Wait Until Page Contains Element    xpath=//app-cart//tr[.//*[@data-test='product-title']]    10s

    ${rows}=                Get WebElements    xpath=//app-cart//tr[.//*[@data-test='product-title']]
    ${calculated_total}=    Set Variable    0

    Log To Console    \n--- VALIDATING CART ITEMS ---\n
    Log                Validating cart item totals...

    FOR    ${row}    IN    @{rows}
        # Quantity
        ${qty_el}=    Call Method    ${row}    find_element    xpath    .//input[@data-test\='product-quantity']
        ${qty}=       Get Value      ${qty_el}
        ${qty}=       Convert To Number    ${qty}

        # Unit Price
        ${price_el}=  Call Method    ${row}    find_element    xpath    .//span[@data-test\='product-price']
        ${price}=     Get Text       ${price_el}
        ${price}=     Replace String       ${price}    $    ${EMPTY}
        ${price}=     Convert To Number    ${price}

        # Line Price
        ${line_el}=   Call Method    ${row}    find_element    xpath    .//span[@data-test\='line-price']
        ${line}=      Get Text       ${line_el}
        ${line}=      Replace String       ${line}    $    ${EMPTY}
        ${line}=      Convert To Number    ${line}

        # Validate row math
        ${expected_line}=    Evaluate    ${qty} * ${price}
        Should Be Equal As Numbers       ${expected_line}    ${line}    Line price mismatch! ${qty} × ${price} != ${line}

        # Add to running total
        ${calculated_total}=    Evaluate    round(${calculated_total} + ${line}, 2)

        # Log row info
        Log             Item → Qty: ${qty}, Price: ${price}, Line Total: ${line}
        Log To Console  Qty: ${qty} | Price: ${price} | Line: ${line}
    END

    # Displayed cart total
    ${displayed_total}=    Get Text    xpath=//*[@data-test='cart-total']
    ${displayed_total}=    Replace String    ${displayed_total}    $    ${EMPTY}
    ${displayed_total}=    Convert To Number    ${displayed_total}
    
    Log To Console    \nCalculated total: ${calculated_total}
    Log To Console    Displayed total: ${displayed_total} \n  
    Log               Calculated Total: ${calculated_total}
    Log               Displayed Total: ${displayed_total}

    Should Be Equal As Numbers    ${calculated_total}    ${displayed_total}    Cart total does not match!

Add Products To Cart Handtool
    Wait Until Page Contains Element    ${CATAGORY_BUTTON} 
    Click Element                       ${CATAGORY_BUTTON} 
    Scroll Element Into View            ${HANDTOOLS}   
    Click Element                       ${HANDTOOLS}
    Wait Until Page Contains Element    ${HANDTOOLPRODUCT}
    Click Element                       ${HANDTOOLPRODUCT}
    Wait Until Page Contains Element    ${INCRQUANT}
    Click Element                       ${INCRQUANT}
    Click Button                        ${ADDTOCART}

Add Products To Cart Powertool
    Wait Until Page Contains Element    ${CATAGORY_BUTTON} 
    Click Element                       ${CATAGORY_BUTTON}
    Scroll Element Into View            ${POWERTOOLS}
    Click Element                       ${POWERTOOLS}
    Wait Until Page Contains Element    ${POWERTOOLPROD}
    Click Element                       ${POWERTOOLPROD}
    Wait Until Page Contains Element    ${INCRQUANT}
    Click Element                       ${INCRQUANT}
    Click Button                        ${ADDTOCART}

Proceed To Checkout
    Wait Until Page Contains Element    ${PROCEED}
    Click Element                       ${PROCEED}
    Wait Until Page Contains            Hello Test User, you are already logged in. You can proceed to checkout. 
    Click Element                       ${PROCEED2}
    Click Element                       ${PROCEED3}

Payment CoD
    Wait Until Element Is Visible       ${PAYMENT}          
    Select From List by Label           ${PAYMENT}           Cash on Delivery
    Click Button                        ${CONFIRMORDER}
    Wait Until Page Contains            Payment was successful   

Payment Banktransfer
    Wait Until Element Is Visible       ${PAYMENT}          
    Select From List by Label           ${PAYMENT}           Bank Transfer
    Input Text                          ${BANKNAME}          ABN
    Input Text                          ${ACCNAME}           Test Account 
    Input Text                          ${ACCNUMBER}         123456789
    Click Button                        ${CONFIRMORDER}
    Wait Until Page Contains            Payment was successful    

Payment Creditcard
    Wait Until Element Is Visible       ${PAYMENT}          
    Select From List by Label           ${PAYMENT}           Credit Card
    Input Text                          ${CCNUMBER}          0000-0000-0000-0000
    Input Text                          ${EXPDATE}           12/2027
    Input Text                          ${CVV}               111
    Input Text                          ${CCNAME}            Test User
    Click Button                        ${CONFIRMORDER}
    Wait Until Page Contains            Payment was successful  

Payment BNPL
    Wait Until Element Is Visible       ${PAYMENT}          
    Select From List by Label           ${PAYMENT}           Buy Now Pay Later
    Wait Until Element Is Visible       ${PAYMENTBNPL}
    Select From List by Value           ${PAYMENTBNPL}       12
    Click Button                        ${CONFIRMORDER}
    Wait Until Page Contains            Payment was successful  
