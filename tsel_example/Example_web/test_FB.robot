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
    Wait Until Page Contains    Beranda    5s    None
    Click Element    ${messengericon_obj}
    Wait Until Page Contains    Lihat Semua di Messenger    5s    None
    Click Link    Lihat Semua di Messenger
    Wait Until Page Contains    Messenger    5s    None
    Click Element    //*[@data-href="https://www.facebook.com/messages/t/telkomsel"]
    [Teardown]    Close Browser

*** Keywords ***
Login_FB
    [Arguments]    ${webdriver}
    Open Browser    ${URL}    ${webdriver}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
