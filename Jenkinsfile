pipeline {
  agent any

  environment {
    TF_DIR = 'terraform'
    TF_VAR_private_key_path = ''
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
          script {
            // Set environment variable for Terraform to pick up
            env.TF_VAR_private_key_path = SSH_KEY
          }

          sh """
            echo 'Injected key path: ${env.TF_VAR_private_key_path}'
            ls -l ${env.TF_VAR_private_key_path}

            terraform init
            terraform apply -auto-approve
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
