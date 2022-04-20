pipeline {
  agent {
    docker {
      image 'baseimage:1.0'
    }

  }
    stages {
        stage("Clone code from VCS") {
            steps {
                script {
                    git 'https://github.com/javaee/cargotracker.git';
                }
            }
        }
        stage("Maven Build") {
            steps {
                script {
                    sh "mvn package"
                }
            }
        }
    }
}
