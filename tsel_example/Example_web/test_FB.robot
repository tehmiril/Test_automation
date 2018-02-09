*** Settings ***
Library           Selenium2Library
Resource          Setting_chrome.txt
Resource          Object_repo_Chrome.txt
Resource          Test_data_Indo.txt

*** Test Cases ***
simple_test_chrome
    [Documentation]    Discontinued due to pop up that cannot be handled after login to facebook.
    Open Browser    ${URL}    ${webDriver_Chrome}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    #Close Browser

simple_test_ie
    Open Browser    ${URL}    ${webDriver_IE}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    #Close Browser

simple_test_safari
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

test_safari_Messenger
    Open_Web_Messenger    ${webDriver_safari}
    Sleep    10s
    Press Key    ${inputtext_obj}    ${random_question_1}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_notunderstand_1}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_2}    10s    None
    Sleep    5s
    Press Key    ${inputtext_obj}    ${random_question_2}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_notunderstand_3}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_4}    10s    None
    Wait Until Page Contains    Ya    10s    None
    Click Element    Tidak
    Wait Until Page Contains    ${VA_question_1}    10s    None
    Press Key    ${inputtext_obj}    ${no_answer}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    #[Teardown]    Close Browser

test_chrome_Messenger
    Open_Web_Messenger    ${webDriver_Chrome}
    Sleep    10s
    Press Key    ${inputtext_obj}    ${random_question_1}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_notunderstand_1}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_2}    10s    None
    Sleep    5s
    Press Key    ${inputtext_obj}    ${random_question_2}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_notunderstand_3}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_4}    10s    None
    Wait Until Page Contains    Ya    10s    None
    Click Element    Tidak
    Wait Until Page Contains    ${VA_question_1}    10s    None
    Press Key    ${inputtext_obj}    ${no_answer}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    #[Teardown]    Close Browser

simple_carousel_chrome
    Open_Web_Messenger    ${webDriver_Chrome}
    #Click Element    //*[@class='_3cne' and contains(.,'SimPATI Combo')]/following-sibling::div//a[contains(.,'Beli sekarang')]
    #Sleep    2s
    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_Carousel    Kartu As Combo    Beli sekarang
    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    2s
    ...    AND    Click Element    //*[@class='_3cne' and contains(.,'Kartu As Combo')]/following-sibling::div//a[contains(.,'Beli sekarang')]
    ...    AND    Sleep    2s
    ...    ELSE    Swipe_until_element    Kartu As Combo    Beli sekarang

test_chrome_Messenger_VAnotUnderstand
    Open_Web_Messenger    ${webDriver_Chrome}
    Sleep    10s
    Press Key    ${inputtext_obj}    ${random_question_1}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_answerKuota1}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_2}    10s    None
    Sleep    5s
    Press Key    ${inputtext_obj}    ${random_question_2}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    Wait Until Page Contains    ${VA_notunderstand_3}    10s    None
    Wait Until Page Contains    ${VA_notunderstand_4}    10s    None
    Wait Until Page Contains    Ya    10s    None
    Click Element    Tidak
    Wait Until Page Contains    ${VA_question_1}    10s    None
    Press Key    ${inputtext_obj}    ${no_answer}
    Sleep    5s
    Press Key    ${inputtext_obj}    \\13
    Sleep    10s
    #[Teardown]    Close Browser

test_chrome_Messenger_askPulsaKuota
    [Documentation]    Here registered user ask for both pulsa and kuota, without top-up.
    Open_Web_Messenger    ${webDriver_Chrome}
    Greet_VA_Indo
    User_input    ${ask_pulsa}
    Sleep    10s
    Capture Page Screenshot    first_response_pulsa.png
    ${result}    Run Keyword and Return Status    Wait Until Page Contains    ${VA_validateNumber}    10s    None
    Run Keyword If    ${result}    Click_Yes
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(text(),'${VA_answerPulsa1}')]
    Capture Page Screenshot    second_response_pulsa.png
    Wait Until Page Contains    ${VA_answerPulsa2}    10s    None
    Wait Until Page Contains    ${yes_answer}    5s    None
    Wait Until Page Contains    ${no_answer}    5s    None
    User_input    ${ask_kuota}
    Capture Page Screenshot    first_response_kuota.png
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(text(),'${VA_answerKuota2}')]
    Wait Until Page Contains    ${VA_answerKuota3}    10s    None
    Click_No
    Sleep    5s
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(text(),'${VA_question_1}')]
    Click Element    ${inputtext2_obj}
    Sleep    5s
    User_input    ${no_answer}
    Sleep    5s
    #${justcheck}    Get Element Count    //*[@class='_3oh- _58nk' and contains(.,'${VA_question_2}')]
    #(//*[@class='_3oh- _58nk' and contains(.,'${VA_question_2}')])[12]
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(.,'${VA_question_2}')]
    User_input    ${user_rate}
    Capture Page Screenshot    user_rate.png
    Wait Until Page Contains    ${VA_question_3}    10s    None
    #Validate buttons here???!!!
    User_input    ${select_Rate}
    Sleep    2s
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(.,'${VA_askRateReason}')]
    User_input    ${no_answer}
    Sleep    2s
    Element Should Be Visible    //*[@class='_3oh- _58nk' and contains(.,'${VA_thanksRate}')]
    #[Teardown]    Close Browser

test_safari_Messenger_rate
    Open_Web_Messenger    ${webDriver_safari}
    Check_rate_location
    #[Teardown]    Close Browser

*** Keywords ***
Login_FB
    [Arguments]    ${webdriver}
    Open Browser    ${URL}    ${webdriver}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None

Open_Web_Messenger
    [Arguments]    ${webdriver}
    Open Browser    ${URLmessengerTSEL}    ${webdriver}
    Maximize Browser Window
    Sleep    10s
    Click Element    ${email_obj}
    Input Text    ${email_obj}    ${email}
    Click Element    ${password_obj}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None
    Sleep    20s

Select_Carousel
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    ${totalicon}    Get Element Count    //*[@alt="Telkomsel"]
    ${tsel_icon_locationX}    Get Horizontal Position    (//*[@alt="Telkomsel"])[${totalicon}]
    ${element_XBegin}    Get Horizontal Position    //a[contains(.,'${Carousel_button}')]/preceding::*[@class='_3cni' and contains(text(),'${Carousel_title}')]
    #${element_XBegin}    Get Horizontal Position    //*[@class='_3cne' and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]
    #Just a suggested width
    #${left_limit}    Evaluate    ${tsel_icon_locationX}+35
    ${right_limit}    Evaluate    ${tsel_icon_locationX}+400
    [Return]    ${element_XBegin}    ${tsel_icon_locationX}    ${right_limit}

Swipe_until_element
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    Sleep    2s
    ${totalcarousel}    Get Element Count    //*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"]
    : FOR    ${looping}    IN RANGE    0    10
    \    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${totalcarousel}]
    \    Sleep    2s
    \    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_carousel    ${Carousel_title}    ${Carousel_button}
    \    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    5s
    \    ...    AND    Execute JavaScript    $("//*[@class='_3cne' and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]").click();
    \    ...    AND    Sleep    2s
    \    ...    AND    Exit For Loop
    \    ${looping}    Set Variable    ${looping}+1

Greet_VA_Indo
    User_input    ${greeting}
    Sleep    10s
    Wait Until Page Contains    ${VA_Greet1}    10s    None
    Wait Until Page Contains    ${VA_Greet2}    10s    None
    Wait Until Page Contains    ${VA_GreetButton1}    10s    None
    Wait Until Page Contains    ${VA_GreetButton2}    10s    None
    Sleep    5s

Click_Yes
    ${totalYa}    Get Element Count    //*[@class='_3cnp _3cnq' and contains(text(),'Ya')]
    Click Element    (//*[@class='_3cnp _3cnq' and contains(text(),'Ya')])[${totalYa}]
    #Sleep    5s

Click_No
    ${totalNo}    Get Element Count    //*[@class='_3cnp' and contains(text(),'Tidak')]
    Click Element    (//*[@class='_3cnp' and contains(text(),'Tidak')])[${totalNo}]
    #Sleep    5s

User_input
    [Arguments]    ${input_text}
    Press Key    ${inputtext_obj}    ${input_text}
    Sleep    2s
    Press Key    ${inputtext_obj}    \\13
    Capture Page Screenshot    input.png
    Sleep    10s

Check_rate_location
    #Sleep    5s
