# udacity-cde-capstone-service

This project is part of the [Udacity Cloud DevOps Engineer Capstone Project](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991).
In this project a simple python hello world microservice is being built within a Jenkins CI/CD environment and finally deployed on an AWS EKS cluster.
The infrastructure for this service deployment has been moved to a separate [GitGhub project](https://github.com/mithie/udacity-cde-capstone-infra) in order to clearly 
decouple service deployments form infrastructure deployments.

## Project Structure

| File/Folder | Description |
|:---- |:----------- |
| `build` | Contains the Jenkinsfile where the build stages for this project are defined. |
| `deployment` | Contains the deployment resources for the deployment on EKS. |
| `screenshots` | Contains the screenshots as stated in the capstone project's project rubric. |
| `app.py` | The application that is going to be deployend on EKS. |
| `Dockerfile` | The description of the Docker container where the application will be run in at the EKS cluster.  |
| `requirements.txt` | The dependencies file for the application.  |
| `README.md` | This file you are actually reading. |

## Submission details
* The capstone project consists of two GiHub projects. This is intentionally and has been done to achieve a clearer separation of concerns between service- and infrastructure deployments.
  * [udacity-cde-capstone-service](https://github.com/mithie/udacity-cde-capstone-service)
  * [udacity-cde-capstone-infra](https://github.com/mithie/udacity-cde-capstone-infra)
* Screenshots as stated in the project rubric are provided in the [screenshots](./screenshots) folder.

## Preconditions
* A pre-defined and running EKS cluster (see [udacity-cde-capstone-infra](https://github.com/mithie/udacity-cde-capstone-infra) for details)
* A manually created namespace named `udacity`:
  ```bash
  kubectl create namespace udacity
  ```
* A secret named `regcred` in namespace `udacity` containing the credentials of the Docker registry to connect with:
    ```bash
    kubectl create secret docker-registry regcred \
        --docker-server=https://index.docker.io/v1/ \
        --docker-username=<DOCKERHUB_USERNAME> \
        --docker-password=<DOCKERHUB_PASSWORD> \
        --docker-email=<DOCKER_EMAIL>
        
* A DockerHub account where images can be maintained.
    ```
## How-to run
### Configure Jenkins
1. **Fork GitHub Repo**  
   Fork the [Service GitHub Repo](https://github.com/mithie/udacity-cde-capstone-service).
2. **Create Docker Credentials**  
   * In Jenkins first create new global Dockerhub credentials (username/password credentials).
3. **Create multibranch pipeline**  
   * Create a new multibranch pipeline in the Jenkins UI and connect it to your newly created repo. 
   * Note that you have to configure credentials in Jenkins that allow access to your repo.
   * In the **Build Configuration** section of your pipeline configuration make sure to set **Script Path** to `build/Jenkinsfile`

### Run Build Job
Once the pipeline has been set up and configured properly go to your newly created pipeline and click on the `build now` link. This will initiate a new build of the application, 
store its image in DockerHub and deploy it on EKS.

## Pipeline Stages

| Stage | Description |
|:---- |:----------- |
| `Setup Python Environment` | Sets up a virtual python environment for building the project. |
| `Install Dependencies` | Installs python dependencies. |
| `Lint Python` | Lints the application code. |
| `Lint Dockerfile` | Lints the Dockerfile. |
| `Build Docker` | Build a Docker container image and pushes it to DockerHub. |
| `Deploy to Kubernetes` | Deploys the newly created Docker image on the Kubernetes cluster. |

## Post Actions
| Action | Description |
|:---- |:----------- |
| `failure` | This action performs a rollback to the most recent valid version of the service.  |
| `success` | Prints a success message when the service has been built successfully. |