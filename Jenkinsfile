pipeline {
    agent { 
	docker {
            image 'baseimage:5.0'	
	     args '-v /var/run/docker.sock:/var/run/docker.sock -e HOME=${workspace} --group-add docker'
		}
	}
    environment {
       NEXUS_VERSION = "nexus3"
       NEXUS_PROTOCOL = "http"
       NEXUS_URL = "51.250.15.213:8081"
       NEXUS_REPOSITORY = "docker"
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
		stage('Make docker image') {
			steps {
				sh 'docker build --tag=gateway-api .'

				}
		}
		
    }
}
