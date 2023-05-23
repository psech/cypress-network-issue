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
    stage("Hello") {
      steps {
        sh 'echo Hello World!'
      }
    }
  }
}
