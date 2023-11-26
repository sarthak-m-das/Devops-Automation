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
                // Checks out the source code from the GitHub repository
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic'
            }
        }
        
        // stage('Unit Tests') {
        //     steps {
        //         sh './mvnw test -Dcheckstyle.skip=true'
        //     }
        // }
        
        // stage('SonarQube Tests') {
        //     environment {
        //         scannerHome = tool 'SonarQube'
        //     }
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=spring-petclinic -Dsonar.java.binaries=target/classes"
        //         }
        //         timeout(time: 10, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        stage('Build') {
            steps {
                sh './mvnw package -DskipTests -Dcheckstyle.skip=true'
                // Copy the JAR file to a specific location
                sh 'mkdir -p $WORKSPACE/jars && cp target/*.jar $WORKSPACE/jars/petclinic.jar'
            }
        }

        stage('Ansible Deployment') {
            steps {
                script {
                    sh 'ansible-playbook -i /usr/share/jenkins/ref/inventory /usr/share/jenkins/ref/playbook.yml -vvv'
                }
            }
        }
    }
}