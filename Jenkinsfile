pipeline {
  agent any

  environment {
    TF_DIR = 'terraform'
  }

  stages {
    stage('Checkout Code') {
      steps {
        git 'https://github.com/pradeem/devops-project.git'
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
        dir("${TF_DIR}") {
          sh 'terraform apply -auto-approve'
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
