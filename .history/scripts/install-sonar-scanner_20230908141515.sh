#!/bin/bash

cd /tmp || exit

echo "Downloading sonar-scanner....."
if [ -d "/tmp/sonar-scanner-cli-4.7.0.2747-linux.zip" ]; then
    sudo rm /tmp/sonar-scanner-cli-4.7.0.2747-linux.zip
fi

wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-macosx.zip?_gl=1*raycaw*_gcl_aw*R0NMLjE2OTQxMzU2NDkuRUFJYUlRb2JDaE1JMm9LOGgtdVpnUU1WbEVGSUFCM1ZXdzMwRUFBWUFTQUFFZ0tzbV9EX0J3RQ..*_gcl_au*MzgwODUzMzA2LjE2OTQxMzU2NDk.*_ga*OTQyNzQyNDIyLjE2OTQxMzU2NDk.*_ga_9JZ0GZ5TC6*MTY5NDE5Mjk3OC4yLjEuMTY5NDE5MzAxMC4yOC4wLjA.
echo "Download completed."

echo "Unziping downloaded file..."
unzip sonar-scanner-cli-4.7.0.2747-linux.zip
echo "Unzip completed."
rm sonar-scanner-cli-4.7.0.2747-linux.zip

echo "Installing to opt..."
if [ -d "/var/opt/sonar-scanner-4.7.0.2747-linux" ]; then
    sudo rm -rf /var/opt/sonar-scanner-4.7.0.2747-linux
fi
sudo mv sonar-scanner-4.7.0.2747-linux /var/opt
