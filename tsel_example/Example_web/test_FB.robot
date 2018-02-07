*** Settings ***
Library           Selenium2Library
Resource          Setting_chrome.txt
Resource          Object_repo_Chrome.txt
Resource          Setting_ie.txt
Resource          Setting_safari.txt
Resource          Object_repo_Safari.txt

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
    Wait Until Page Contains    Telkomsel    20s    None
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

_test_safari_location
    Get_X_Location    ${webDriver_safari}

*** Keywords ***
Login_FB
    [Arguments]    ${webdriver}
    Open Browser    ${URL}    ${webdriver}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}

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

Get_X_Location
    [Arguments]    ${webdriver}
    Open_Web_Messenger    ${webdriver}
    Wait Until Page Contains    Telkomsel    20s    None
    Sleep    15s
    ${locationX_1}    Get Horizontal Position    //a[text()="Info SimPATI Combo"]
    ${locationX_2}    Get Horizontal Position    //a[text()="Info Kartu As Combo"]
    ${locationX_3}    Get Horizontal Position    //a[text()="Info Loop Cash"]
    ${total}    Get Element Count    class:_3-8w img sp_4zuV_NA72V3 sx_ec9265
    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[1]
    ${locationX_1}    Get Horizontal Position    //a[text()="Info SimPATI Combo"]
    ${locationX_2}    Get Horizontal Position    //a[text()="Info Kartu As Combo"]
    ${locationX_3}    Get Horizontal Position    //a[text()="Info Loop Cash"]
