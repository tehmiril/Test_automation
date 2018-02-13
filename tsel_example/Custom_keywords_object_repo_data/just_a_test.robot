*** Settings ***
Library           Selenium2Library
Resource          <...>/Custom_keywords_VA.txt
Resource          <...>/Object_repo_FF.txt
Resource          <...>/Test_data_Indo.txt

*** Test Cases ***
test_carousel
    [Documentation]    this is created to test carousel on ff, it is expected that carousel is already exists on the chat.
    [Setup]
    Open_Web_Messenger    ${webDriver_Chrome}
    #User_input    ${see_products}
    User_input    ${random_question_3}
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
