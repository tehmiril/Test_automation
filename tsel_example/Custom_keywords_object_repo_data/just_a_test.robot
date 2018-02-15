*** Settings ***
Library           Selenium2Library
Resource          Test_automation/tsel_example/Custom_keywords_object_repo_data/Custom_keywords_VA.txt
Resource          Test_automation/tsel_example/Custom_keywords_object_repo_data/Object_repository.txt
Resource          Test_automation/tsel_example/Custom_keywords_object_repo_data/Test_data_Indo.txt

*** Test Cases ***
test_carousel
    [Documentation]    this is created to test carousel on ff, it is expected that carousel is already exists on the chat.
    [Setup]
    Open_Web_Messenger    ${webDriver_Chrome}
    User_input    ${see_products}
    #User_input    ${random_question_3}
    Sleep    2s
    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_Carousel    ${Carousel_title}    ${Carousel_button}
    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    2s
    ...    AND    Click Element    //*[@${carouselclass_obj} and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]
    ...    AND    Sleep    2s
    ...    ELSE    Swipe_until_element    ${Carousel_title}    ${Carousel_button}
    ${URLS}    Get Locations
    #Capture Page Screenshot    new_browser.png
    Sleep    5s
    Closing_session
    [Teardown]    Close All Browsers

test_askPulsaKuota
    [Documentation]    Here registered user ask for both pulsa and kuota, without top-up.
    Open_Web_Messenger    ${webDriver_Chrome}
    Greet_VA_Indo
    User_input    ${ask_pulsa}
    Sleep    10s
    Capture Page Screenshot    first_response_pulsa.png
    ${result}    Run Keyword and Return Status    Check_VA_response    ${VA_validateNumber}
    Run Keyword If    ${result}    Click_Yes
    Check_VA_response    ${VA_answerPulsa1}
    Capture Page Screenshot    second_response_pulsa.png
    Check_VA_response    ${VA_answerPulsa2}
    User_input    ${ask_kuota}
    Capture Page Screenshot    first_response_kuota.png
    Sleep    5s
    Check_VA_response    ${VA_answerKuota2}
    Check_VA_response    ${VA_answerKuota3}
    Click_No
    Sleep    5s
    Closing_session
    [Teardown]    Close Browser

test_location
    Open_Web_Messenger    ${webDriver_Chrome}
    ${total_message}    Count_message_bubble
    ${total_user_input}    Count_message_bubble_user_input    halo
    #@{listofchildren}    Get WebElements    (//*[@class="clearfix _o46 _3erg _3i_m _nd_ direction_ltr text_align_ltr" and contains (.,"y")])[${total_user_input}]/ancestor::*[@class="_1t_p clearfix"]/parent::*/following-sibling::*/descendant::*[contains(@class,"clearfix _o46")]
    ${total_VA_children}    Get_VA_grouped_response    halo    ${total_user_input}
    Check_VA_response_image    halo    ${total_user_input}    3
    Check_VA_response_text    halo    ${total_user_input}    1    ${VA_Greet1}
    Check_VA_response_text_with_2buttons    halo    ${total_user_input}    4    ${VA_Greet2}    ${VA_GreetButton1}
    Check_VA_response_text_with_2buttons    halo    ${total_user_input}    4    ${VA_Greet2}    ${VA_GreetButton2}
    Check_VA_response_carousel_exists    lihat    ${total_user_input}    2
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
    Click_button_carousel    2    Info    TCASH FAQ
    #Click_button_carousel    2    Dapatkan TCASH    Pesan Sticker
    Cancel_and_closing_session
    [Teardown]    Close Browser
