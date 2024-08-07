pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sanudeokar/wordpress'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t sanudeokar/wordpress:wordpress .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials-id', url: 'https://index.docker.io/v1/']) {
                    bat 'docker push sanudeokar/wordpress:wordpress'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-credentials-id', variable: 'KUBECONFIG')]) {
                    bat 'kubectl apply -f k8s/wordpress-deployment.yaml'
                    bat 'kubectl apply -f k8s/wordpress-service.yaml'
                }
            }
        }
    }
}
