*** Settings ***
Library           Selenium2Library
Resource          Test_data_Indo.txt
Resource          Object_repo_FF.txt

*** Test Cases ***
_simple_test_chrome
    [Documentation]    Discontinued due to pop up that cannot be handled after login to facebook.
    Open Browser    ${URL}    ${webDriver_Chrome}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    #Close Browser

_simple_test_ie
    [Documentation]    discontinued due to additional setting on IE is required
    Open Browser    ${URL}    ${webDriver_IE}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    #Close Browser

_simple_test_safari
    [Documentation]    This test case is an example for login from main FB and then select messenger; not relevant.
    Login_FB    ${webDriver_safari}
    Wait Until Page Contains    Beranda    20s    None
    Sleep    5s
    Click Element    ${messengericon_obj}
    Wait Until Page Contains    Lihat Semua di Messenger    20s    None
    Sleep    5s
    Click Link    Lihat Semua di Messenger
    Wait Until Page Contains    Messenger    5s    None
    Sleep    10s
    Click Element    //*[@data-href="https://www.facebook.com/messages/t/telkomsel"]
    Sleep    10s
    Click Element    ${inputtext_obj}
    Input Text    ${inputtext_obj}    ${random_question_1}
    Sleep    10s

simple_carousel_ff
    [Documentation]    this is created to test carousel on ff, it is expected that carousel is already exists on the chat.
    [Setup]
    Open_Web_Messenger    ${webDriver_Chrome}
    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_Carousel    ${Carousel_title}    ${Carousel_button}
    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    2s
    ...    AND    Click Element    //*[@${carouselclass_obj} and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]
    ...    AND    Sleep    2s
    ...    ELSE    Swipe_until_element    ${Carousel_title}    ${Carousel_button}
    ${URLS}    Get Locations
    #Capture Page Screenshot    new_browser.png
    Sleep    2s
    [Teardown]    Close All Browsers

test_Messenger_VAnotUnderstand
    [Documentation]    Here user ask question which is not in FAQ
    Open_Web_Messenger    ${webDriver_Chrome}
    User_input    ${random_question_1}
    Sleep    5s
    Check_VA_response    ${VA_notunderstand_1}
    #Check_VA_response    ${VA_notunderstand_2}
    Capture Page Screenshot    first_response_NU.png
    User_input    ${random_question_2}
    Sleep    5s
    #Check_VA_response    ${VA_notunderstand_6}
    Capture Page Screenshot    second_response_NU.png
    #Click Element    ${inputtext2_obj}
    User_input    ${cancel_answer}
    Sleep    10s
    Check_VA_response    ${VA_cancel}
    Check_VA_response    ${VA_question_1}
    #Click Element    ${inputtext2_obj}
    #Sleep    2s
    User_input2    ${no_answer}
    Sleep    5s
    Check_VA_response    ${VA_question_2}
    User_input2    ${user_rate}
    Capture Page Screenshot    user_rate.png
    Check_VA_response    ${VA_question_3}
    #Validate buttons here???!!!
    User_input2    ${select_Rate}
    Sleep    2s
    Check_VA_response    ${VA_askRateReason}
    User_input2    ${no_answer}
    Sleep    2s
    Check_VA_response    ${VA_thanksRate}
    #[Teardown]    Close Browser

test_Messenger_askPulsaKuota
    [Documentation]    Here registered user ask for both pulsa and kuota, without top-up.
    Open_Web_Messenger    ${webDriver_Chrome}
    Greet_VA_Indo
    User_input    ${ask_pulsa}
    Sleep    10s
    Capture Page Screenshot    first_response_pulsa.png
    ${result}    Run Keyword and Return Status    Wait Until Page Contains    ${VA_validateNumber}    10s    None
    Run Keyword If    ${result}    Click_Yes
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(text(),'${VA_answerPulsa1}')]
    Capture Page Screenshot    second_response_pulsa.png
    Wait Until Page Contains    ${VA_answerPulsa2}    10s    None
    Wait Until Page Contains    ${yes_answer}    5s    None
    Wait Until Page Contains    ${no_answer}    5s    None
    User_input    ${ask_kuota}
    Capture Page Screenshot    first_response_kuota.png
    Sleep    2s
    Check_VA_response    ${VA_answerKuota2}
    #Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(text(),'${VA_answerKuota2}')]
    Wait Until Page Contains    ${VA_answerKuota3}    10s    None
    Click_No
    Sleep    5s
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(text(),'${VA_question_1}')]
    #Click Element    ${inputtext2_obj}
    Sleep    2s
    User_input    ${no_answer}
    Sleep    5s
    #${justcheck}    Get Element Count    //*[@class='_3oh- _58nk' and contains(.,'${VA_question_2}')]
    #(//*[@class='_3oh- _58nk' and contains(.,'${VA_question_2}')])[12]
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(.,'${VA_question_2}')]
    User_input    ${user_rate}
    Capture Page Screenshot    user_rate.png
    Wait Until Page Contains    ${VA_question_3}    10s    None
    #Validate buttons here???!!!
    User_input    ${select_Rate}
    Sleep    2s
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(.,'${VA_askRateReason}')]
    User_input    ${no_answer}
    Sleep    2s
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(.,'${VA_thanksRate}')]
    #[Teardown]    Close Browser

*** Keywords ***
Login_FB
    [Arguments]    ${webdriver}
    [Documentation]    This keyword is to open FB page, not relevant.
    Open Browser    ${URL}    ${webdriver}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None

Open_Web_Messenger
    [Arguments]    ${webdriver}
    [Documentation]    This keyword is to open and login to FB messenger on web.
    Open Browser    ${URLmessengerTSEL}    ${webdriver}
    Maximize Browser Window
    Sleep    7s
    Click Element    ${email_obj}
    Input Text    ${email_obj}    ${email}
    Click Element    ${password_obj}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None
    Sleep    10s

Select_Carousel
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    [Documentation]    This keyword to get the location of a number of elements for carousel.
    ${totalicon}    Get Element Count    ${tselicon_obj}
    ${tsel_icon_locationX}    Get Horizontal Position    (${tselicon_obj})[${totalicon}]
    ${element_XBegin}    Get Horizontal Position    //a[contains(.,'${Carousel_button}')]/preceding::*[@class='_3cni' and contains(text(),'${Carousel_title}')]
    #Just a suggested width, what would be the accepted maximum limit of X location
    ${right_limit}    Evaluate    ${tsel_icon_locationX}+400
    [Return]    ${element_XBegin}    ${tsel_icon_locationX}    ${right_limit}

Swipe_until_element
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    [Documentation]    When the VA response has carousel (with picture, header and buttons), this keyword is expected to interact with it.
    Sleep    2s
    ${totalcarousel}    Get Element Count    ${carouselforward_obj}
    : FOR    ${looping}    IN RANGE    0    10
    \    Click Element    (${carouselforward_obj})[${totalcarousel}]
    \    Sleep    2s
    \    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_carousel    ${Carousel_title}    ${Carousel_button}
    \    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    5s
    \    ...    AND    Click Element    //*[@${carouselclass_obj} and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]
    \    ...    AND    Sleep    2s
    \    ...    AND    Exit For Loop
    \    ${looping}    Set Variable    ${looping}+1

Greet_VA_Indo
    [Documentation]    Can be part of any test case, greet VA
    User_input    ${greeting}
    Sleep    10s
    Wait Until Page Contains    ${VA_GreetButton1}    10s    None
    Wait Until Page Contains    ${VA_GreetButton2}    10s    None
    Sleep    5s

Click_Yes
    [Documentation]    This keyword can be used to click Ya button that is part of the VA response.
    ${totalYa}    Get Element Count    ${yabutton_obj}
    Click Element    (${yabutton_obj})[${totalYa}]
    #Sleep    5s

Click_No
    [Documentation]    This keyword can be used to click Tidak button that is part of the VA response.
    ${totalNo}    Get Element Count    ${nobutton_obj}
    Click Element    (${nobutton_obj})[${totalNo}]
    #Sleep    5s

User_input
    [Arguments]    ${input_text}
    Press Key    ${inputtext_obj}    ${input_text}
    Sleep    2s
    Press Key    ${inputtext_obj}    \\13
    Capture Page Screenshot    input.png
    Sleep    5s

User_input2
    [Arguments]    ${input_text}
    Press Key    ${inputtext2_obj}    ${input_text}
    Sleep    2s
    Press Key    ${inputtext2_obj}    \\13
    Capture Page Screenshot    input.png
    Sleep    5s

Check_VA_response
    [Arguments]    ${response_text}
    Element Should Be Visible    //*[@${message_bubble_obj} and contains(.,'${response_text}')]

Open_chrome_messenger
    [Documentation]    Sample Test For Chrome Headless and without notification; not relevant
    [Tags]    chrome    headless
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${URLmessengerTSEL}
    Maximize Browser Window
    Sleep    7s
    Click Element    ${email_obj}
    Input Text    ${email_obj}    ${email}
    Click Element    ${password_obj}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None
    Sleep    10s
    [Teardown]    Close Browser

Set Chrome Options
    [Documentation]    Plan to start chrome without notification; not relevant
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}
