*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}    Admin
${PASSWORD}    admin123
${INVALID_USER}    NguyenNhuY
${INVALID_PASS}    123

*** Test Cases ***
Đăng Nhập Đúng
    Mở Trình Duyệt
    Vào Trang Login
    Điền Tài Khoản Và Mật Khẩu    ${USERNAME}    ${PASSWORD}
    Bấm Nút Login
    Kiểm Tra Đăng Nhập Thành Công
    Chờ Một Chút
    Đóng Trình Duyệt

Đăng Nhập Sai
    Mở Trình Duyệt
    Vào Trang Login
    Điền Tài Khoản Và Mật Khẩu    ${INVALID_USER}    ${INVALID_PASS}
    Bấm Nút Login
    Kiểm Tra Đăng Nhập Thất Bại
    Chờ Một Chút
    Đóng Trình Duyệt

*** Keywords ***
Mở Trình Duyệt
    Open Browser    ${URL}    chrome
    Maximize Browser Window

Vào Trang Login
    Go To    ${URL}

Điền Tài Khoản Và Mật Khẩu
    [Arguments]    ${tk}    ${mk}
    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=10s
    Input Text    xpath=//input[@name='username']    ${tk}
    Input Text    xpath=//input[@name='password']    ${mk}

Bấm Nút Login
    Click Element    xpath=//button[@type='submit']

Kiểm Tra Đăng Nhập Thành Công
    Wait Until Page Contains Element    xpath=//h6[text()='Dashboard']    timeout=20s
    Log To Console    Đăng nhập thành công

Kiểm Tra Đăng Nhập Thất Bại
    Wait Until Element Is Visible    xpath=//div[contains(@class,'oxd-alert-content')]//p    timeout=20s
    Element Text Should Be    xpath=//div[contains(@class,'oxd-alert-content')]//p    Invalid credentials
    Log To Console    Đăng nhập thất bại

Chờ Một Chút
    Sleep    5s

Đóng Trình Duyệt
    Close Browser
