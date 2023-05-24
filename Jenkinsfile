pipeline {
  agent {
    node {
      label 'linux-prod-sydney-przemek'
    }
  }

  options {
    parallelsAlwaysFailFast()
  }

  stages {
    stage("Build images") {
      parallel {
        stage("Build app image") {
          steps {
            sh 'echo Building app image'
            sh 'docker build . -t app-image-$BUILD_NUMBER -f Dockerfile-app'
          }
        }
        stage("Build test image") {
          steps {
            sh 'echo Building app image'
            sh 'docker build . -t test-image-$BUILD_NUMBER -f Dockerfile-test'
          }
        }
      }
    }
    stage("Start app container") {
      steps {
        sh '''
          echo Create network
          docker network create --driver bridge network-app-container-$BUILD_NUMBER
        '''
        sh '''
          echo Start app container
          docker run --rm -d --name app-container-$BUILD_NUMBER \
          --add-host=server.local:127.0.0.1 --network=network-app-container-$BUILD_NUMBER \
          app-image-$BUILD_NUMBER
        '''
        sh 'echo Get app container IP'
        script {
          env.APP_IP = sh (
            returnStdout: true,
            script: "docker inspect --format='{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}' app-container-${BUILD_NUMBER}"
          ).trim()
          
          sh 'echo APP_IP=${APP_IP}'
        }
      }
    }
    stage('Cleanup') {
      steps {
        sh 'docker network disconnect --force network-app-container-$BUILD_NUMBER app-container-$BUILD_NUMBER 2>/dev/null || true'
        sh 'docker stop app-container-$BUILD_NUMBER 2>/dev/null || true'
        sh 'docker stop test-container-$BUILD_NUMBER 2>/dev/null || true'
        sh 'docker network rm network-app-container-$BUILD_NUMBER || true'
        sh 'docker image rm app-image-$BUILD_NUMBER'
        sh 'docker image rm test-image-$BUILD_NUMBER'
      }
    }
  }
}
