# udacity-cde-capstone-service

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
    ```
