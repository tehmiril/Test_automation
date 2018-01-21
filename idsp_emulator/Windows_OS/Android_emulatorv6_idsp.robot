*** Settings ***
Library           AppiumLibrary
Library           String
Library           Collections
Resource          Setting_emulator.txt
Resource		  Obj_repo_idsp_v6.txt

*** Test Cases ***
basic test
    [Documentation]    Login and logout
    [Setup]    Open app
    Login activity    ${username}    ${password}
    Enter first PIN
    Enter second PIN
    Enter third PIN
    Logout activity

*** Keywords ***
Open app
    Open Application    ${appiumServer}    platformName=${platformName}    platformVersion=${androidVersion}    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appName}

Login activity
    [Arguments]    ${uname}    ${pword}
    [Documentation]    Here we put username and password
    AppiumLibrary.Wait Until Element Is Visible    ${obj_username}    20    None
    AppiumLibrary.Input Text    ${obj_username}    ${uname}
    AppiumLibrary.Input Text    ${obj_password}    ${pword}
    Capture Page Screenshot    creds.png
    AppiumLibrary.Click Element    ${obj_signin}
    AppiumLibrary.Wait Until Element Is Visible    ${obj_submit}    30    None

Enter first PIN
    [Documentation]    Here we enter MPIN and continue
    AppiumLibrary.Input Text    ${obj_mpin1}    A
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    ${obj_mpin2}    B
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    ${obj_mpin3}    C
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    ${obj_mpin4}    D
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    ${obj_mpin5}    E
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    ${obj_mpin6}    F
    #AppiumLibrary.Press Keycode    70
    AppiumLibrary.Click Element    ${obj_submit}
    AppiumLibrary.Wait Until Element Is Visible    ${obj_pin1}    20    None

Enter second PIN
    [Documentation]    Here we check the second 4 digit PIN code to confirm and continue
    Sleep    5s
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Wait Until Element Is Visible    ${obj_confirmPINmessage}    10    None

Enter third PIN
    [Documentation]    Here we check the second 4 digit PIN code to confirm and continue
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Click Element    ${obj_pin1}
    AppiumLibrary.Wait Until Element Is Visible    ${obj_home}    15    None

Logout activity
    [Documentation]    Here we logout
    AppiumLibrary.Click Element    ${obj_inventory}
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Logou"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Logout"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="SIGN IN"]    10    None
