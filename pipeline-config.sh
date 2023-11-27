#!/bin/bash

# Start docker containers
docker-compose -f docker-compose.yml up -d

# Wait for petclinic container to be up
echo "Wait for the containers to be up..."
sleep 20

echo "running petclinic-ssh-config shell script..."
source ./ssh-key-config.sh