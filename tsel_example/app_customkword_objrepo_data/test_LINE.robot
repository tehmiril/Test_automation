*** Settings ***
Library           AppiumLibrary
Resource          Test_data_LINE_Indo.txt
Library           String
Library           Collections
Resource          Object_repo_LINE.txt
Resource          app_custom_keywords.txt

*** Test Cases ***
LINE_10_TCASH
    [Setup]    Open app
    Wait Until Element is Visible    id=jp.naver.line.android:id/header_middle_button_img    10    None
    Click Element    //android.widget.FrameLayout[contains(@content-desc,"Chats tab")]
    Wait Until Element is Visible    //*[@text="Chats"]    5    None
    Click Element    //*[@resource-id="jp.naver.line.android:id/chatlist_chatname" and contains(@text,"Telkomsel")]    #id=jp.naver.line.android:id/chatlist_chatname
    User_input    TCASH itu apaan sih?
    Check_VA_response_text    TCASH adalah layanan uang elektronik dari Telkomsel yang telah mendapatkan izin dari Bank Indonesia. Berbeda dengan pulsa, TCASH dapat digunakan untuk bayar tagihan, bayar merchant, isi pulsa, kirim uang, dan banyak lagi.
    Capture Page Screenshot    first_response_notunderstand.png
    User_input    apa sih untungnya pake tcash?
    Check_VA_response_text_2buttons    Apa Kamu mau tahu lebih banyak tentang TCASH?    Ya    Tidak
    Click_No
    Check_VA_response_text    ${VA_question_1}
    Closing_session
    [Teardown]    Close Application
