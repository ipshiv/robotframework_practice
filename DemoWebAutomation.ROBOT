*** Settings ***
Documentation    Trying Selenium lib and test automation
Library    SeleniumLibrary

*** Test Cases ***
Open Close Browser
    Open Browser    https://huld.io    firefox
    Close Browser
