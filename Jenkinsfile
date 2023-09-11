pipeline {
  environment {
    registry = "anishnath/mkdocs"
    registryCredential = 'docker-creds'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/anishnath/mkdocs.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Test Mkdocs' ) {
                agent {
                docker { image 'anishnath/mkdocs:$BUILD_NUMBER' }
            }
            steps {
                sh 'mkdocs --version'
            }
        }


    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}





// pipeline {
//     environment {
//         registry = "rollersweet/jenkinstest"
//         registryCredential = 'dockerhubcred'
//         dockerImage = ''
//     }

//     agent any

//     // Define the time interval for polling GitHub (e.g., every 5 minutes)
//     triggers {
//         pollSCM('*/5 * * * *')
//     }

//     stages {
//         stage('Clone Repository') {
//             steps {
//                 // Checkout the code from the GitHub repository
//                 checkout scm
//             }
//         }
//         stage('Building image') {
//             steps{
//                 script {
//                     dockerImage = docker.build registry + ":$BUILD_NUMBER"
//                 }
//             }
//         }
//         // stage('Build Docker Image') {
//         //     steps {
//         //         // Build the Docker image from the Dockerfile
//         //         script {
//         //             def dockerImage = docker.build('rollersweet/docker-agent-python:latest', '-f Dockerfile .')
//         //         }
//         //     }
//         // }

//         stage('Push Docker Image to Docker Hub') {
//             steps {
//                 script {
//                     withCredentials([string(credentialsId: 'dockertoken', variable: 'DOCKERHUB_TOKEN')]) {
//                         def dockerImage = docker.image('rollersweet/docker-agent-python:latest')
//                         dockerImage.push()
//                     }
//                 }
//             }
//         }

//         stage('Run Docker Container') {
//             steps {
//                 // Run the Docker container
//                 script {
//                     docker.image('rollersweet/docker-agent-python:latest').withRun('-p 80:80 -d --name docker-agent-python') { c ->
//                         // You can add any additional container configuration here
//                         // For example, you might want to set environment variables or mount volumes
//                     }
//                 }
//             }
//         }
//     }
// }