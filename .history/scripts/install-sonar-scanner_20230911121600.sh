#!/bin/bash

TMP_DIR="/tmp"
OPT_DIR="/var/opt"
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi
read -p "Which OS are you using? (windows, linux, mac): " os_name
os_name="${os_name,,}" # convert to lowercase

# Map OS name to scanner version
case $os_name in
windows)
    SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-windows"
    ;;
linux)
    SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-linux"
    ;;
mac)
    SCANNER_VERSION="sonar-scanner-cli-5.0.1.3006-macosx"
    ;;
*)
    echo "Unsupported OS"
    exit 1
    ;;
esac
DOWNLOAD_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SCANNER_VERSION}.zip"
if [ ! -d "${OPT_DIR}" ]; then
    mkdir -p "${OPT_DIR}"
fi
wget -q -O "${TMP_DIR}/${SCANNER_VERSION}.zip" "$DOWNLOAD_URL"
unzip "${TMP_DIR}/${SCANNER_VERSION}.zip" -d "${TMP_DIR}"
rm "${TMP_DIR}/${SCANNER_VERSION}.zip"
SCANNER_DIR="${SCANNER_VERSION/-cli/}"
mv "${TMP_DIR}/${SCANNER_DIR}" "${OPT_DIR}"
echo "SonarQube scanner installed to ${OPT_DIR}/${SCANNER_DIR}"
