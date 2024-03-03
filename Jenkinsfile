pipeline {
    agent any

    environment {
        mavenHome = tool 'jenkins-maven'
        imageName = "rest_demo"
        registry = "http://localhost:8081/repository/docker-release/"
        dockerImage = ''
    }
    tools {
        jdk 'java-21'
    }

    stages {

        stage('Build jar') {
            steps {
                bat "mvn clean install -DskipTests"
            }
        }

        stage('Test') {
            steps {
                bat "mvn test"
            }
        }

        stage('Deploy jar') {
            steps {
                bat "mvn jar:jar deploy:deploy"
            }
        }

        stage('Build docker') {
            steps {
                dockerImage = docker.build imageName
            }
        }

        stage('Upload image to Nexus') {
            steps {
                docker.withRegistry(registry, "nexus_repo") {
                    docker.push('latest')
                }
            }
        }
    }
}