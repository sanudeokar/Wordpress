pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id'
        DOCKER_IMAGE = 'sanudeokar/wordpress:wordpress'
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials-id'
        K8S_NAMESPACE = 'default'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from GitHub
                git branch: 'main', url: 'https://github.com/sanudeokar/wordpress'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        def customImage = docker.build(DOCKER_IMAGE)
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f k8s/wordpress-deployment.yaml'
                    sh 'kubectl apply -f k8s/wordpress-service.yaml'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully.'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
