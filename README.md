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

## How to deploy blockid testnet on kubernetes
This is an step by step manual on how to deploy the application to kubernetes based on minikube (https://kubernetes.io/docs/getting-started-guides/minikube/).

### Step 1
Check out the follwing repositories.

https://github.com/chtinnes/blockid-identity-manager
https://github.com/chtinnes/blockid-identity-storage

### Step 2 
Build both applications with maven.

### Step 3
Check out this repository, so that all three check-outs share the same root folder.

### Step 4
Install minikube and kubectl.
Start minikube.

### Step 5
Go into the /docker subfolder of this repo and run ./build.sh
This should create the Docker images for both applications into the Minikube VM.

### Step 6
Go into the /kubernetes subfolder of this repo and open a shell (Git-Bash on Windows).
Type the following command:
kubectl create -f blockid-full.yaml
This will setup the environment as defined in the given yaml file.

### Step 7 - Verfiy your deployment
So far, no ports are externally exposed. The identitymanger runs Swagger(see https://swagger.io/) for its REST services on port 8081.
To expose the services of one of your pods use the command
kubectl expose pod tm-0 --name tm-0 --type NodePort
which exposes all services of pod "tm-0". 
WARNING: THIS SHOULD NEVER BE DONE IN PRODUCTION WITHOUT THINKING ABOUT THIS STEP AND SECURING THE ENDPOINTS PROPERLY.
Now, you can find out to which port the services have been exposed by typing
kubectl get service tm-0. 
Check out the mapping for the port 8081, (e.g. 31337).
Now, you can access the api of the identitymanger by typing http://[minikube node url]:[serviceport(e.g. 31337)]/swagger-ui.html into your browsers address bar.
If you want to find out all externally exposed ports, you can use also minikube for that:
minikube service tm-0 --url

Have fun playing around with the application.
