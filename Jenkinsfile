pipeline {
    agent any

    environment {
        // Define environment variables if necessary
        MAVEN_HOME = '/opt/maven'  
         // Adjust the Java path as per your setup
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your Git repository
                git 'https://github.com/arunksalian/accountmanager.git'
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
                    app = docker.build("accountmanget/am")  
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
