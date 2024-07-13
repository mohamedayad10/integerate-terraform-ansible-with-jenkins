
# Deploying Simple App on AWS Using Terraform, Ansible, Jenkins

## Project Description

### 1. Provisioning VMs

- **VM1**: Jenkins server for orchestrating the CI/CD pipeline.
- **VM2**: Gogs server for hosting Git repositories.
- **VM3**: Server for user management and deployment.

### 2. User Management on VM3

- Create users `Devo`, `Testo`, and `Prodo` using a bash script.
- Add these users to a group named `deployG`.
- Also install docker using a bash script

### 3. Install Dependencies on VM1

- Install java, python, jenkins, ansible, terraform, docker and cat jenkins default password using a bash script.

### 4. Install Gogs on VM2

- Installing gogs server using bash script.

### 5  Gogs Integration with Jenkins

Integrate Gogs with Jenkins to automate deployment processes triggered by web hooks.

### 6. Creating a Git Repository on Gogs

- Develop an Ansible playbook `InstallApache.yml` to automate the installation of Apache on VM3.
- Develop a Bash script `NotGroupMembers.sh` to list users not in the `deployG` group.

### 7. CI/CD Pipeline Configuration

Configure Jenkins to monitor the Gogs repository for any changes.

### 8. Provisioning the 3 VMS using terraform 

Integrate terraform with jenkins for Provisioning vms.