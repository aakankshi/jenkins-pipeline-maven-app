pipeline {
    
    agent any 
    
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
                
        stage('compile package') {
            steps {
                sh "mvn package"
            }
        }
    }
}
