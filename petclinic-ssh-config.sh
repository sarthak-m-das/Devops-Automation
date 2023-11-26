#!/bin/bash

# Access Jenkins container and generate SSH key pair
docker exec -it jenkins ssh-keygen -t rsa -b 4096 -f /var/jenkins_home/petclinic-key -N ""
echo "SSH key pair generated inside Jenkins container."

# Copy the SSH public key to the petclinic container using ssh-copy-id
docker exec -it jenkins ssh-copy-id -i /var/jenkins_home/petclinic-key.pub petclinic@petclinic

echo "SSH setup complete."
