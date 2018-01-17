*** Settings ***
Library           AppiumLibrary
Library           String
Library           Collections
Resource          Setting_emulator_osx.txt

*** Test Cases ***
basic test
    [Documentation]    Login and logout
    [Setup]    Open app
    Login activity    ${username}    ${password}
    Enter first PIN
    Enter second PIN
    Enter third PIN
    [Teardown]    Close Application

basic test2
    [Documentation]    Login and logout
    [Setup]    Open app2
    Login activity    ${username}    ${password}
    Enter first PIN
    Enter second PIN
    Enter third PIN
    [Teardown]    Close Application

*** Keywords ***
Open app
    Open Application    ${appiumServer}    platformName=${platformName}    platformVersion=${androidVersion}    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appName}

Open app2
    Open Application    ${appiumServer}    platformName=${platformName}    platformVersion=${androidVersion2}    deviceName=${deviceName2}    appPackage=${appPackage}    appActivity=${appName}

Login activity
    [Arguments]    ${uname}    ${pword}
    [Documentation]    Here we put username and password
    #AppiumLibrary.Wait Until Element Is Visible    //*[@text="SIGN IN"]    15    None
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="SIGN IN"]    20    None
    AppiumLibrary.Input Text    //android.widget.EditText[@index="2"]    ${uname}
    AppiumLibrary.Input Text    //android.widget.EditText[@index="3"]    ${pword}
    Capture Page Screenshot    creds.png
    AppiumLibrary.Click Element    //*[@content-desc="SIGN IN"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="SUBMIT"]    30    None

Enter first PIN
    [Documentation]    Here we enter MPIN and continue
    AppiumLibrary.Input Text    //android.view.View[@index="0"]    A
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //android.view.View[@index="2"]    B
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //android.view.View[@index="4"]    C
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //android.view.View[@index="6"]    D
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //android.view.View[@index="8"]    E
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //android.view.View[@index="10"]    F
    #AppiumLibrary.Press Keycode    70
    AppiumLibrary.Click Element    //*[@content-desc="SUBMIT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Set Passcode Lock"]    20    None

Enter second PIN
    [Documentation]    Here we check the second 4 digit PIN code to confirm and continue
    Sleep    5s
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Confirm Passcode Lock"]    10    None

Enter third PIN
    [Documentation]    Here we check the second 4 digit PIN code to confirm and continue
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Click Element    //*[@content-desc="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Home"]    10    None

Logout activity
    [Documentation]    Here we logout, not yet working
    AppiumLibrary.Click Element    //*[@index="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Logout"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Logout"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="SIGN IN"]    10    None

Install app
    Open Application    ${appiumServer}    platformName=${platformName}    platformVersion=${androidVersion}    deviceName=${deviceName}    app=${app}
