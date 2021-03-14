!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade

echo "Install packages to allow apt to use a repository over HTTPS"
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "Add Docker’s official GPG key"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "set up the stable repository"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

echo "install the latest version of Docker Engine and containerd"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
#apt-cache madison docker-ce

echo " Install a specific version"
sudo apt-get install docker-ce=5:19.03.14~3-0~debian-stretch docker-ce-cli=https://download.docker.com/linux/debian stretch/stable amd64 Packages containerd.io

echo "restart docker"
sudo systemctl restart docker

echo "Finally, connect to the new Kubernetes cluster to install a CNI"


##Créer un conteneur
docker pull nginx:alpine
docker run nginx:alpine
docker push ynovsoul/nginx:alpine

# Construction et Execution de notre image avec un DockerFile
docker build -t nginx:alpine .
docker run -p 8001:80 nginx:alpine