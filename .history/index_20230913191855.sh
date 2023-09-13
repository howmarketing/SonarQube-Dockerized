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

script_file="$script_dir/index.sh"
echo -e "\n\n\n===================================================\n"
echo -e "\t\t SCRIPT FILE"
echo -e "--------------------------------------------------------------------\n"
echo "${script_file}"
echo -e "\n===================================================\n\n\n\n\n\n\n\n"
sleep 15

bash $script_file

#

# To run as root docker exec -u 0 -it <container_na6me> /bin/bash
