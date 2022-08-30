pipeline {
    agent any
    environment {
        registry = 'itsmebharatb'
        registryCredential = 'dockerhub'
        greenDockerImage = '' 
        blueDockerImage = ''
    }
    stages {
        stage('Install Requirements'){
            steps{
                sh "pip3 install -r requirements.txt"
            }
        }

        stage('Lint Code'){
            steps {
                sh "bash ./run_pylint.sh"
            }
        }

        stage('Build Green Docker Image') {
            steps {
                script {
                    greenDockerImage = docker.build("itsmebharatb/pre-production-flask-app")
                }
            }
        }

        stage('Upload Green Image to Docker-Hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        greenDockerImage.push()
                    }
                }
            }
        }

        stage('Clean Up Green Image'){
            steps { 
                sh "docker rmi itsmebharatb/pre-production-flask-app:latest" 
            }
        }

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'aws'){
                    sh "kubectl config set-context arn:aws:eks:us-east-1:191007734411:cluster/my-cluster"
                }
            }
        }

        stage('Green Deployment'){
            steps {
                withAWS(credentials:'aws'){
                    sh "kubectl apply -f k8s/Green/green-deployment.yaml && kubectl apply -f k8s/Green/test-service.yaml"
                }
            }
        }
    }
}