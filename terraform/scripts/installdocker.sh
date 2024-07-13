#!/bin/bash

#Install Docker
echo "---------------------Install Docker'''''''''''''''''''''''"
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user