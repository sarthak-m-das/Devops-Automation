#!/bin/bash
docker-compose -f docker-compose-sonar.yml up -d

# Wait for sonar container to be up
echo "Wait for the sonar container to be up..."
sleep 40

echo "running sonar-config shell script..."
source ./sonar-config.sh

export SONARQUBE_TOKEN=$(jq -r '.token' token.json)

echo "$SONARQUBE_TOKEN"

# Start Jenkins
SONAR_TOKEN="$SONARQUBE_TOKEN" docker-compose -f docker-compose-jenkins.yml up -d

# Wait for petclinic container to be up
echo "Wait for the containers to be up..."
sleep 20

echo "running petclinic-ssh-config shell script..."
source ./ssh-key-config.sh