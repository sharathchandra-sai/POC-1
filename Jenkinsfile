pipeline {
    agent any

    environment {
        SONAR_PROJECT_KEY = 'Sharath'
        SONAR_HOST_URL = 'http://3.1.148.127:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sharathchandra-sai/POC-1.git'
            }
        }

        stage('Code Quality') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            environment {
                SONAR_TOKEN = credentials('Sonar-kodati') // Must exist in Jenkins credentials
            }
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                          -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }
        
        stage('Prepare Artifact') {
            steps {
                sh 'cp target/project-1-1.0.0.jar target/project-1.jar'
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
