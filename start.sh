#!/bin/bash
# docker-compose -f docker-compose-sonar.yml up -d

# Wait for sonar container to be up
# sleep 40

# echo "running sonar-config shell script..."
# source ./sonar-config.sh

# export SONARQUBE_TOKEN=$(jq -r '.token' token.json)

# echo "The token generated is $SONARQUBE_TOKEN"

# Start petclinic container
docker-compose -f docker-compose-petclinic.yml up -d

# Wait for petclinic container to be up
echo "Wait for petclinic container to be up..."
# sleep 10

# Start Jenkins
docker-compose -f docker-compose-jenkins.yml up -d

# Wait for petclinic container to be up
echo "Wait for jenkins container to be up..."
# sleep 20

echo "running petclinic-ssh-config shell script..."
source ./petclinic-ssh-config.sh