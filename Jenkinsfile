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

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'AWS'){
                    sh "kubectl config set-context arn:aws:eks:us-east-1:191007734411:cluster/my-cluster"
                }
            }
        }

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build "itsmebharatb/pre-production-flask-app"
                    sh "run_docker.sh"
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
    }
}