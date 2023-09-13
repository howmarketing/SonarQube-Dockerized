#!/bin/bash

# This script is used to download and install SonarQube scanner

# Define temporary directory for downloads
tmp_dir="/tmp"

# Define the directory where the scanner will be installed
OPT_DIR="/var/opt"

# Check if the temporary directory exists, if not create it
if [ ! -d "$tmp_dir" ]; then
    mkdir -p "$tmp_dir"
fi

# Change to the temporary directory
cd "$tmp_dir" || exit

# Check if the script is being run as root, if not exit with an error message
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Prompt the user to enter their operating system
read -p "Which OS are you using? (windows, linux, mac): " os_name

# Check if the user entered a value for the operating system, if not exit with an error message
if [ -z "$os_name" ]; then
    echo "OS name cannot be empty"
    exit 1
fi

# Convert the operating system name to lowercase
os_name="${os_name,,}"

# Map the operating system name to the corresponding SonarQube scanner version
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
    # If the operating system is not supported, exit with an error message
    echo "Unsupported OS"
    exit 1
    ;;
esac

# Define the URL for downloading the SonarQube scanner
DOWNLOAD_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SCANNER_VERSION}.zip"

# Check if the installation directory exists, if not create it
if [ ! -d "${OPT_DIR}" ]; then
    mkdir -p "${OPT_DIR}"
fi

# Download the SonarQube scanner
wget -q -O "${TMP_DIR}/${SCANNER_VERSION}.zip" "$DOWNLOAD_URL"

# Unzip the downloaded file
unzip "${TMP_DIR}/${SCANNER_VERSION}.zip" -d "${TMP_DIR}"

# Remove the downloaded zip file
rm "${TMP_DIR}/${SCANNER_VERSION}.zip"

# Define the directory name of the unzipped scanner
SCANNER_DIR="${SCANNER_VERSION/-cli/}"

# Move the unzipped scanner to the installation directory
mv "${TMP_DIR}/${SCANNER_DIR}" "${OPT_DIR}"

# Print a success message with the installation location
echo "SonarQube scanner installed to ${OPT_DIR}/${SCANNER_DIR}"
