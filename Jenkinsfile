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
        sh "make k8s-deploy"
      }
    }

  }
}