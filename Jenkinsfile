pipeline {
    agent any
    stages {
        stage('Workspace Cleanup') {
            steps {
                cleanWs()
            }
        }
        stage('Github Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic'
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh './mvnw test -Dcheckstyle.skip=true'
            }
        }

        stage('Build') {
            steps {
                sh './mvnw package -DskipTests -Dcheckstyle.skip=true'
                sh 'mkdir -p $WORKSPACE/jars && cp target/*.jar $WORKSPACE/jars/petclinic.jar'
            }
        }

        stage('Ansible Deployment') {
            steps {
                ansiblePlaybook(
                    playbook: '/usr/share/jenkins/ref/playbook.yml',
                    inventory: '/usr/share/jenkins/ref/inventory',
                    extras: '-vvv'
                )
            }
        }
    }
}