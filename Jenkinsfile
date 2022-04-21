pipeline {
    agent { 
	docker {
        image 'baseimage:5.0'	
	     args '-v /var/run/docker.sock:/var/run/docker.sock -u root:root'
		}
	}
    environment {
       NEXUS_URL = "51.250.74.132:8083"
       PRODE = "51.250.82.110"
       VERSION = "6.0"
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
                sh '''
	    	mvn package && cp ./target/*.war ./docker
	    	'''
                    }
                }
        }
	    stage("docker login") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-registry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh '''
	    	    docker login ${NEXUS_URL} -u $USERNAME -p $PASSWORD
                '''
                 }
            }
        }
        stage('Make docker image') {
	       steps {
	       sh 'cd ./docker && docker build . -t tomcatweb:${VERSION} && docker tag tomcatweb:${VERSION} $NEXUS_URL/tomcatweb:${VERSION}'
	    
	    	}
	    }
        stage("docker push") {
            steps {
            sh '''
	    	docker push ${NEXUS_URL}/tomcatweb:${VERSION}
            '''
            }
	    }
        stage("docker pul") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'root_user', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {		
                sh '''
	    	    sshpass -p $PASSWORD  ssh -o "StrictHostKeyChecking=no"  $USERNAME@${PRODE}
		    docker pull tomcatweb
		    docker run -d -p 8085:8080 tomcatweb
		'''
                 }
            }
        }
    }
}
