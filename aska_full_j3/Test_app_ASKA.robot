*** Settings ***
Resource          Setting_ACN.txt
Library           AppiumLibrary
Library           String
Library           Collections

*** Test Cases ***
Group member check transaction
    [Documentation]    Check if the value of Pembayaran Pinjaman is correct
    [Setup]    Open app
    Enter mobile number    ${groupmember}
    Login activity
    Enter first PIN
    Enter second PIN
    Check member transaction    ${memberTransaction}
    Return to main menu
    Logout activity
    [Teardown]

Group admin create complain
    [Documentation]    Here group admin can create complain for admin
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Create complain    ${complainTitle}
    Return to main menu
    Logout activity
    [Teardown]

Admin close complain
    [Documentation]    Here admin can comment and close complain
    [Setup]    Open app
    Enter mobile number    ${admin}
    Login activity
    Enter first PIN
    Enter second PIN
    Handle complain    ${complainTitle}
    Return to main menu
    Logout activity
    [Teardown]

Admin create group
    [Documentation]    Here admin can create new group
    [Setup]    Open app
    Enter mobile number    ${admin}
    Login activity
    Enter first PIN
    Enter second PIN
    Create group    ${grName}    ${admName}    ${mNumber}
    Return to main menu
    Logout activity
    [Teardown]

Admin cannot create group
    [Documentation]    Here admin is expected to receive an error because the group is already created
    [Setup]    Open app
    Enter mobile number    ${admin}
    Login activity
    Enter first PIN
    Enter second PIN
    Negative-create already registered group    ${oldGrName}    ${admName}    ${mNumber}
    Return to main menu
    Logout activity
    [Teardown]

Admin check group
    [Documentation]    Here admin can check any created group
    [Setup]    Open app
    Enter mobile number    ${admin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check group
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group admin transaksi saham
    [Documentation]    Here group admin can create new saham and validate
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create saham
    Return to main menu
    [Teardown]    Close Application

Group admin transaksi dana sosial
    [Documentation]    Here group admin can create new dana sosial and validate
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create dana sosial
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group admin pemberian pembayaran pinjaman
    [Documentation]    Here group admin can create pinjaman and check payment
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create pinjaman    ${memberName}    ${amount}
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group admin transaksi denda
    [Documentation]    Here group admin can create pinjaman and check payment
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create denda    ${memberName}    ${amount}
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group admin pengeluaran admin
    [Documentation]    Here group admin can create and check pengeluaran
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create pengeluaran    ${memberName}    ${amountPengeluaran}
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group admin pembayaran dana sosial
    [Documentation]    Here group admin can create new dana sosial and validate
    [Setup]    Open app
    Enter mobile number    ${groupadmin}
    Login activity
    Enter first PIN
    Enter second PIN
    Check and create pembayaran dana sosial    ${memberName}    ${amountPengeluaran}
    Return to main menu
    Logout activity
    [Teardown]

Group admin activities
    [Documentation]    Every scenarios in one
    [Setup]    Open app
    Enter mobile number    ${admin}
    Login activity
    Enter first PIN
    Enter second PIN
    Handle complain    ${complainTitle}
    Return to main menu
    Negative-create already registered group    ${oldGrName}    ${admName}    ${mNumber}
    Return to main menu
    Check and create saham
    Return to main menu
    Check and create dana sosial
    Return to main menu
    Check and create pinjaman    ${memberName}    ${amount}
    Return to main menu
    Check and create denda    ${memberName}    ${amount}
    Return to main menu
    Check and create pengeluaran    ${memberName}    ${amountPengeluaran}
    Return to main menu
    Check and create pembayaran dana sosial    ${memberName}    ${amountPengeluaran}
    Return to main menu
    Logout activity
    [Teardown]    Close Application

Group member check transaction_2
    [Documentation]    Check if the value of Pembayaran Pinjaman is correct
    [Tags]    multi
    [Setup]    Open app2
    Enter mobile number    ${groupmember}
    Login activity
    Enter first PIN
    Enter second PIN
    Check member transaction    ${memberTransaction}
    Return to main menu
    Logout activity
    [Teardown]

*** Keywords ***
Open app
    Open Application    ${appiumServer}    platformName=${platformName}    platformVersion=${androidVersion}    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appName}
    ...    udid=${udid1}

Open app2
    Open Application    ${appiumServer2}    platformName=${platformName}    platformVersion=${androidVersion2}    deviceName=${deviceName2}    appPackage=${appPackage}    appActivity=${appName}
    ...    udid=${udid2}

Enter mobile number
    [Arguments]    ${mphone}
    [Documentation]    Here we put phone number and try to login
    #AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@content-desc="LANJUTKAN"]    15    None
    AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@text="LANJUTKAN"]    15    None
    AppiumLibrary.Input Text    class=android.widget.EditText    ${mphone}
    ${mphone2}    Get Text    class=android.widget.EditText
    Run Keyword If    '${mphone2}' != '${mphone}'    Run Keywords    Clear Text    class=android.widget.EditText
    ...    AND    AppiumLibrary.Input Text    class=android.widget.EditText    ${mphone}
    AppiumLibrary.Click Element    xpath=//*[@text="LANJUTKAN"]
    AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@resource-id="mpin1"]    10    None

Login activity
    [Documentation]    Here we put pin and continue
    AppiumLibrary.Input Text    //*[@resource-id="mpin1"]    1
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //*[@resource-id="mpin2"]    1
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //*[@resource-id="mpin3"]    1
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //*[@resource-id="mpin4"]    1
    AppiumLibrary.Press Keycode    32
    AppiumLibrary.Input Text    //*[@resource-id="mpin5"]    1
    Capture Page Screenshot    lastPIN.png
    AppiumLibrary.Click Element    //*[@text="LANJUTKAN"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Silakan atur kode sandi Anda"]    10    None

Enter first PIN
    [Documentation]    Here we check the first 5 digit PIN code and continue
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Masukkan lagi kode sandi Anda untuk konfirmasi"]    10    None

Enter second PIN
    [Documentation]    Here we check the second 5 digit PIN code to confirm and continue
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Click Element    //*[@resource-id="pin-button-1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Beranda"]    10    None

Handle complain
    [Arguments]    ${ctitle}
    [Documentation]    Here admin can handle and close complain
    AppiumLibrary.Click Element    //*[@content-desc="Kelola Keluhan"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Terbaru"]    10    None
    : FOR    ${test}    IN RANGE    0    6
    \    Swipe By Percent    90    90    90    10
    \    ${el}    Run Keyword And Return Status    Element Should Be Visible    //*[@content-desc="${ctitle}"]
    \    Run Keyword If    '${el}' == 'TRUE'    Exit For Loop
    AppiumLibrary.Click Element    //*[@content-desc="${ctitle}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="${ctitle}"]    10    None
    AppiumLibrary.Input Text    //*[@text="Ketik tanggapan Anda..."]    komen dari admin
    Hide Keyboard
    AppiumLibrary.Click Element    //*[@content-desc="TUTUP KELUHAN"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Keluhan sukses ditutup"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    #AppiumLibrary.Element Should Be Visible    //*[@content-desc="${ctitle}"]    DEBUG
    Capture Page Screenshot    closeComplain.png
    #AppiumLibrary.Click Element    //*[@content-desc="Terbaru"]

Create complain
    [Arguments]    ${ctitle}
    [Documentation]    Here group admin can create complain
    AppiumLibrary.Click Element    //*[@content-desc="Keluhan Saya"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Semua keluhan akan disampaikan ke Wahana Visi Indonesia dan akan ditangani secara rahasia"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="BUAT KELUHAN"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Keluhan Baru"]    10    None
    AppiumLibrary.Input Text    //*[@text="Judul"]    ${ctitle}
    ${compl}    Get Text    //android.widget.EditText[@instance="0"]
    Run Keyword If    '${compl}' != '${ctitle}'    Run Keywords    Clear Text    //android.widget.EditText[@instance="0"]
    ...    AND    AppiumLibrary.Input Text    //android.widget.EditText[@instance="0"]    ${ctitle}
    AppiumLibrary.Input Text    //*[@text="Deskripsi"]    Apapun makanannya, minumnya teh sosro
    Hide Keyboard
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Keluhan sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Keluhan Saya"]    10    None
    AppiumLibrary.Element Should Be Visible    //*[@content-desc="${ctitle}"]    DEBUG
    Capture Page Screenshot    newComplain.png

Logout activity
    [Documentation]    Here we logout
    AppiumLibrary.Click Element    //*[@instance="4"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Yakin untuk keluar?"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    class=android.widget.EditText    10    None

Create group
    [Arguments]    ${groupName}    ${groupAdmin}    ${adminMobNumber}
    [Documentation]    Here admin can create group
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TAMBAH KELOMPOK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="TAMBAH KELOMPOK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TAMBAH"]    10    None
    AppiumLibrary.Input Text    //*[@text="Nama kelompok"]    ${groupName}
    ${group2}    Get Text    //android.widget.EditText[@instance="0"]
    Run Keyword If    '${group2}' != '${group2}'    Run Keywords    Clear Text    //android.widget.EditText[@instance="0"]
    ...    AND    AppiumLibrary.Input Text    //android.widget.EditText[@instance="0"]    ${groupName}
    AppiumLibrary.Input Text    //*[@text="Nama admin"]    ${groupAdmin}
    AppiumLibrary.Input Text    //*[@text="Nomor ponsel admin"]    ${adminMobNumber}
    AppiumLibrary.Click Element    //*[@content-desc="TAMBAH"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Kelompok sukses dibentuk"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //*[@instance="3"]

Return to main menu
    [Documentation]    Quick steps to return to main menu
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Beranda"]    10    None

Negative-create already registered group
    [Arguments]    ${groupName}    ${groupAdmin}    ${adminMobNumber}
    [Documentation]    Here admin can create group
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TAMBAH KELOMPOK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="TAMBAH KELOMPOK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TAMBAH"]    10    None
    AppiumLibrary.Input Text    //*[@text="Nama kelompok"]    ${groupName}
    AppiumLibrary.Input Text    //*[@text="Nama admin"]    ${groupAdmin}
    AppiumLibrary.Input Text    //*[@text="Nomor ponsel admin"]    ${adminMobNumber}
    AppiumLibrary.Click Element    //*[@content-desc="TAMBAH"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@instance="5"]    10    None
    Capture Page Screenshot    negativeGroup.png
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]

Check member transaction
    [Arguments]    ${trans}
    [Documentation]    Here member can check transaction
    AppiumLibrary.Click Element    //*[@content-desc="Tinjauan Saya"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TRANSAKSI SAYA"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="TRANSAKSI SAYA"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Pembayaran pinjaman"]    10    None
    ${transaction}    Get price    13
    Should Be Equal As Numbers    ${transaction}    ${trans}
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Tinjauan Saya"]    10    None

Check group
    [Documentation]    Not fully working yet
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="TAMBAH KELOMPOK"]    10    None
    #Scroll    //*[@content-desc="Zhang7"]    //*[@content-desc="test21Feb"]
    #: FOR    ${test}    IN RANGE    999
    #\    ${el}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@content-desc="test21Feb"]
    #\    Exit For Loop If    '${el}'=='TRUE'
    #\    Swipe By Percent    90    90    90    80
    Wait Until Keyword Succeeds    2 min    5 sec    Swipe until element
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]

Check and create saham
    [Documentation]    Here group admin can check saham
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${sahamBegin}    Get Element Attribute    //android.view.View[@instance="11"]    contentDescription
    Capture Page Screenshot    sahamOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    Run Keyword    Create saham    ${sahamBegin}

Create saham
    [Arguments]    ${oldSaham}
    [Documentation]    Here group admin can create and validate saham
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Saham"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru"]    10    None
    AppiumLibrary.Click Element    //*[@instance="13"]
    ${sahamA}    Get Element Attribute    //android.view.View[@instance="12"]    contentDescription
    AppiumLibrary.Click Element    //*[@instance="7"]
    ${sahamB}    Get Element Attribute    //android.view.View[@instance="8"]    contentDescription
    ${sahamTotal}    Evaluate    ${sahamA}+${sahamB}
    ${sahamEnd}    Evaluate    ${sahamTotal}+${oldSaham}
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Beranda"]    10    None
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${sahamNew}    Get Element Attribute    //android.view.View[@instance="11"]    contentDescription
    Capture Page Screenshot    sahamNew.png
    Should Be Equal As Integers    ${sahamNew}    ${sahamEnd}

Check and create dana sosial
    [Documentation]    Here group admin can check saham
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${dsBegin}    Get price    15
    Capture Page Screenshot    dsOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    Run Keyword    Create dana sosial    ${dsBegin}

Create dana sosial
    [Arguments]    ${oldDS}
    [Documentation]    Here group admin can create and validate saham
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Dana sosial"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Dana Sosial"]    10    None
    AppiumLibrary.Click Element    //android.widget.CheckBox[@instance="2"]
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    ${dsEnd}    Get price    8
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Beranda"]    10    None
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${dsTotal}    Get price    15
    ${diff}    Evaluate    ${dsTotal}-${oldDS}
    Should Be Equal As Numbers    ${diff}    ${dsEnd}
    Capture Page Screenshot    dsNew.png

Check and create pinjaman
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can check pinjaman
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    Capture Page Screenshot    pinjamOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    Run Keyword    Create pinjaman    ${name}    ${amount}

Create pinjaman
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can create and validate pinjaman
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Pemberian pinjaman"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Total (Rp.)"]    10    None
    AppiumLibrary.Input Text    //*[@content-desc="Total (Rp.)"]    ${amount}
    AppiumLibrary.Element Should Be Enabled    //*[@content-desc="+"]
    AppiumLibrary.Click Element    //*[@content-desc="+"]
    ${pinjamanAmount}    Get price    21
    #${durasi}    Get Element Attribute    //android.view.View[@instance="17"]    contentDescription
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Page Should Not Contain Element    //*[@content-desc="${name}"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Click Element    //*[@content-desc="Pembayaran pinjaman"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="${name}"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru ${name}"]    15    None
    ${pinjamanAmountNow}    Get price    14
    Run Keyword If    '${pinjamanAmountNow}' == '${pinjamanAmount}'    Run Keywords    Capture Page Screenshot    pinjamNEW.png
    ...    AND    Create pembayaran pinjaman    ${name}    ${pinjamanAmount}

Create pembayaran pinjaman
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can create pembayaran pinjaman
    AppiumLibrary.Input Text    //*[@content-desc="Total (Rp.)"]    ${amount}
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Anda yakin untuk membuat transaksi berikut ini?"]    5    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Tidak ada anggota dengan pinjaman aktif"]    10    None
    Capture Page Screenshot    pinjamEmpty.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]

Check and create denda
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can check pinjaman
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Anggota"]
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Tinjauan ${name}"]    10    None
    ${dendaOLD}    Get price    15
    Capture Page Screenshot    dendaOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    Run Keyword    Create denda    ${name}    ${amount}    ${dendaOLD}

Get price
    [Arguments]    ${instance}
    [Documentation]    This will split the string of the price which can be separated by space and return the int price value
    ${priceString}    Get Element Attribute    //android.view.View[@instance="${instance}"]    contentDescription
    ${priceList}    Split String    ${priceString}    ${SPACE}
    ${priceActual}    Get From List    ${priceList}    1
    [Return]    ${priceActual}

Create denda
    [Arguments]    ${name}    ${amount}    ${dendaOLD}
    [Documentation]    Here group admin can create and validate denda
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Denda"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Total (Rp.)"]    10    None
    AppiumLibrary.Input Text    //*[@content-desc="Total (Rp.)"]    ${amount}
    AppiumLibrary.Input Text    //*[@text="Deskripsi"]    TEST
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    #Go back and check in Tinjauan Kelompok Saya
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Anggota"]
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Tinjauan ${name}"]    10    None
    ${dendaNew}    Get price    15
    ${diff}    Evaluate    ${dendaNew}-${dendaOLD}
    Should Be Equal As Integers    ${diff}    ${amount}
    Capture Page Screenshot    dendaNEW.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]

Check and create pengeluaran
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can check pinjaman
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${pengeluaranBegin}    Get price    13
    Capture Page Screenshot    keluarOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    Run Keyword    Create pengeluaran    ${amount}    ${pengeluaranBegin}

Create pengeluaran
    [Arguments]    ${amount}    ${pengeluaranOLD}
    [Documentation]    Here group admin can create and validate pengeluaran
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Pengeluaran admin"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Total (Rp.)"]    10    None
    AppiumLibrary.Input Text    //*[@content-desc="Total (Rp.)"]    ${amount}
    AppiumLibrary.Input Text    //*[@text="Deskripsi"]    TEST
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    #Go back and check in Tinjauan Kelompok Saya
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${pengeluaranNew}    Get price    13
    ${diff}    Evaluate    ${pengeluaranOLD}-${pengeluaranNew}
    ${diff2}    Evaluate    ${diff}*1000
    Should Be Equal As Integers    ${diff2}    ${amount}
    Capture Page Screenshot    keluarNEW.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]

Create pembayaran dana sosial
    [Arguments]    ${oldDS}    ${name}    ${amount}
    [Documentation]    Here group admin can create and validate usage of dana sosial
    AppiumLibrary.Input Text    //*[@content-desc="Total (Rp.)"]    ${amount}
    AppiumLibrary.Input Text    //*[@text="Deskripsi"]    TEST
    AppiumLibrary.Click Element    //*[@content-desc="BUAT"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="OK"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi sukses dibuat"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="OK"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Beranda"]    10    None
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${dsEND}    Get price    15
    ${diff}    Evaluate    ${oldDS}-${dsEND}
    ${diff2}    Evaluate    ${diff}*1000
    Should Be Equal As Integers    ${diff2}    ${amount}
    Capture Page Screenshot    dsNew.png

Check and create pembayaran dana sosial
    [Arguments]    ${name}    ${amount}
    [Documentation]    Here group admin can check saham
    AppiumLibrary.Click Element    //*[@instance="10"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Ringkasan"]    10    None
    ${dsBegin}    Get price    15
    Capture Page Screenshot    dsOLD.png
    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    AppiumLibrary.Click Element    //*[@content-desc="Buat Transaksi"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Jenis Transaksi"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="Penggunaan dana sosial"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru"]    10    None
    AppiumLibrary.Click Element    //*[@content-desc="${name}"]
    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Total (Rp.)"]    10    None
    #Get sisa terima dana sosial, if it's 0, cannot perform
    ${left}    Get Element Attribute    //android.view.View[@instance="12"]    contentDescription
    Run Keyword If    ${left} != 0    Create pembayaran dana sosial    ${dsBegin}    ${name}    ${amount}
    ...    ELSE    Run Keywords    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    ...    AND    AppiumLibrary.Click Element    //android.view.View[@instance="1"]
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    //*[@content-desc="Transaksi Baru"]    5    None

Swipe until element
    [Documentation]    Not fully working yet
    ${el}    Run Keyword And Return Status    Wait Until Page Contains Element    //*[@content-desc="test21Feb"]
    Run Keyword If    ${el}!="FALSE"    Swipe By Percent    90    90    90    70
    [Return]    ${el}
