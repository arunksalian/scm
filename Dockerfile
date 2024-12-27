# Use the official Jenkins LTS image as the base
FROM jenkins/jenkins:latest

# Switch to root to install additional software
USER root

# Install Maven and other dependencies
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Verify Maven installation
RUN mvn --version
ENV JAVA_HOME java-17-openjdk-amd64/java-17-openjdk-amd64
RUN export JAVA_HOME

# Switch back to the Jenkins user
USER jenkins

# Expose Jenkins default port and agent port
EXPOSE 8080 
EXPOSE 50000

# Default command to run Jenkins
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
