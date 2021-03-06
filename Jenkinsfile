pipeline {
    
    agent any 
    
    environment {
        registry = "snehalshirsath/maven-app"
        registryCredential = 'dockerHubAccount'
        dockerImage = ""
    }
    
    tools {
        maven "maven-3.6"
    }
    
    stages {
        
        stage('code checkout') {
            steps {
                git url: 'https://github.com/snehalshirsath/jenkins-pipeline-maven-app.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        
        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'SonarQube Scanner 4.3.0.2102'
            }
            
            steps {
                withSonarQubeEnv('sonarqube-7.5') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
                
        stage('compile package') {
            steps {
                sh "mvn package"
            }
        }
        
        stage('upload artifacts') {
            steps {
                script {
                    def server = Artifactory.server 'Artifactory 7.6.3'
                    
                    def uploadSpec = """{
                      "files": [
                        {
                          "pattern": "/var/lib/jenkins/workspace/docker-maven-ci-cd/target/*.jar",
                          "target": "libs-snapshot/libs-snapshot-local/"
                        }
                     ]
                    }"""
                    server.upload(uploadSpec)

                    def buildInfo = Artifactory.newBuildInfo()
                    buildInfo.env.capture = true
                    buildInfo.env.collect()
                    buildInfo=server.upload(uploadSpec)
                    server.publishBuildInfo(buildInfo)
                }
            }
        }
        
        stage('download artifacts') {
            steps {
                script {
                    def server = Artifactory.server 'Artifactory 7.6.3'
                    
                    def downloadSpec = """{
                      "files": [
                        {
                          "pattern": "libs-snapshot/libs-snapshot-local/*.jar",
                          "target": "artifacts/"
                        }
                     ]
                    }"""
                    server.download(downloadSpec)
                }
            }
        }
        
        stage('Build image') {
          steps{
              script {
                  dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
          }
        }
        
        stage('Push Image') {
          steps{
            script {
                withDockerRegistry([ credentialsId: "dockerHubAccount", url: "" ]) {
                    dockerImage.push()
                    }
                }
            }
        }
        
        stage ('deploy image') {
            steps {
                script {
                    sh "docker run -d -p 8008:8080 --name hello-world-new snehalshirsath/maven-app:$BUILD_NUMBER"
                    //sshagent(['docker-server']) {
                    //    sh "ssh -o StrictHostKeyChecking=no ubuntu@3.80.3.90 ${dockerRun}"
                    //}
                }
            }
        }
    }
}
