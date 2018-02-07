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

test_chrome_Messenger
    Open_Web_Messenger    ${webDriver_Chrome}
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

_test_chrome_location
    Get_X_Location    ${webDriver_Chrome}

simple_carousel_chrome
    Open_Web_Messenger    ${webDriver_Chrome}
    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_Carousel    Kartu As Combo    Beli sekarang
    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    2s
    ...    AND    Click Element    //a[contains(.,'${Carousel_button}')]/preceding::*[@class='_3cni' and contains(text(),'${Carousel_title}')]
    ...    ELSE    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${totalcarousel}]

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
    Sleep    5s

Get_X_Location
    [Arguments]    ${webdriver}
    Open_Web_Messenger    ${webdriver}
    Sleep    10s
    ${totalicon}    Get Element Count    //*[@alt="Telkomsel"]
    ${tsel_icon_locationX1}    Get Horizontal Position    (//*[@alt="Telkomsel"])[1]
    ${tsel_icon_locationXlast}    Get Horizontal Position    (//*[@alt="Telkomsel"])[${totalicon}]
    ${headerX_1}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${headerX_2}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${headerX_3}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Loop Cash')]
    ${elementdetail1}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${elementdetail2}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${locationX_1}    Get Horizontal Position    //a[text()="Info SimPATI Combo"]
    ${locationX_11}    Get Horizontal Position    //a[text()="Perdana SimPATI"]
    ${locationX_2}    Get Horizontal Position    //a[text()="Info Kartu As Combo"]
    ${locationX_3}    Get Horizontal Position    //a[text()="Info Loop Cash"]
    ${locationX_31}    Get Horizontal Position    //a[text()="Perdana Loop"]
    ${total}    Get Element Count    //*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"]
    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${total}]
    Sleep    2s
    ${headerX_1}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${headerX_2}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${headerX_3}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Loop Cash')]
    ${elementdetail1}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${elementdetail2}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${locationX_1}    Get Horizontal Position    //a[text()="Info SimPATI Combo"]
    ${locationX_11}    Get Horizontal Position    //a[text()="Perdana SimPATI"]
    ${locationX_2}    Get Horizontal Position    //a[text()="Info Kartu As Combo"]
    ${locationX_3}    Get Horizontal Position    //a[text()="Info Loop Cash"]
    ${locationX_31}    Get Horizontal Position    //a[text()="Perdana Loop"]
    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${total}]
    Sleep    2s
    ${headerX_1}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${headerX_2}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${headerX_3}    Get Horizontal Position    //*[@class='_3cni' and contains(text(),'Loop Cash')]
    ${elementdetail1}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'SimPATI Combo')]
    ${elementdetail2}    Get Horizontal Position    //a[contains(.,'Beli sekarang')]/preceding::*[@class='_3cni' and contains(text(),'Kartu As Combo')]
    ${locationX_1}    Get Horizontal Position    //a[text()="Info SimPATI Combo"]
    ${locationX_11}    Get Horizontal Position    //a[text()="Perdana SimPATI"]
    ${locationX_2}    Get Horizontal Position    //a[text()="Info Kartu As Combo"]
    ${locationX_3}    Get Horizontal Position    //a[text()="Info Loop Cash"]
    ${locationX_31}    Get Horizontal Position    //a[text()="Perdana Loop"]

Select_Carousel
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    ${totalicon}    Get Element Count    //*[@alt="Telkomsel"]
    ${tsel_icon_locationX}    Get Horizontal Position    (//*[@alt="Telkomsel"])[${totalicon}]
    ${totalcarousel}    Get Element Count    //*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"]
    ${element_XBegin}    Get Horizontal Position    //a[contains(.,'${Carousel_button}')]/preceding::*[@class='_3cni' and contains(text(),'${Carousel_title}')]
    #Just a suggested width
    ${left_limit}    Evaluate    ${tsel_icon_locationX}+35
    ${right_limit}    Evaluate    ${left_limit}+40
    [Return]    ${element_XBegin}    ${left_limit}    ${right_limit}

Swipe_until_element
    [Arguments]    ${findElement}
    ${totalcarousel}    Get Element Count    //*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"]
    : FOR    ${licznik}    IN RANGE    0    10
    \    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${totalcarousel}]
    \    ${elementXNew}    Select_carousel    ${findElement}
    \    Run Keyword If    39.0 < ${elementXNew} < 233.0    Run Keywords    Log    "Yeah"
    \    ...    AND    Exit For Loop
    \    ${licznik}    Set Variable    ${licznik}+1
