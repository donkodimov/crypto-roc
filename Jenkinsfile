pipeline {
  agent any
  environment {
       VERSION = """${sh(
                returnStdout: true,
                script: 'version.sh'
            )}"""
   }
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
        aquaMicroscanner(imageName: 'donko/btcroc:${VERSION}', onDisallowed: 'fail', notCompliesCmd: 'exit 1', outputFormat: 'html')
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