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
                // Run the Maven package command
                sh './mvnw package -DskipTests -Dcheckstyle.skip=true'
                // Stash the JAR file(s) for use in later stages
                stash includes: 'target/*.jar', name: 'built-jars'
            }
        }

        // stage('Execute') {
        //     steps {
        //         // Restore the stashed JAR file(s)
        //         unstash 'built-jars'
        //         // Now you can use the JAR file(s) in this stage
        //         script {
        //             // Find the JAR file name since the wildcard '*' cannot be used directly with the java command
        //             def jar = sh(script: "ls target/*.jar", returnStdout: true).trim()
        //             sh "JENKINS_NODE_COOKIE=dontKillMe nohup java -jar ${jar} --server.port=8000 &"
        //         }
        //     }
        // }

        stage('Ansible Deployment') {
            steps {
                script {
                    sh 'ansible-playbook -i /usr/share/jenkins/ref/inventory /usr/share/jenkins/ref/playbook.yml'
                }
            }
        }
    }
}