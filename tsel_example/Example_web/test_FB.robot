*** Settings ***
Library           Selenium2Library
Resource          Setting_chrome.txt
Resource          Object_repo_Chrome.txt
Resource          Setting_ie.txt
Resource          Setting_safari.txt
Resource          Object_repo_Safari.txt

*** Test Cases ***
simple_test
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
    Open Browser    ${URL}    ${webDriver_safari}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    Wait Until Page Contains    Home    2s    None
    Click Element    ${messengericon_obj}
    Wait Until Page Contains
    #Close Browser

*** Keywords ***
Login_FB
