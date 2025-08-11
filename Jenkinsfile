pipeline {
    agent any
    stages {
 stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/HelloWorldApp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Dependency Check') {
            steps {
                sh './dependency-check.sh --project HelloWorldApp --scan .'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t helloworldapp .'
            }
        }
        stage('Trivy Scan') {
            steps {
                sh 'trivy image helloworldapp'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_TOKEN')]) {
                    sh 'docker login -u your-username -p $DOCKER_TOKEN'
                    sh 'docker tag helloworldapp your-username/helloworldapp:latest'
                    sh 'docker push your-username/helloworldapp:latest'
                }
            }
        }
    }
}
