pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: jenkins-agent
spec:
  containers:
  - name: node
    image: node:16
    command:
    - cat
    tty: true
"""
        }
    }
    stages {
        stage('Checkout Code') {
            steps {
                container('node') {
                    sh 'echo Checking out code...'
                    checkout scm
                }
            }
        }
        stage('Build') {
            steps {
                container('build') {
                    sh 'mvn clean install'
                }
            }
        }
        stage('Test') {
            steps {
                container('build') {
                    sh 'mvn test'
                }
            }
        }
        stage('Deploy') {
            steps {
                container('node') {
                    sh 'echo Deploying application...'
                    // Add deployment commands here
                }
            }
        }
    }
    post {
        always {
            container('jnlp') {
                echo 'Pipeline completed!'
            }
        }
    }
}
