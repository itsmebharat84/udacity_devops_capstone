# Capstone - Cloud DevOps 

## Set Up Pipeline

### Create Github repository with project code.
``` https://github.com/itsmebharat84/udacity_devops_capstone 
```
![Github Repo ](screenshots/github_repo.png)

### Use image repository to store Docker images
``` https://hub.docker.com/repositories
```  
![Dockerhub Repo ](screenshots/dockerhub_repo.png)

### Execute linting step in code pipeline
![linting step](screenshots/linting_step.png)

### The project takes a Dockerfile and creates a Docker container in the pipeline.
[DockerFile](Dockerfile)
![Build Docker Image step](screenshots/build_container_pipeline.png)

### The Docker container is deployed to a Kubernetes cluster
![Deploy Docker container step](screenshots/docker_green_container_deployment.png)

The cluster is deployed with CloudFormation or Ansible. This should be in the source code of the student’s submission.
[Infra Provision through Cloudformation](cloudformation/Readme.md)

### Use Blue/Green Deployment successfully
![Blue Green Deployment Pipeline ](screenshots/udacity_devops_capstone_pipeline1.png)
![Blue Green Deployment Pipeline Cont ](screenshots/udacity_devops_capstone_pipeline2.png)

The project performs the correct steps to do a blue/green or a rolling deployment into the environment selected. Student demonstrates the successful completion of chosen deployment methodology with screenshots.
![Green and Blue environments are the same (until new commit happens) ](screenshots/blue-green-sametime.png)
![Green deployment succeeded](screenshots/green-deploy-succeeded.png)
![Test Green Deployment](screenshots/Test-Green-Deployment.png)
![Final blue green deployment ](screenshots/blue-green-final.png)


Final Jenkins Dashboard:
![Final Jenkins Dashboard ](screenshots/jenkins-dashboard.png)