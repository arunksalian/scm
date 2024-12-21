node {
  stage('Clone sources') {
        git URL: 'https://github.com/arunksalian/accountmanager.git'
    }

  stage('Gradle build') {
        buildInfo = rtGradle.run rootDir: "gradle-examples/4/gradle-example-ci-server/", buildFile: 'build.gradle', tasks: 'clean artifactoryPublish'
    }

}
