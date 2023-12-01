#!/bin/bash

# Start docker containers
docker-compose -f docker-compose.yml up -d

# Wait for petclinic container to be up
echo "Wait for the containers to be up..."
sleep 20

echo "running petclinic-ssh-config shell script..."
source ./ssh-key-config.sh

curl -X POST http://localhost:8080/job/spring-petclinic/build
echo "running pipeline ..."
sleep 10

# Function to check the status of the last build
check_build_status() {
    local job_name=$1
    local build_status=$(curl -su xyz:xyz http://localhost:8080/job/${job_name}/lastBuild/api/json | jq -r '.building')

    echo $build_status
}

# Polling Jenkins job status
while true; do
    status=$(check_build_status "spring-petclinic")
    
    if [ "$status" == "false" ]; then
        echo "Build finished"
        break
    else
        echo "Build is still running..."
        sleep 10
    fi
done

echo "Deployment ready on: http://localhost:8000/"
