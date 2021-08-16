#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
docker version
service docker status
docker run hello-world
