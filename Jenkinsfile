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
  - name: jnlp
    image: node:18-alpine
  - name: build
    image: maven:3.8.3-openjdk-17
    command:
    - cat
    tty: true
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
                container('jnlp') {
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
