#!/bin/bash
#Install Java
echo "--------------------Installing Java--------------------"
sudo yum update -y
sudo yum upgrade -y
sudo yum install java-17-amazon-corretto -y
sudo yum install -y java-11-openjdk-devel

#Install Python
echo "--------------------Installing Python--------------------"
sudo yum update -y
sudo yum install python3 -y

#Show Jenkins Password
#Install Jenkins
echo "--------------------Installing Jenkins--------------------"
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk
sudo yum install -y  jenkins
sudo systemctl daemon-reload
sudo systemctl restart jenkins
sudo systemctl enable jenkins

# Install Ansible
sudo yum -y install ansible

#Install AWS-CLI
echo "--------------------Installing AWS-CLI--------------------"
sudo yum install zip -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install

#Install Terraform
echo "--------------------Installing Terraform--------------------"
sudo yum install -y yum-utils
sudo yum-config-manager -y --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum update -y
sudo yum -y install terraform
#Install Docker
echo "---------------------Install Docker'''''''''''''''''''''''"
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins
sudo chown jenkins:docker  /var/run/docker.sock

#Show Jenkins Password
sudo systemctl restart jenkins.service
echo "--------------------Jenkins Password--------------------"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword > default-admin-password.txt
sudo cat /var/lib/jenkins/secrets/initialAdminPassword