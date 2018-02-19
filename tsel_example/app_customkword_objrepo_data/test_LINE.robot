*** Settings ***
Library           AppiumLibrary
Resource          Test_data_LINE_Indo.txt
Library           String
Library           Collections
Resource          Object_repo_LINE.txt
Resource          app_custom_keywords.txt

*** Test Cases ***
_test_FB
    Open Application    ${appiumServer_FB}    platformName=${platformName_FB}    platformVersion=${androidVersion_FB}    deviceName=${deviceName_FB}    appPackage=${appPackage_FB}    appActivity=${appActivity_FB}
    ...    noReset=true
    Wait Until Element is Visible    //*[@text="MESSAGES"]    10    None
    Log Source
    Click Element    //*[@instance="13"]
    Wait Until Element is Visible    //*[@content-desc="Telkomsel"]    10    None
    Input Text    class=android.widget.EditText    Hi
    Click Element    //*[@content-desc="Send"]
    Wait Until Element is Visible    //*[@text="MESSAGES"]    10    None

_LINE_askPulsaKuota
    [Setup]    Open app
    Wait Until Element is Visible    //*[@content-desc="Chats tab"]    10    None
    Click Element    //*[@content-desc="Chats tab"]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    id=jp.naver.line.android:id/chatlist_chatname
    #Click Element    //*[@content-desc="Keyboard menu"]
    User_input    ${ask_pulsa}
    Capture Page Screenshot    first_response_pulsa.png
    ${result}    Run Keyword and Return Status    Check_VA_response    ${VA_validateNumber}
    Run Keyword If    ${result}    Click_Yes
    Sleep    10s
    Check_VA_response_main    ${VA_answerPulsa1}
    User_input    ${ask_kuota}
    Check_VA_response_main    ${VA_answerKuota1}
    Click_No
    Sleep    5s
    Check_VA_response_main    ${VA_question_1}
    User_input    ${no_answer}
    Check_VA_response_main    ${VA_question_2}
    User_input    ${user_rate}
    Check_VA_response_main    ${VA_question_3}
    User_input    ${select_Rate}
    Check_VA_response_main    ${VA_askRateReason}
    User_input    ${no_answer}
    Sleep    10s
    Check_VA_response_main    ${VA_thanksRate}
    [Teardown]    Close Application

LINE_askVAdonotunderstand
    [Setup]    Open app
    Wait Until Element is Visible    //*[@content-desc="Chats tab"]    10    None
    Click Element    //*[@content-desc="Chats tab"]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    id=jp.naver.line.android:id/chatlist_chatname
    #Click Element    //android.widget.RelativeLayout[@index="2"]
    ${count_message}    Get Matching Xpath Count    ${messagebubble_obj}
    ${elements}    Get Webelement    //*[@class="android.widget.TextView" and @text="Terima kasih atas penilaiannya :) Sampai jumpa di chat berikutnya dan semoga harimu menyenangkan ya"]
    ${text_mess}    Get Text    //*[@class="android.widget.TextView"][${count_message}]
    #User_input    ${random_question_1}
    #Sleep    5s
    #Capture Page Screenshot    first_response_notunderstand.png
    #Check_VA_response_main    ${VA_notunderstand_1}
    #User_input    ${random_question_2}
    #Sleep    2s
    #Check_VA_response_main    ${VA_notunderstand_6}
    #User_input    ${cancel_answer}
    #Sleep    2s
    #User_input    ${no_answer}
    #Check_VA_response_main    ${VA_question_2}
    #User_input    ${user_rate}
    #Check_VA_response_main    ${VA_question_3}
    #User_input    ${select_Rate}
    #Check_VA_response_main    ${VA_askRateReason}
    #User_input    ${no_answer}
    #Sleep    5s
    #Check_VA_response_main    ${VA_thanksRate}
    [Teardown]    Close Application

_test_Telegram
    Open Application    ${appiumServer_Tele}    platformName=${platformName_Tele}    platformVersion=${androidVersion_Tele}    deviceName=${deviceName_Tele}    appPackage=${appPackage_Tele}    appActivity=${appActivity_Tele}
    ...    noReset=true
    Wait Until Element is Visible    class=org.telegram.messenger.support.widget.RecyclerView    15    None
    Click Element    //android.view.View[@index="0"]
    Wait Until Element is Visible    class=android.widget.EditText    10    None
    Input Text    class=android.widget.EditText    Hi
    Click Element    //android.widget.ImageView[@index="2"]
    Wait Until Element is Visible    //*[@text="Lihat Menu Utama"]    5    None
    [Teardown]    Close Application

_test_LINE_carousel
    [Setup]    Open app
    Wait Until Element is Visible    //*[@content-desc="Chats tab"]    10    None
    Click Element    //*[@content-desc="Chats tab"]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    id=jp.naver.line.android:id/chatlist_chatname
    #Click Element    //*[@content-desc="Keyboard menu"]
    Click Element    //*[@text="CEK INFONYA!"]
    Sleep    2s
    ${elementX}    Select_carousel    Bantuan Lainnya
    Run Keyword If    39.0 < ${elementX} < 233.0    Log    "hey"${elementX}
    ...    ELSE    Swipe_until_element    Bantuan Lainnya
