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
    image: jenkins/inbound-agent:4.3-11
    args: ['\$(JENKINS_SECRET)', '\$(JENKINS_NAME)']
  - name: build
    image: maven:3.8.5-openjdk-11
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
