#!/bin/bash
docker-compose -f docker-compose1.yml up -d

echo "40 seconds sleep..."
sleep 40

echo "running sonar-config shell script..."
source ./sonar-config.sh

export SONARQUBE_TOKEN=$(jq -r '.token' token.json)

echo "The token generated is $SONARQUBE_TOKEN"

SONAR_TOKEN="$SONARQUBE_TOKEN" docker-compose -f docker-compose2.yml up -d