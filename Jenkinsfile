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
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh 'docker login -u ${dockerHubUser} -p ${dockerHubPassword}'
        }
      }
    }

    stage('Upload Image') {
      steps {
        sh 'make upload'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh "ssh -T toni@192.168.2.201 'kubectl apply -f ~/btcroc/btcroc-deploy.yaml --record'"
      }
    }

  }
}