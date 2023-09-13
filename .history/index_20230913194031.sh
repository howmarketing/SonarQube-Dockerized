#!/bin/bash

# docker up container
# 1. ----------------------------------------------------------------------------------------------------------------
# docker compose up -d
echo -e "\n\n\n===================================================\n"
echo -e "\t\t\tCONTAINERS LIST"
echo -e "--------------------------------------------------------------------\n"
docker container ls --all
echo -e "\n===================================================\n\n\n\n\n\n\n\n"

docker container start sonarqube
docker container start sonarqube-database
echo -e "\n\n\n===================================================\n"
echo -e "\t\t RUNNING CONTAINERS LIST"
echo -e "--------------------------------------------------------------------\n"
docker ps
echo -e "\n===================================================\n\n\n\n\n\n\n\n"

REAL_PATH=$(dirname "$0")
script_dir="${REAL_PATH}/scripts"
echo -e "\n\n\n===================================================\n"
echo -e "\t\t SCRIPT DIR"
echo -e "--------------------------------------------------------------------\n"
echo "${script_dir}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 3

# Define the script file to be executed as the index.sh
# - Which is the sonar scanner installation script
script_file="$script_dir/index.sh"
ROOT_SCRIPT="${script_file}"
echo -e "\n\n\n===================================================\n"
echo -e "\t\t SCRIPT FILE"
echo -e "--------------------------------------------------------------------\n"
echo "${ROOT_SCRIPT}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 15

# execute the script for the sonar scanner installation
bash $ROOT_SCRIPT

# back to the root folder
cd ..

# 1. ----------------------------------------------------------------------------------------------------------------

# 2. ----------------------------------------------------------------------------------------------------------------
# Display the current path
echo -e "\n\n\n===================================================\n"
echo -e "\t\t CURRENT PATH"
echo -e "--------------------------------------------------------------------\n"
echo "${PWD}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5

# define the script file path to be executed as the application clone script
script_dir="${REAL_PATH}/scripts/Application/create-application-folder.sh"
CLONE_APPLICATION_SCRIPT="${script_dir}"
# Display the current path
echo -e "\n\n\n===================================================\n"
echo -e "\t\t CLONE THE APPLICATION SCRIPT "
echo -e "--------------------------------------------------------------------\n"
echo "${CLONE_APPLICATION_SCRIPT}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5
echo -e "\n\n\n===================================================\n"
echo -e "\t\t EXECUTING THE APPLICATION CLONE SCRIPT "
echo -e "--------------------------------------------------------------------\n"
bash $CLONE_APPLICATION_SCRIPT
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5
# 2. ----------------------------------------------------------------------------------------------------------------

# 3. ----------------------------------------------------------------------------------------------------------------
script_dir="${REAL_PATH}/scripts/Application/run-sonar-scanner-into-application.sh"
RUN_SONAR_SCANNER_SCRIPT="${script_dir}"
# Display the current path
echo -e "\n\n\n===================================================\n"
echo -e "\t\t RUN SONAR SCANNER SCRIPT "
echo -e "--------------------------------------------------------------------\n"
echo "${RUN_SONAR_SCANNER_SCRIPT}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5

echo -e "\n\n\n===================================================\n"
echo -e "\t\t EXECUTING THE RUN SONAR SCANNER SCRIPT "
echo -e "--------------------------------------------------------------------\n"
bash $RUN_SONAR_SCANNER_SCRIPT
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5
# 3. ----------------------------------------------------------------------------------------------------------------

# 4. ----------------------------------------------------------------------------------------------------------------

# define the cloned application directory
script_dir="${REAL_PATH}/Application/ui"
CLONED_APPLICATION_DIRECTORY="${script_dir}"
# Display the current path
echo -e "\n\n\n===================================================\n"
echo -e "\t\t CLONED APPLICATION DIRECTORY "
echo -e "--------------------------------------------------------------------\n"
echo "${CLONED_APPLICATION_DIRECTORY}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5

# GET IN, INTO THE CLONEDAPPLICATION FOLDER
cd $CLONED_APPLICATION_DIRECTORY
echo -e "\n\n\n===================================================\n"
echo -e "\t\t CURRENT PATH SOULD BE THE CLONED APPLICATION FOLDER "
echo -e "--------------------------------------------------------------------\n"
echo "${PWD}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5
# 4. ----------------------------------------------------------------------------------------------------------------
# To run as root docker exec -u 0 -it <container_na6me> /bin/bash
