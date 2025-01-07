pipeline {
    agent {
        kubernetes {
            yaml """
---
    apiVersion: v1
        kind: Pod
        metadata:
          labels:
            app: jenkins-agent
	    jenkins/jenkins-jenkins-agent: "true"
        spec:
          containers:
          - name: node
            image: node:18-alpine
            command:
            - cat
            tty: true
          - name: maven
            image: maven:3.8.3-openjdk-17
            command:
            - cat
            tty: true
            volumeMounts:
            - mountPath: "/root/.m2/repository/"
              name: cache
          - name: java-node
            image: timbru31/java-node
            command:
            - cat
            tty: true
          - name: git
            image: bitnami/git:latest
            command:
            - cat
            tty: true
          - name: kaniko
            image: gcr.io/kaniko-project/executor:debug
            command:
            - cat
            tty: true
            volumeMounts:
            - mountPath: "/workspace"
              name: "workspace-volume"
              readOnly: false
            - name: kaniko-secret
              mountPath: /kaniko/.docker             
          volumes:
          - name: cache
            persistentVolumeClaim:
              claimName: pvc-maven-cache
          - name: kaniko-secret
            secret:
              secretName: registry-credential
              items:
                - key: .dockerconfigjson
                  path: config.json


            """
        }
    }

    environment {
        // Define environment variables if necessary
       MAVEN_HOME1 = '/opt/maven' 
      // JAVA_HOME= '/opt/java/openjdk'
         // Adjust the Java path as per your setup
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your Git repository
                 git url: 'https://github.com/arunksalian/accountmanager.git'
                //git 'https://github.com/arunksalian/accountmanager.git'
            }
        }
        
        stage('Build') {
            steps {
                // Build the Java project using Maven (or Gradle)
                script {
                    // Maven build
                    sh "echo $JAVA_HOME"
                    sh "mvn clean install"
                    
                    // Alternatively, if you're using Gradle, use the following:
                     //sh "./gradlew build"
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    app = docker.build("accountmanager/am")  
                }
            }
        }
    }

    post {
        always {
            // Clean up, send notifications, etc.
            echo 'Cleaning up after the build'
        }
        success {
            echo 'Build completed successfully'
        }
        failure {
            echo 'Build failed'
        }
    }
}
