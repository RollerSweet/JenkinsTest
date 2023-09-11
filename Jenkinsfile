pipeline {
    agent {
        label 'docker-agent-python' // Agent that we created
    }

    // Define the time interval for polling GitHub (e.g., every 5 minutes)
    triggers {
        pollSCM('*/5 * * * *')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the code from the GitHub repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image from the Dockerfile
                script {
                    def dockerImage = docker.build('rollersweet/docker-agent-python:latest', '-f Dockerfile .')
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockertoken', variable: 'DOCKERHUB_TOKEN')]) {
                        def dockerImage = docker.image('rollersweet/docker-agent-python:latest')
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                // Run the Docker container
                script {
                    docker.image('rollersweet/docker-agent-python:latest').withRun('-p 80:80 -d --name docker-agent-python') { c ->
                        // You can add any additional container configuration here
                        // For example, you might want to set environment variables or mount volumes
                    }
                }
            }
        }
    }
}
