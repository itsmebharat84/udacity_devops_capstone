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

        stage('create kube config file'){
            steps {
                withAWS(credentials:'aws', region: 'us-east-1'){
                    sh "aws eks --region us-east-1 update-kubeconfig --name capstonecluster"
                }
            }
        }

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'aws'){
                    sh "kubectl config set-context arn:aws:eks:us-east-1:191007734411:cluster/capstonecluster"
                }
            }
        }

        stage('Green Deployment'){
            steps {
                withAWS(credentials:'aws', region: 'us-east-1-'){
                    sh "kubectl apply -f k8s/Green/green-deployment.yaml && kubectl apply -f k8s/Green/test-service.yaml"
                }
            }
        }

        stage('Test Green Deployment'){
            steps{
                input "Ready to promote Green Deployment to production?"
            }
        }

        stage('Switch Traffic To Green Deployment'){
            steps{
                withAWS(credentials:'aws'){
                    sh "kubectl apply -f k8s/Green/green-service.yaml"
                }
            }
        }

        stage('Build Blue Docker Image') {
            steps {
                script{
                    blueDockerImage = docker.build "itsmebharatb/flask-app"
                }
            }
        }
        
        stage('Upload Blue Image to Docker-Hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        blueDockerImage.push()
                    }
                }
            }
        }

        stage('Clean Up Blue Image'){
            steps { 
                sh "docker rmi itsmebharatb/flask-app:latest" 
            }
        }

        stage('Blue Deployment'){
            steps {
                withAWS(credentials:'aws'){
                    sh "kubectl apply -f k8s/Blue/blue-deployment.yaml"
                }
            }
        }
    }
}