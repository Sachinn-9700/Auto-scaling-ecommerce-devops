pipeline {
    agent any

    environment {
        // Ensure required binaries are reachable
        PATH = "$PATH:/usr/bin:/usr/local/bin"

        // Git repository
        GIT_REPO_URL = "https://github.com/Sachinn-9700/Auto-scaling-ecommerce-devops.git"

        // Docker Hub token (already confirmed by you)
        DOCKER_HUB_TOKEN = credentials("docker_hub_token")

        // Docker images
        BACKEND_IMAGE  = "sachinn9700/ecommerce-backend"
        FRONTEND_IMAGE = "sachinn9700/ecommerce-frontend"

        // Image tag
        TAG = "latest"

        // Kubeconfig path for Jenkins user
        KUBECONFIG = "/home/jenkins/.kube/config"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO_URL}"
            }
        }

        // Install / upgrade Prometheus & Grafana on EKS
        stage('Setup Monitoring') {
            steps {
                sh '''
                chmod +x eks-monitoring-setup.sh
                ./eks-monitoring-setup.sh
                '''
            }
        }

        // Build backend Docker image
        stage('Build Backend Image') {
            steps {
                sh """
                docker build -t ${BACKEND_IMAGE}:${TAG} app/backend
                """
            }
        }

        // Build frontend Docker image
        stage('Build Frontend Image') {
            steps {
                sh """
                docker build -t ${FRONTEND_IMAGE}:${TAG} app/frontend
                """
            }
        }

        // Login to Docker Hub using token
        stage('Docker Hub Login') {
            steps {
                sh '''
                echo "$DOCKER_HUB_TOKEN" | docker login -u sachinn9700 --password-stdin
                '''
            }
        }

        // Push backend image
        stage('Push Backend Image') {
            steps {
                sh """
                docker push ${BACKEND_IMAGE}:${TAG}
                """
            }
        }

        // Push frontend image
        stage('Push Frontend Image') {
            steps {
                sh """
                docker push ${FRONTEND_IMAGE}:${TAG}
                """
            }
        }

        // Deploy manifests to EKS
        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl apply -f k8s/namespace.yaml
                kubectl apply -f k8s/

                // Wait for deployments to become ready
                kubectl rollout status deployment/backend-deployment -n ecommerce
                kubectl rollout status deployment/frontend-deployment -n ecommerce
                """
            }
        }
    }
}

