# Deployment of the block-id application.

This Repository contains deployment artifacts to deploy the application on various environments.

The blockid application consists of two main components.
The first handles the connection to a blockchain node and stores so called identity assertions.
It can be seen as the identity storage. The identity assertions are stored in a SQL database.

The second handles creation, encryption, decryption and verification of identity assertions.
It connects to an identity storage to fetch identity assertions from or broadcast identity assertions to.

This repository contains artifacts to quickly set up a working test net of the application.

In this deployment the identity storage is backed by a Postgres database and the blockchain is based on Tendermint.
A few helpful links:
https://docs.docker.com/samples/postgres/
https://kubernetes.io/docs/getting-started-guides/minikube/
https://github.com/tendermint/tendermint
https://tendermint.com/docs/guides/app-architecture
https://tendermint.com/docs/specs/configuration
https://github.com/jTendermint/jabci
https://github.com/chtinnes/blockid-identity-manager
https://github.com/chtinnes/blockid-identity-storage

![blockid_deployment_logos](https://user-images.githubusercontent.com/17828327/29006056-c375859a-7ae8-11e7-914e-f3d383ea007d.png)

## How to deploy blockid testnet on kubernetes
This is an step by step manual on how to deploy the application to kubernetes based on minikube (https://kubernetes.io/docs/getting-started-guides/minikube/).

We are using the following technologies:

1. Git for sharing code (https://github.com/)
2. SpringBoot and Spring Framework for Applications (https://projects.spring.io/spring-boot/) (Implicitly used, not for deployment)
3. Maven as a build tool (https://maven.apache.org/)
4. Docker to containerize applications (https://www.docker.com/)
5. Kubernetes for "Container management" (https://kubernetes.io/)
6. PostgreSQL as database in identity storage (https://www.postgresql.org/)  (Implicitly used, not for deployment)
7. JDK 1.8 (http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) (Implicitly used, not for deployment)
8. Protocol Buffers (https://developers.google.com/protocol-buffers/)  (Implicitly used, not for deployment)
9. Swagger (https://swagger.io/) (Implicitly used, not for deployment)

### Step 1 - Checkout application
Check out the follwing repositories.
```shellscript
git clone https://github.com/chtinnes/blockid-identity-manager
git clone https://github.com/chtinnes/blockid-identity-storage
```

### Step 2 - Build applications
Build both applications with maven.

### Step 3 - Checkout deployment repository
Check out this repository, so that all three check-outs share the same root folder.
```shellscript
git clone https://github.com/chtinnes/blockid-deployment
```

### Step 4 - Setup minikube
Install minikube and kubectl. (https://kubernetes.io/docs/tasks/tools/install-kubectl/ and https://github.com/kubernetes/minikube/releases)
Start minikube (in a shell run `minikube start`).
Node that you need to add minikube to your path.
Furthermode you need a virutlaization provider. I would recommend VirtualBox (https://www.virtualbox.org/)

### Step 5 - Build Docker images
Go into the `/docker` subfolder of this repo and run `./build.sh`. You might want to adjust Docker image tags or Build versions.
This should create the Docker images for both applications into the Minikube VM.

### Step 6 - Deploy on Kubernetes
Go into the `/kubernetes` subfolder of this repo and open a shell (Git-Bash on Windows).
Type the following command:
```shellscript
kubectl create -f blockid-full.yaml
```
This will setup the environment as defined in the given yaml file.

### Step 7 - Verfiy your deployment
So far, no ports are externally exposed. The identitymanger runs Swagger for its REST services on port 8081.
To expose the services of one of your pods use the command
```shellscript
kubectl expose pod tm-0 --name tm-0 --type NodePort
```
which exposes all services of pod `tm-0`. 
**WARNING: THIS SHOULD NEVER BE DONE IN PRODUCTION WITHOUT THINKING ABOUT THIS STEP AND SECURING THE ENDPOINTS PROPERLY.**
Now, you can find out to which port the services have been exposed by typing
```shellscript
kubectl get service tm-0. 
```
Check out the mapping for the port 8081, (e.g. 31337).
Now, you can access the api of the identitymanger by typing 
`http://[minikube node url]:[serviceport(e.g. 31337)]/swagger-ui.html` into your browsers address bar.
If you want to find out all externally exposed ports, you can use also minikube for that:
```shellscript
minikube service tm-0 --url
```

Have fun playing around with the application.
