pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "docker build -t nginx-image:${BUILD_NUMBER} ."
            }
        }
        stage('Save image into archive') {
            steps{
                sh "docker image save -o nginx_${BUILD_NUMBER}.tar nginx-image:${BUILD_NUMBER}"
            }
        }

         stage('provisioning infrastructure') {
            environment {
                AWS_ACCESS_KEY_ID   = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY   = credentials('aws_secret_access_key')
            }
            steps {
                script {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -var-file dev.tfvars -auto-approve'
                    EC2_PUBLIC_IP = sh(
                        script: "terraform output ec2-public-ip",
                        returnStdout: true
                        ).trim().replaceAll('"', '')
                }
                }
            }
        }

        stage('Configuring ec2 instance') {
            steps {
                script {
                    sleep(time: 30, unit: "SECONDS")
                    def sshKey = "$WORKSPACE/terraform/ssh-file/key.pem"
                    dir('ansible') {
                        sh "sed -i 's/ip/${EC2_PUBLIC_IP}/g' inventory"
                        sh "ansible-playbook -i inventory InstallApache.yaml --private-key=${sshKey}"
                }
                }
            }
        }
        stage('Deploy docker image to ec2 instance') {
            steps {
                script {
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                    def shellCmd = "docker run -d -p 8080:80 nginx-image:${BUILD_NUMBER}"
                    def privateKey = "terraform/ssh-file/key.pem"
                    def tarFile = "nginx_${BUILD_NUMBER}.tar"
                    sh "scp -o StrictHostKeyChecking=no -i ${privateKey} -v nginx_${BUILD_NUMBER}.tar ${ec2Instance}:~"
                    sh "ssh -o StrictHostKeyChecking=no -i ${privateKey} ${ec2Instance} ${tarFile}"
                    sh "ssh -o StrictHostKeyChecking=no -i ${privateKey} ${ec2Instance} ${shellCmd}"
                }
            }
        }
    } 
    
}
