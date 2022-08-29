pipeline {
    agent any
    environment {
        registry = 'itsmebharatb/capstone'
        registryCredential = 'dockerhub'
    }
    stages {
        stage('Lint with pylint and hadolint') {
            steps {
                println('Lint with pylint and hadolint')
                sh '''
                 hadolint Dockerfile
                '''
            }
        }
        stage('Test') {
            steps {
                println(' test application')
                sh '''
                mvn test
                '''
            }
        }
        stage('Check style') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('Build Image') {
            steps {
                println('publish docker image')
                script {
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy - Kubernetes containers') {
            steps {
                println('deploy to blue container & service')
                withAWS(region:'us-east-1', credentials:'aws-credentials') {
                    sh 'aws eks update-kubeconfig --name capstonecluster --region eu-west-2'
                    sh 'kubectl apply -f ./k8s/blue-replication-controller.yaml'
                    sh 'kubectl apply -f ./k8s/green-replication-controller.yaml'
                    sh 'kubectl apply -f ./k8s/blue-service.yaml'
                }
            }
        }
        stage('Blue/Green Deployment') {
            steps {
                input 'Deploy to Green Service?'
            }
        }
        stage('Deploy - Green Service') {
            steps {
                println('deploy container to blue service')
                withAWS(region:'us-east-1', credentials:'aws-credentials') {
                    sh 'kubectl apply -f ./k8s/green-service.yaml'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true, fingerprint: true
            junit 'target/surefire-reports/TEST-*.xml'
            sh "docker rmi $registry:latest"
        }
    }
}