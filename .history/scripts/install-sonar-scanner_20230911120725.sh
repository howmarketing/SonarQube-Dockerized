#!/bin/bash

TMP_DIR="/tmp"
OPT_DIR="/var/opt"
OS_SYSTEM="mac"
# Verify if the directory exists, if not, create it
if [ ! -d "$OPT_DIR" ]; then
    sudo mkdir -p $OPT_DIR
fi
# Change to the directory, if it doesn't exist, create it and change to it or exit
cd $TMP_DIR || mkdir -p $TMP_DIR && cd $TMP_DIR || exit

# The `prompt_user`  It is used to prompt the user for input and validate their response.
prompt_user() {
    read -p "$1" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Exiting..."
        exit 1
    fi
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# ask by input prompt user which os did he is using saving user answer to an variable called user_answer
# //TODO: Change the read to use the prompt_user function
read -p "Which OS are you using? (windows, linux, mac): " user_answer

# check if user_answer is equal to windows
if [ "$user_answer" = "windows" ]; then
    # set variable windows to true
    OS_SYSTEM="windows"
    # check if user_answer is equal to linux
elif [ "$user_answer" = "linux" ]; then
    # set variable linux to true
    OS_SYSTEM="linux"
    # check if user_answer is equal to mac
elif [ "$user_answer" = "mac" ]; then
    # set variable mac to true
    OS_SYSTEM="mac"
    # if user_answer is not equal to windows, linux or mac
else
    # print error message
    echo "Unsupported OS"
    # exit script with exit code 1
    exit 1
fi

# define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-windows" if OS_SYSTEM === "windows" else if OS_SYSTEM === "linux" define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-linux" else if OS_SYSTEM === "mac" define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-macosx" else print error message and exit script with exit code 1
if [ "$OS_SYSTEM" == "windows" ]; then
    # if OS_SYSTEM === "windows" then define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-windows"
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-windows"
elif [ "$OS_SYSTEM" == "linux" ]; then
    # if OS_SYSTEM === "linux" then define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-linux"
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-linux"
elif [ "$OS_SYSTEM" == "mac" ]; then
    # if OS_SYSTEM === "mac" then define SONAR_SCANNER_VERSION as "sonar-scanner-cli-5.0.1.3006-macosx"
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-macosx"
else
    echo "Error: Invalid OS_SYSTEM value. Please set it to either 'windows', 'linux', or 'mac'."
    exit 1
fi 

# https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-macosx.zip?_gl=1*1a9hhpt*_gcl_aw*R0NMLjE2OTQxMzU2NDkuRUFJYUlRb2JDaE1JMm9LOGgtdVpnUU1WbEVGSUFCM1ZXdzMwRUFBWUFTQUFFZ0tzbV9EX0J3RQ..*_gcl_au*MzgwODUzMzA2LjE2OTQxMzU2NDk.*_ga*OTQyNzQyNDIyLjE2OTQxMzU2NDk.*_ga_9JZ0GZ5TC6*MTY5NDE5Mjk3OC4yLjEuMTY5NDE5MzAxMC4yOC4wLjA
DOWNLOAD_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_VERSION}.zip?_gl=1*1a9hhpt*_gcl_aw*R0NMLjE2OTQxMzU2NDkuRUFJYUlRb2JDaE1JMm9LOGgtdVpnUU1WbEVGSUFCM1ZXdzMwRUFBWUFTQUFFZ0tzbV9EX0J3RQ..*_gcl_au*MzgwODUzMzA2LjE2OTQxMzU2NDk.*_ga*OTQyNzQyNDIyLjE2OTQxMzU2NDk.*_ga_9JZ0GZ5TC6*MTY5NDE5Mjk3OC4yLjEuMTY5NDE5MzAxMC4yOC4wLjA"

echo "Downloading sonar-scanner....."
# wget -q -O "sonar-scanner-cli-5.0.1.3006-macosx.zip" "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-macosx.zip?_gl=1*1a9hhpt*_gcl_aw*R0NMLjE2OTQxMzU2NDkuRUFJYUlRb2JDaE1JMm9LOGgtdVpnUU1WbEVGSUFCM1ZXdzMwRUFBWUFTQUFFZ0tzbV9EX0J3RQ..*_gcl_au*MzgwODUzMzA2LjE2OTQxMzU2NDk.*_ga*OTQyNzQyNDIyLjE2OTQxMzU2NDk.*_ga_9JZ0GZ5TC6*MTY5NDE5Mjk3OC4yLjEuMTY5NDE5MzAxMC4yOC4wLjA"
wget -q -O "${SONAR_SCANNER_VERSION}.zip" "$DOWNLOAD_URL" && echo "Download completed."

echo "Unzipping downloaded file..."
# unzip "sonar-scanner-cli-5.0.1.3006-macosx.zip"
unzip "${SONAR_SCANNER_VERSION}.zip" && echo "Unzip completed."
# rm "sonar-scanner-cli-5.0.1.3006-macosx.zip"
rm "${SONAR_SCANNER_VERSION}.zip"

echo "Installing to opt..."
sudo rm -rf "${OPT_DIR}/${SONAR_SCANNER_VERSION}"
SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION//-cli/}
echo ""
echo ""
echo ""
echo "-------------------------------------------"
echo "$SONAR_SCANNER_VERSION"
echo "-------------------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
sleep 15
sudo mv "${SONAR_SCANNER_VERSION}" $OPT_DIR


