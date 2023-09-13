#!/bin/bash

# Main script to install SonarQube scanner

echo "Which platform do you want to install the SonarQube scanner on?"
echo "1) Linux"
echo "2) Mac OSX"
echo "3) Windows (Git Bash)"
echo "4) Windows (PowerShell)"

read -p "Enter your choice: " choice

script_dir=$(dirname "$0")

# Change it to execute as realpath not from the user path
case $choice in
1)
    script="$script_dir/install_sonarqube-scanner_centos.sh"
    ;;
2)
    script="$script_dir/install-sonar-scanner-macosx.sh"
    ;;
3)
    script="$script_dir/install-sonar-scanner-windows-bash.sh"
    ;;
4)
    script="$script_dir/install-sonar-scanner-windows-powershell.ps1"
    ;;
*)
    echo "Invalid choice"
    exit 1
    ;;
esac

if [ -f "$script" ]; then
    chmod +x "$script"
    "$script"
else
    echo "Script $script not found"
    exit 1
fi
