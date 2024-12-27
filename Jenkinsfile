pipeline {
  agent any
    environment {
        // Define environment variables if necessary
        MAVEN_HOME = '/opt/maven'  // Adjust the Maven path as per your setup
        JAVA_HOME = '/opt/java'    // Adjust the Java path as per your setup
    }
  stages {
    stage('Checkout') {
         git 'https://github.com/arunksalian/accountmanager.git'
    }
  }

}
