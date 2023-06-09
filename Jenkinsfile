pipeline{
    agent any
    
    stages{
        
        stage('Git Checkout'){
            steps{
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/lingcode72/jenkins_terraform']])
            }
        }
        
        stage('Terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        
        stage('Terraform plan'){
            steps{
                sh 'terraform plan'
            }
        }
        
       
        stage('Terraform apply'){
            steps{
                sh 'terraform apply --auto-approve'
            }
    }
}
}
