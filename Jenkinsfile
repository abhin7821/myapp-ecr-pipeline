pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        IMAGE_NAME = 'myapp-ecr'
        ECR_REPO = '442122590814.dkr.ecr.us-east-1.amazonaws.com/myapp1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/abhin7821/myapp-ecr-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "Building Docker image..."
                    docker build -t $IMAGE_NAME:latest .
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withAWS(credentials: 'aws_ecr', region: "${AWS_REGION}") {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                sh '''
                    echo "Tagging and pushing image to ECR..."
                    docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Image successfully built and pushed to ECR!"
        }
        failure {
            echo "❌ Build failed, check logs."
        }
    }
}
