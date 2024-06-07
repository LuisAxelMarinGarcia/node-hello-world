pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'node-hello-world'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside {
                        // Instalar dependencias nuevamente para asegurar que mocha está disponible
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).run('-d -p 3000:3000')
                }
            }
        }
    }
}
