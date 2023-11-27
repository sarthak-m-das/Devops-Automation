#!/bin/bash

#start ssh demon in petclinic
docker exec -it petclinic service ssh start

# generate SSH key pair in jenkins container
docker exec -it jenkins ssh-keygen -f /var/jenkins_home/.ssh/id_rsa -N ""
echo "SSH key pair generated inside Jenkins container."

# Copy the SSH public key to the petclinic container
docker exec -it jenkins sshpass -p password ssh-copy-id -o StrictHostKeyChecking=no username@petclinic

echo "SSH setup complete."
