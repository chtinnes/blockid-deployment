export DOCKER_TAG=v0.2.2
export JAR_VERSION=0.2.0-SNAPSHOT

# Setting dockers environment to be that of the minikube VM. So docker images can be created/pushed easily to the kubernetes environment.
eval $(minikube docker-env)

# Build identitystorage docker image
cp ./../../../blockid-identity-storage/target/*.jar ./identitystorage/
cd identitystorage
envsubst < "Dockerfile.template" > "Dockerfile"
docker build -t blockid-identitystorage . 
docker tag blockid-identitystorage blockid-identitystorage:$DOCKER_TAG
rm Dockerfile
rm *.jar
cd ..

# Build identitystorage docker image
cp ./../../../blockid-identity-manager/target/*.jar ./identitymanager/
cd identitymanager
envsubst < "Dockerfile.template" > "Dockerfile"
docker build -t blockid-identitymanager . 
docker tag blockid-identitymanager blockid-identitymanager:$DOCKER_TAG
rm Dockerfile
rm *.jar