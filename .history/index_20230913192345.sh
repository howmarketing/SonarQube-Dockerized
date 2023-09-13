#!/bin/bash

# docker up container
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

script_dir=$(dirname "$0")
script_dir="${script_dir}/scripts"
echo -e "\n\n\n===================================================\n"
echo -e "\t\t SCRIPT DIR"
echo -e "--------------------------------------------------------------------\n"
echo "${script_dir}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 3

# Define the script file to be executed as the index.sh
# - Which is the sonar scanner installation script
script_file="$script_dir/index.sh"
echo -e "\n\n\n===================================================\n"
echo -e "\t\t SCRIPT FILE"
echo -e "--------------------------------------------------------------------\n"
echo "${script_file}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 15

# execute the script for the sonar scanner installation
bash $script_file
# back to the root folder
cd ..

# Display the current path
echo -e "\n\n\n===================================================\n"
echo -e "\t\t CURRENT PATH"
echo -e "--------------------------------------------------------------------\n"
echo "${PWD}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 5

# To run as root docker exec -u 0 -it <container_na6me> /bin/bash
