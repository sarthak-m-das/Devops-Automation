FROM jenkins/jenkins:latest

# Set environment variables
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Switch to root to install packages
USER root

# Update packages and install Ansible and OpenSSH Server
RUN apt-get update && \
    apt-get install -y ansible openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create SSH directory and set permissions
RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

# Switch back to the Jenkins user
USER jenkins

# Copy plugin list and configuration files
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml

# Copy Ansible inventory, playbook, and SSH key
COPY ansible-inventory /usr/share/jenkins/ref/inventory
COPY ansible-playbook.yml /usr/share/jenkins/ref/playbook.yml
COPY petclinic-key /usr/share/jenkins/ref/petclinic-key

# Set correct permissions for the SSH key
USER root
RUN chmod 600 /usr/share/jenkins/ref/petclinic-key
RUN chmod 755 /home
USER jenkins
