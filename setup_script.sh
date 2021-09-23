#!/usr/bin/env bash

sudo yum -y remove python2 
sudo yum -y install git python3

sudo yum -y install yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
sudo usermod -aG docker vagrant

echo "*** Done ***"