pipeline {
    agent any
    tools {
        go 'Go' // Adjust based on your Go version
       
    }

    stages {
        stage('Build Go Web App') {
            steps {
               // sh 'go mod init wordweb'
                //sh 'go build -o my-app ./' // Adjust command and output file
            }
        } 

        stage('Build Docker Image for Go Web App') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 
                  sh 'docker login -u $USERNAME -p $PASSWORD'
                  sh 'docker build -t wordweb:v1 -f Dockerfile  --build-arg TARGETARCH=targetarch--build-arg JAVA_API_URL=http://java-api:8081 .'
                  sh 'docker tag wordweb:v1 dkfolefac/wordweb:${BUILD_NUMBER}'
                  sh 'docker push dkfolefac/wordweb:${BUILD_NUMBER}'
                                  
                }
            }
        }
    }
}