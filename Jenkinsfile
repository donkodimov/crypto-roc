pipeline {
  agent any
  stages {
    stage('Lint') {
      steps {
        sh 'make lint'
      }
    }

    stage('Build Docker') {
      steps {
        sh 'make build'
      }
    }

    stage('Security Scan') {
      steps {
        aquaMicroscanner(imageName: 'donko/btcroc:v0.1', onDisallowed: 'fail', notCompliesCmd: 'exit 1', outputFormat: 'html')
      }
    }

    stage('Login to dockerhub') {
      steps {
        sh 'docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}'
      }
    }

    stage('Upload Image') {
      steps {
        sh 'make upload'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        kubernetesDeploy()
      }
    }

  }
}