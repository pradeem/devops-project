pipeline {
  agent any

  environment {
    TF_DIR = 'terraform'
  }

  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main', credentialsId: 'github-https', url: 'https://github.com/pradeem/devops-project.git'
      }
    }

    stage('Terraform Init') {
      steps {
        dir("${TF_DIR}") {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir("${TF_DIR}") {
          sh 'terraform plan'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([file(credentialsId: 'ec2-ssh-key', variable: 'SSH_KEY')]) {
          sh '''
            terraform init
            terraform apply -var="private_key_path=$SSH_KEY" -auto-approve
          '''
        }
      }
    }
    stage('Deploy Application') {
      steps {
        sh 'bash scripts/deploy.sh'
      }
    }
  }
}
