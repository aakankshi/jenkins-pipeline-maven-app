pipeline {
    
    agent any 
    
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
        
        stage('SonarQube Analysis') {
            steps {
                WithSonarQubeEnv('SonarQube7.5') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        } 
    }
}
