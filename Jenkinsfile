pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                // ALWAYS keep repo here
                checkout scm
            }
        }

        stage('Clean Workspace (Safe)') {
            steps {
                cleanWs()
                // re-checkout AFTER cleaning
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                retry(2) {
                    sh '''
                        terraform init -input=false
                    '''
                }
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
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
                input message: "Approve Terraform Apply?", ok: "Deploy"

                retry(2) {
                    sh '''
                        terraform apply -input=false tfplan
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo "Pipeline FAILED - Check logs"
        }
        success {
            echo "Pipeline SUCCESS"
        }
    }
}
