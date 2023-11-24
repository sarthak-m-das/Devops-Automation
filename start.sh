#!/bin/bash
# docker-compose -f docker-compose1.yml up -d

# echo "40 seconds sleep..."
# sleep 40

# echo "running sonar-config shell script..."
# source ./sonar-config.sh

# export SONARQUBE_TOKEN=$(jq -r '.token' token.json)

# echo "The token generated is $SONARQUBE_TOKEN"

#!/bin/bash

# Start petclinic container
docker-compose -f docker-compose2.yml up -d

# Wait a bit to ensure the container is up
sleep 10

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f petclinic-key -N ""
echo "SSH key pair generated."

# Install SSH server in the petclinic container
docker exec petclinic apt-get update
docker exec petclinic apt-get install -y openssh-server

# Start SSH service in the container
docker exec petclinic service ssh start

# Create a user for SSH (change 'username' and 'password' to your desired values)
docker exec petclinic useradd -m username
docker exec petclinic bash -c "echo username:password | chpasswd"

# (Optional) Set up SSH key-based authentication
docker exec petclinic mkdir -p /home/username/.ssh
docker cp petclinic-key.pub petclinic:/home/username/.ssh/authorized_keys
docker exec petclinic chown username:username /home/username/.ssh/authorized_keys
docker exec petclinic chmod 600 /home/username/.ssh/authorized_keys
docker exec petclinic chmod 700 /home/username/.ssh

echo "SSH setup complete."

# Start Jenkins
docker-compose -f docker-compose3.yml up -d
