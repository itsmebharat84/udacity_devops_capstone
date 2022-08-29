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
                withAWS(credentials:'aws-credentials'){
                    sh "kubectl config set-context arn:aws:eks:us-east-1:191007734411:cluster/my-cluster"
                }
            }
        }
    }
}