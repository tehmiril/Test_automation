*** Settings ***
Library           AppiumLibrary
Resource          Setting_LINE.txt
Resource          Setting_Telegram.txt
Resource          Setting_FB.txt

*** Test Cases ***
test_FB
    Open Application    ${appiumServer_FB}    platformName=${platformName_FB}    platformVersion=${androidVersion_FB}    deviceName=${deviceName_FB}    appPackage=${appPackage_FB}    appActivity=${appActivity_FB}
    ...    noReset=true
    Wait Until Element is Visible    //*[@text="MESSAGES"]    10    None
    Log Source
    Click Element    //*[@instance="13"]
    Wait Until Element is Visible    //*[@content-desc="Telkomsel"]    10    None
    Input Text    class=android.widget.EditText    Hi
    Click Element    //*[@content-desc="Send"]
    Wait Until Element is Visible    //*[@text="MESSAGES"]    10    None

test_LINE
    Open Application    ${appiumServer_LINE}    platformName=${platformName_LINE}    platformVersion=${androidVersion_LINE}    deviceName=${deviceName_LINE}    appPackage=${appPackage_LINE}    appActivity=${appActivity_LINE}
    ...    noReset=true
    Wait Until Element is Visible    //*[@content-desc="Chats tab"]    10    None
    Click Element    //*[@content-desc="Chats tab"]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    id=jp.naver.line.android:id/chatlist_chatname
    #Click Element    //*[@content-desc="Keyboard menu"]
    Click Element    //*[@text="CEK INFONYA!"]
    #Wait Until Element is Visible    class=android.widget.EditText    5    None
    #Input Text    class=android.widget.EditText    Hi
    #Click Element    id=jp.naver.line.android:id/chathistory_send_button_image
    #Click Element    //*[@content-desc="Keyboard menu"]
    Log Source
    Sleep    3s
    @{bound}    Get Element Location    //android.view.View[@text="Bantuan Lainnya"]
    ${xCoord}    @{bound}[1]
    Run Keyword if    ${xCoord} < 14    or    ${xCoord} > 206    Swipe_until_element    //android.view.View[@text="Bantuan Lainnya"]
    #Scroll    //*[@text="MusicMAX"]    //*[@text="Profil Kamu"]
    #Wait Until Page Contains    Apa yang bisa Veronika bantu hari ini?    10    None
    [Teardown]    Close Application

test_Telegram
    Open Application    ${appiumServer_Tele}    platformName=${platformName_Tele}    platformVersion=${androidVersion_Tele}    deviceName=${deviceName_Tele}    appPackage=${appPackage_Tele}    appActivity=${appActivity_Tele}
    ...    noReset=true
    Wait Until Element is Visible    class=org.telegram.messenger.support.widget.RecyclerView    15    None
    Click Element    //android.view.View[@index="0"]
    Wait Until Element is Visible    class=android.widget.EditText    10    None
    Input Text    class=android.widget.EditText    Hi
    Click Element    //android.widget.ImageView[@index="2"]
    Wait Until Element is Visible    //*[@text="Lihat Menu Utama"]    5    None
    [Teardown]    Close Application

*** Keywords ***
Swipe_until_element
    [Arguments]    ${findElement}
    : FOR    ${licznik}    IN RANGE    0    5
    \    Swipe    600    600    100    600
    \    @{bound}    Get Element Location    //android.view.View[@text="Bantuan Lainnya"]
    \    ${el}    Run Keyword And Return Status    Element Should Be Visible    //*[@text="Bantuan Lainnya"]
    \    Run Keyword If    ${el}    Exit For Loop
    \    ${licznik}    Set Variable    ${licznik}+1
