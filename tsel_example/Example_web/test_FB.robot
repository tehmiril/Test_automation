*** Settings ***
Library           Selenium2Library
Resource          Setting_chrome.txt
Resource          Object_repo_Chrome.txt

*** Test Cases ***
simple_test
    Open Browser    ${URL}    ${webDriver_Chrome}
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Sleep    5s
    Close Browser
