pipeline {
    agent any

    environment {
        mavenHome = tool 'jenkins-maven'
        imageName = "rest_demo"
        registry = "http://0.0.0.0:8082/repository/docker-release/"
        dockerImage = ''
        openshiftAddress = 'https://api.sandbox-m2.ll9k.p1.openshiftapps.com:6443'
        openshiftProjectName = 'makzak65-dev'
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
//
//         stage('Deploy jar') {
//             steps {
//                 bat "mvn jar:jar deploy:deploy"
//             }
//         }
//
//         stage('Build docker') {
//             steps {
//                 script {
//                     dockerImage = docker.build imageName
//                 }
//             }
//         }
//
//         stage('Upload docker image to Nexus') {
//             steps {
//                 script {
//                     docker.withRegistry(registry, 'nexus_repo') {
//                         dockerImage.push('latest')
//                     }
//                 }
//             }
//         }

        stage('Deploy OPENSHIFT') {
            steps {
                withCredentials([string(credentialsId: 'openshift-token', variable: 'TOKEN')]) {
                    sh "oc login --token=$TOKEN --server=${openshiftAddress}"
                }
                sh "echo success login"
                sh "sed -i 's/BRANCHNAME/${imageName}/g' openshift/deployment.yaml"
                sh "sed -i 's/DEPLOYNAME/${imageName}/g' deploy/deployment.yml"
                sh "sed -i 's/DEPLOYNAME/${imageName}/g' deploy/service.yml"
                sh "sed -i 's/DEPLOYNAME/${imageName}/g' deploy/route.yml"

                sh "oc project ${openshiftProjectName}"
                sh "oc apply -f openshift/deployment.yaml"
                sh "oc apply -f openshift/service.yaml"
                sh "oc apply -f openshift/route.yaml"
            }
        }
    }
}