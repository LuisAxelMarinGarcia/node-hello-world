pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'node-hello-world'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

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
                        // Instalar dependencias y ejecutar pruebas
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    // Ejecutar el contenedor en segundo plano y mapear el puerto 3000
                    docker.image(DOCKER_IMAGE).run('-d -p 3000:3000')
                }
            }
        }
    }
}
