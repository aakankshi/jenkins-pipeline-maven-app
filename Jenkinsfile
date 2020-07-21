pipeline {
    
    agent any 
    
    stages {
        
        stage('code checkout') {
            steps {
                git url: 'https://github.com/snehalshirsath/jenkins-pipeline-maven-app.git'
            }
        }
        
        stage('compile package') {
            steps {
                def mvnHome = tool name: 'maven-3' , type: 'maven'
                sh "${mvnHome}/bin/mvn package"
            }
        }
        
        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'SonarQubeScanner'
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
        
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
    }
}
