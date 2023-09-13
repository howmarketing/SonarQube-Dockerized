#!/bin/bash

# docker up container
docker compose up -d

docker ps

script_dir=$(dirname "$0")
script_dir="$script_dir/../Application"

# To run as root docker exec -u 0 -it <container_na6me> /bin/bash
