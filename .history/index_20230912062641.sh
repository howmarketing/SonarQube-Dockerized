#!/bin/bash

# docker up container
docker compose up -d

docker ps

# To run as root docker exec -u 0 -it <container_name> /bin/bash
