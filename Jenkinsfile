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
                SONAR_TOKEN = credentials('Sonar') // Must exist in Jenkins credentials
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
                withCredentials([usernamePassword(credentialsId: 'Docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker build -t sharathkodati/sharathproject-1 .'
                    sh 'docker push sharathkodati/sharathproject-1'
                }
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh '''
                    if ! command -v trivy &> /dev/null; then
                      echo "Trivy not installed. Skipping scan."
                      exit 0
                    fi
        
                    trivy image sharathkodati/sharathproject-1 || echo "Trivy scan failed, continuing pipeline"
                '''
            }

        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8081:8080 sharathkodati/sharathproject-1'
            }
        }
    }
}
