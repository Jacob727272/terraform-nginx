pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    terraform init -input=false
                '''
            }
        }

        stage('Terraform Format') {
            steps {
                sh '''
                    terraform fmt -check
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                    terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan -input=false -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Do you want to APPLY Terraform changes?"
                sh '''
                    terraform apply -input=false -auto-approve tfplan
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        success {
            echo "Pipeline SUCCESS - Infrastructure deployed/updated"
        }

        failure {
            echo "Pipeline FAILED - Check logs"
        }
    }
}
