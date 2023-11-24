#!/bin/bash

# Install SSH server in the petclinic container
docker exec petclinic apt-get update
docker exec petclinic apt-get install -y openssh-server

# Start SSH service in the petclinic container
docker exec petclinic service ssh start

# Create a user for SSH in the petclinic container (replace 'username' and 'password')
docker exec petclinic useradd -m username
docker exec petclinic bash -c "echo username:password | chpasswd"

# Access Jenkins container and generate SSH key pair
docker exec -it jenkins ssh-keygen -t rsa -b 4096 -f /var/jenkins_home/petclinic-key -N ""
echo "SSH key pair generated inside Jenkins container."

# Copy the SSH public key to the petclinic container using ssh-copy-id
docker exec -it jenkins ssh-copy-id -i /var/jenkins_home/petclinic-key.pub username@petclinic

echo "SSH setup complete."
