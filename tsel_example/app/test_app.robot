*** Settings ***
Library           AppiumLibrary
Resource          Setting_LINE.txt
Resource          Setting_Telegram.txt

*** Test Cases ***
test_FB
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=7.0    deviceName=LGH84565352ad2    appPackage=com.facebook.orca    appActivity=com.facebook.orca.auth.StartScreenActivity

test_LINE
    Open Application    ${appiumServer_LINE}    platformName=${platformName_LINE}    platformVersion=${androidVersion_LINE}    deviceName=${deviceName_LINE}    appPackage=${appPackage_LINE}    appActivity=${appActivity_LINE}
    ...    noReset=true
    Wait Until Element is Visible    //*[@content-desc="Chats tab"]    10    None
    Click Element    //*[@content-desc="Chats tab"]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    id=jp.naver.line.android:id/chatlist_chatname
    Click Element    //*[@content-desc="Keyboard menu"]
    Wait Until Element is Visible    class=android.widget.EditText    5    None
    Input Text    class=android.widget.EditText    Hi
    Click Element    id=jp.naver.line.android:id/chathistory_send_button_image
    Click Element    //*[@content-desc="Keyboard menu"]
    Wait Until Page Contains    Apa yang bisa Veronika bantu hari ini?    10    None
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