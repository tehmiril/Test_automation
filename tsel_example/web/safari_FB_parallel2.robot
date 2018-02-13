*** Settings ***
Library           Selenium2Library
Resource          Object_repo_Chrome.txt
Resource          Test_data_Indo2.txt

*** Test Cases ***
test_chrome_Messenger_askPulsaKuota
    [Documentation]    Here registered user ask for both pulsa and kuota, without top-up.
    Open_Web_Messenger    ${webDriver_Chrome}
    [Teardown]    Close Browser

*** Keywords ***
Login_FB
    [Arguments]    ${webdriver}
    Open Browser    ${URL}    ${webdriver}
    Maximize Browser Window
    Sleep    2s
    Input Text    ${email_obj}    ${email}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None

Open_Web_Messenger
    [Arguments]    ${webdriver}
    Open Browser    ${URLmessengerTSEL}    ${webdriver}
    Maximize Browser Window
    Sleep    10s
    Click Element    ${email_obj}
    Input Text    ${email_obj}    ${email}
    Click Element    ${password_obj}
    Input Password    ${password_obj}    ${password}
    Click Element    ${login_obj}
    Wait Until Page Contains    Telkomsel    20s    None
    Sleep    20s

Select_Carousel
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    ${totalicon}    Get Element Count    //*[@alt="Telkomsel"]
    ${tsel_icon_locationX}    Get Horizontal Position    (//*[@alt="Telkomsel"])[${totalicon}]
    ${element_XBegin}    Get Horizontal Position    //a[contains(.,'${Carousel_button}')]/preceding::*[@class='_3cni' and contains(text(),'${Carousel_title}')]
    #${element_XBegin}    Get Horizontal Position    //*[@class='_3cne' and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]
    #Just a suggested width
    #${left_limit}    Evaluate    ${tsel_icon_locationX}+35
    ${right_limit}    Evaluate    ${tsel_icon_locationX}+400
    [Return]    ${element_XBegin}    ${tsel_icon_locationX}    ${right_limit}

Swipe_until_element
    [Arguments]    ${Carousel_title}    ${Carousel_button}
    Sleep    2s
    ${totalcarousel}    Get Element Count    //*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"]
    : FOR    ${looping}    IN RANGE    0    10
    \    Click Element    (//*[@class="_3-8w img sp_4zuV_NA72V3 sx_ec9265"])[${totalcarousel}]
    \    Sleep    2s
    \    ${element_XBegin}    ${left_limit}    ${right_limit}    Select_carousel    ${Carousel_title}    ${Carousel_button}
    \    Run Keyword If    ${left_limit} < ${element_XBegin} < ${right_limit}    Run Keywords    Sleep    5s
    \    ...    AND    Execute JavaScript    $("//*[@class='_3cne' and contains(.,'${Carousel_title}')]/following-sibling::div//a[contains(.,'${Carousel_button}')]").click();
    \    ...    AND    Sleep    2s
    \    ...    AND    Exit For Loop
    \    ${looping}    Set Variable    ${looping}+1

Greet_VA_Indo
    User_input    ${greeting}
    Sleep    10s
    Wait Until Page Contains    ${VA_Greet1}    10s    None
    Wait Until Page Contains    ${VA_Greet2}    10s    None
    Wait Until Page Contains    ${VA_GreetButton1}    10s    None
    Wait Until Page Contains    ${VA_GreetButton2}    10s    None
    Sleep    5s

Click_Yes
    ${totalYa}    Get Element Count    //*[@class='_3cnp _3cnq' and contains(text(),'Ya')]
    Click Element    (//*[@class='_3cnp _3cnq' and contains(text(),'Ya')])[${totalYa}]
    #Sleep    5s

Click_No
    ${totalNo}    Get Element Count    //*[@class='_3cnp' and contains(text(),'Tidak')]
    Click Element    (//*[@class='_3cnp' and contains(text(),'Tidak')])[${totalNo}]
    #Sleep    5s

User_input
    [Arguments]    ${input_text}
    Press Key    ${inputtext_obj}    ${input_text}
    Sleep    2s
    Press Key    ${inputtext_obj}    \\13
    Capture Page Screenshot    input.png
    Sleep    10s

Check_rate_location
    #Sleep    5s
