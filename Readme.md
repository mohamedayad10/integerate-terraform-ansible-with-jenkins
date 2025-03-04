
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

### 5. Provisioning the 3 VMS using terraform 

Integrate terraform & ansible with jenkins for Provisioning & configuring the vms.

### 6  Gogs Integration with Jenkins

Integrate Gogs with Jenkins to automate deployment processes triggered by web hooks.

### 7. Creating a Git Repository on Gogs

- Develop an Ansible playbook `InstallApache.yml` to automate the installation of Apache on VM3.
- Develop a Bash script `NotGroupMembers.sh` to list users not in the `deployG` group.

### 8. CI/CD Pipeline Configuration

Configure Jenkins to monitor the Gogs repository for any changes.

### 9. CI/CD Pipeline Email Notification

Configure Jenkins to send an email whether the job successed or failed the body of the mail includes:
    - Pipeline execution status.
    - List of users in the "deployG" group.
    - Date and time of the pipeline execution.
    - Path to Docker image.tar 

### Hints ###
- Create aws access key id & aws secret access key through jenkins credentials.
- Replace your public ip with the one in dev.tfvars.
- All bash scripts are in the path terraform/scripts
