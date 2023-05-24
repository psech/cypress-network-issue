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
    stage("Build app image") {
      steps {
        sh 'echo Building app image'
        sh 'docker build . -t app-image-$BUILD_NUMBER -f Dockerfile-app'
      }
    }
  }

}
