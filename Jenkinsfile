pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/hocine699/azure_infra_tf_01']])     
            }
        }
        
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform validate') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Terraform plan') {
            steps {
                sh 'terraform plan -out main.plan'
            }
        }
        
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
                
            }
        }
        
    }
}
