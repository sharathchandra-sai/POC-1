pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/project-1.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Code Quality') {
            steps {
                sh 'mvn sonar:sonar'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'dependency-check.sh --project Project-1 --scan src'
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh 'docker build -t your-dockerhub/project-1 .'
                sh 'docker push your-dockerhub/project-1'
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh 'trivy image your-dockerhub/project-1'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8080:8080 your-dockerhub/project-1'
            }
        }
    }
}
