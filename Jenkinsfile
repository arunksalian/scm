pipeline {
    agent any

    environment {
        // Define environment variables if necessary
        MAVEN_HOME = '/usr/local/maven'  
        JAVA_HOME = '/opt/java'    // Adjust the Java path as per your setup
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
                    sh "mvn clean install"
                    
                    // Alternatively, if you're using Gradle, use the following:
                    // sh "./gradlew build"
                }
            }
        }
        
        stage('Post-build') {
            steps {
                // Add steps for post-build actions, like archiving artifacts, tests, etc.
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                junit '**/target/test-*.xml'  // Optional: If you're using JUnit for test results
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
