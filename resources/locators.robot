*** Variables ***

# geparametiseerde waarden voor login
${SIGN_IN_BUTTON}             css=[data-test="nav-sign-in"]
${EMAIL_FIELD}                css=[data-test="email"]
${PASSWORD_FIELD}             css=[data-test="password"]
${LOGIN_BUTTON}               css=[data-test="login-submit"]
${REGISTER_BUTTON}            css=[data-test="register-link"]
${DOB_FIELD}                  css=[data-test="dob"]   
${STREET_FIELD}               css=[data-test="street"]
${CITY_FIELD}                 css=[data-test="city"]
${STATE_FIELD}                css=[data-test="state"]
${PC_FIELD}                   css=[data-test="postal_code"]
${PHONE_FIELD}                css=[data-test="phone"]
${EMAIL_FIELD}                css=[data-test="email"]
${COUNTRY_FIELD}              css=[data-test="country"]
${REG_BUTTON}                 css=[data-test="register-submit"]
${PASSWORDSTR}                xpath=//span[normalize-space(.)="Excellent"]

# geparametiseerde waarden voor contactformulier
${CONTACT_LASTNAME_FIELD}     css=[data-test="last-name"]
${CONTACT_FIRSTNAME_FIELD}    css=[data-test="first-name"]
${CONTACT_EMAIL_FIELD}        css=[data-test="email"]
${CONTACT_MESSAGE_FIELD}      css=[data-test="message"]
${CONTACT_SUBJECT_FIELD}      css=[data-test="subject"]
${FILE_INPUT}                 css=[data-test="attachment"]
${CONTACT_SEND_BUTTON}        xpath=//html/body/app-root/div/app-contact/div/div/div/form/div/div[2]/div[4]/input

#geparametisserde waarden voor winkelwagen
${ADD_TO_CART_BUTTON}         xpath=//button[contains(., "Add to cart")]
${CART_LINK}                  xpath=//a[contains(., "Cart")]
${CHECKOUT_BUTTON}            xpath=//button[contains(., "Checkout")]
${TOTAL_PRICE_FIELD}          xpath=//span[@id="total"]
${PLACE_ORDER_BUTTON}         xpath=//button[contains(., "Place Order")]

#geparametiseerde waarden voor bestellen
${SHOPPINGCART}               xpath=//a[@data-test="nav-cart"]
${PROCEED}                    xpath=//*[@data-test="proceed-1"]
${PROCEED2}                   xpath=//*[@data-test="proceed-2"]
${PROCEED3}                   xpath=//*[@data-test="proceed-3"]
${PAYMENT}                    css=[data-test="payment-method"]
${CONFIRMORDER}               css=[data-test="finish"]
${CATAGORY_BUTTON}            css=[data-test="nav-categories"]
${HANDTOOLS}                  css=[data-test="nav-hand-tools"]
${HANDTOOLPRODUCT}            xpath=//h5[@data-test="product-name" and contains(., "Claw Hammer with Shock Reduction Grip")]/ancestor::a    
${INCRQUANT}                  css=[data-test="increase-quantity"]
${ADDTOCART}                  css=[data-test="add-to-cart"]

${POWERTOOLS}                 css=[data-test="nav-power-tools"]
${POWERTOOLPROD}              xpath=//h5[@data-test="product-name" and contains(., "Cordless Drill")]/ancestor::a

#geparametiseerde waarden voor bankoverschrijving
${BANKNAME}                   css=[data-test="bank_name"]
${ACCNAME}                    css=[data-test="account_name"]
${ACCNUMBER}                  css=[data-test="account_number"]

#geparametiseerde waarden voor creditcard
${CCNUMBER}                   css=[data-test="credit_card_number"]
${EXPDATE}                    css=[data-test="expiration_date"]
${CVV}                        css=[data-test="cvv"]
${CCNAME}                     css=[data-test="card_holder_name"]

#geparemetiseerde waarden voor BNPL
${PAYMENTBNPL}                css=[data-test="monthly_installments"]