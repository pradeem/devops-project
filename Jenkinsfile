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
          sh """
            echo "SSH key path is: $SSH_KEY"
            ls -l $SSH_KEY
            terraform init
            terraform apply -auto-approve -var="private_key_path=$SSH_KEY" 
          """
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
