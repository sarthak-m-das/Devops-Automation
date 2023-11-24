FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

USER root
RUN apt-get update && apt-get install -y ansible
USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml
COPY ansible-inventory /usr/share/jenkins/ref/inventory
COPY ansible-playbook.yml /usr/share/jenkins/ref/playbook.yml
COPY petclinic /usr/share/jenkins/ref/petclinic