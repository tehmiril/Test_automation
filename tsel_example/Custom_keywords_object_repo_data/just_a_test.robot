*** Settings ***
Library           Selenium2Library
Resource          <...>/Custom_keywords_VA.txt
Resource          <...>/Object_repository.txt
Resource          <...>/Test_data_Indo.txt

*** Test Cases ***
test_askPulsaKuota
    [Documentation]    Here registered user ask for both pulsa and kuota, without top-up.
    [Setup]    Open_chrome
    Login_messenger    ${email}    ${password}
    Greet_VA_Indo
    User_input    ${ask_pulsa}
    Sleep    2s
    ${result}    Run Keyword and Return Status    Check_VA_response    ${VA_validateNumber}
    Run Keyword If    ${result}    Click_Yes
    Check_VA_response_text    1    ${VA_answerPulsa1}
    Check_VA_response_text_with_2buttons    2    ${VA_answerPulsa2}    Ya    Tidak
    Capture Page Screenshot    response_pulsa.png
    User_input    ${ask_kuota}
    Check_VA_response_text    1    ${VA_answerKuota2}
    Check_additional_text_2buttons    1    ${VA_answerKuota3}    Ya    Tidak
    Click_additional_No
    Check_VA_response_text    1    ${VA_question_1}
    Closing_session
    [Teardown]    Close Browser

test_simple_input_response
    [Setup]    Open_chrome
    Login_messenger    ${email}    ${password}
    Greet_VA_Indo
    User_input    ${random_question_3}
    Check_VA_response_text    1    ${VA_gives_FAQ}
    Check_VA_response_carousel_exists    2
    Check_VA_response_text    3    ${VA_question_1}
    Capture Page Screenshot    response_qa.png
    User_input    Lihat semua produk
    Check_VA_response_text    1    Pilihan yang tepat! Kamu bisa beralih ke produk Telkomsel di bawah ini
    Check_VA_response_carousel_exists    2
    Capture Page Screenshot    response_produk.png
    Cancel_and_closing_session
    Sleep    2s
    [Teardown]    Close Browser

10-TCASH Information
    [Setup]    Open_chrome
    Login_messenger    ${email}    ${password}
    User_input    TCASH itu apaan sih?
    Check_VA_response_text    1    TCASH adalah layanan uang elektronik dari Telkomsel yang telah mendapatkan izin dari Bank Indonesia. Berbeda dengan pulsa, TCASH dapat digunakan untuk bayar tagihan, bayar merchant, isi pulsa, kirim uang, dan banyak lagi.
    Check_VA_response_carousel_exists    2
    User_input    apa sih untungnya pake tcash?
    Check_VA_response_image    1
    Check_VA_response_text_with_2buttons    2    Apa Kamu mau tahu lebih banyak tentang TCASH?    Ya    Tidak
    User_input    Apa sih bedanya tcash basic dan full service?
    Check_VA_response_image    1
    Check_VA_response_text    2    ${VA_question_1}
    User_input    Tcash ada promo apa aja ya?
    Check_VA_response_text    1    TCASH adalah layanan uang elektronik dari Telkomsel yang telah mendapatkan izin dari Bank Indonesia. Berbeda dengan pulsa, TCASH dapat digunakan untuk bayar tagihan, bayar merchant, isi pulsa, kirim uang, dan banyak lagi.
    Check_VA_response_carousel_exists    2
    Click_button_carousel    2    Dapatkan TCASH    Pesan Sticker
    Click_button_carousel    2    Info    TCASH FAQ
    Check_carousel_item    2    Promo TCASH    Dapatkan diskon menarik di merchant mitra TCASH    Merchant TCASH
    Cancel_and_closing_session
    [Teardown]    Close Browser
