pipeline {
    agent { 
	docker {
            image 'baseimage:5.0'	
	     args '-v /var/run/docker.sock:/var/run/docker.sock'
		}
	}
    environment {
       NEXUS_URL = "51.250.15.213:8083"
       VERSION = "5.0"
       DOCKER_CONFIG = "${WORKSPACE}/docker.config"
    }
    stages {
        stage("Clone code from VCS") {
            steps {
                script {
                    git 'https://github.com/alex19451/boxfuser-alex.git';
                }
            }
        }
    stage("Maven Build") {
        steps {
            script {
              sh """
		mvn package && cp ./target/*.war ./docker
		"""
                }
            }
        }
	stage("docker login") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-registry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
		    docker login ${NEXUS_URL} -u $USERNAME -p $PASSWORD
                    """
                }
            }
        }
     stage('Make docker image') {
	steps {
		sh """
		cd ./docker && docker build . -t ${NEXUS_URL}/tomcat:${VERSION}
		"""

		}
	}
      stage("docker push") {
            steps {
                sh '''
		docker push ${NEXUS_URL}/tomcat:${VERSION}
                '''
            }
	}
    }
}
