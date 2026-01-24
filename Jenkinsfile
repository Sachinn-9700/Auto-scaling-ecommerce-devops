pipeline {
    agent any
    environment {
        PATH = "$PATH:/usr/local/bin/"
        // Git repository URL
        GIT_REPO_URL = "https://github.com/Sachinn-9700/Auto-scaling-ecommerce-devops.git"
        // Docker Hub credentials
        DOCKER_HUB_TOKEN = credentials("docker_hub_token")
        // Docker image name
        BACKEND_IMAGE = "sachinn9700/ecommerce-backend"
        FRONTEND_IMAGE = "sachinn9700/ecommerce-frontend"
        TAG = "v1"
    }
    stages {
        stage('Checkout Code') {
            steps { 
                git branch: 'main', url: "${GIT_REPO_URL}"
            }
        }
        stage('Build Backend Image') {
            steps {
                sh "docker build -t ${BACKEND_IMAGE}:${TAG} app/backend"
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh "docker build -t ${FRONTEND_IMAGE}:${TAG} app/frontend"
            }
        }

        stage('Docker Hub Login') {
            steps {
                sh 'echo "$DOCKER_HUB_TOKEN" | docker login -u sachinn9700 --password-stdin'
            }
        }

        stage('Push Backend Image') {
            steps {
                sh "docker push ${BACKEND_IMAGE}:${TAG}"
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh "docker push ${FRONTEND_IMAGE}:${TAG}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl apply -f k8s/namespace.yaml
                kubectl apply -f k8s/
                """
            }
        }
    }

    post {
        success {
            echo "CI/CD Pipeline Completed Successfully"
        }
        failure {
            echo "Pipeline Failed"
        }
    }
}