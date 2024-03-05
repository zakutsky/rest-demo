pipeline {
    agent any

    environment {
        mavenHome = tool 'jenkins-maven'
        imageName = "rest_demo"
        registry = "http://0.0.0.0:8082/repository/docker-release/"
        dockerImage = ''
    }
    tools {
        jdk 'java-21'
    }

    stages {

//         stage('Build jar') {
//             steps {
//                 bat "mvn clean install -DskipTests"
//             }
//         }
//
//         stage('Test') {
//             steps {
//                 bat "mvn test"
//             }
//         }

//         stage('Deploy jar') {
//             steps {
//                 bat "mvn jar:jar deploy:deploy"
//             }
//         }

//         stage('Login docker') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'nexus_repo', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASS')]) {
//                     bat "docker login -p $NEXUS_PASS -u $NEXUS_USERNAME registry"
//                 }
//             }
//         }

        stage('Build docker') {
            steps {
                script {
                    dockerImage = docker.build imageName
                }
            }
        }

        stage('Upload image to Nexus') {
            steps {
                script {
                    docker.withRegistry(registry, 'nexus_repo') {
                        docker.push('latest')
                    }
                }
            }
        }
    }
}