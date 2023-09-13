#!/bin/bash
DOWNLOAD_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/...${SONAR_SCANNER_VERSION}.zip?_"
TMP_DIR="/tmp"
OPT_DIR="/var/opt"
OS_SYSTEM="linux"
cd $TMP_DIR || exit
prompt_user() {
    read -p "$1" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Exiting..."
        exit 1
    fi
}
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi
read -p "Which OS are you using? (windows, linux, mac): " user_answer
if [ "$user_answer" = "windows" ]; then
    OS_SYSTEM="windows"
elif [ "$user_answer" = "linux" ]; then
    OS_SYSTEM="linux"
elif [ "$user_answer" = "mac" ]; then
    OS_SYSTEM="mac"
else
    echo "Unsupported OS"
    exit 1
fi
if [ "$OS_SYSTEM" == "windows" ]; then
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-windows"
elif [ "$OS_SYSTEM" == "linux" ]; then
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-linux"
elif [ "$OS_SYSTEM" == "mac" ]; then
    SONAR_SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-macosx"
else
    echo "Error: Invalid OS_SYSTEM value. Please set it to either 'windows', 'linux', or 'mac'."
    exit 1
fi
echo "Downloading sonar-scanner....."
wget -q -O "${SONAR_SCANNER_VERSION}.zip" "$DOWNLOAD_URL" && echo "Download completed."
echo "Unzipping downloaded file..."
unzip "${SONAR_SCANNER_VERSION}.zip" && echo "Unzip completed."
rm "${SONAR_SCANNER_VERSION}.zip"
echo "Installing to opt..."
sudo rm -rf "${OPT_DIR}/${SONAR_SCANNER_VERSION}"
sudo mv "${SONAR_SCANNER_VERSION}" $OPT_DIR
