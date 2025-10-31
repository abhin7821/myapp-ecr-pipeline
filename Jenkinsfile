pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        IMAGE_NAME = 'myapp-ecr'
        ECR_REPO = '442122590814.dkr.ecr.us-east-1.amazonaws.com/myapp'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo '📥 Checking out source code from GitHub...'
                git branch: 'main', url: 'https://github.com/abhin7821/myapp-ecr-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh '''
                    # Disable BuildKit to avoid stream errors on t2.micro instances
                    export DOCKER_BUILDKIT=0
                    echo "Starting classic Docker build..."
                    docker build -t $IMAGE_NAME:latest .
                    echo "✅ Docker image built successfully."
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                echo '🔐 Logging in to AWS ECR...'
                withAWS(credentials: 'aws_ecr', region: "${AWS_REGION}") {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | \
                        docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                echo '🚀 Tagging and pushing Docker image to ECR...'
                sh '''
                    docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                    echo "✅ Image pushed successfully to: $ECR_REPO:latest"
                '''
            }
        }
    }

    post {
        success {
            echo "🎉 SUCCESS: Image successfully built and pushed to ECR!"
        }
        failure {
            echo "❌ Build failed. Check logs above for details."
        }
    }
}
