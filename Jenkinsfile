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
        
        stage('artifactory') {
            steps {
                rtMaven.tool = 'Maven-3.5.3'
                rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server:server
                rtMaven.resolver releaseRepo: 'libs-release', snapshotsRepo: 'libs-snapshot', server:server
                rtMaven.deployer.artifactoryDeploymentPatterns.addExclude("pom.xml")
                buildInfo = Artifactory.newBuildInfo()
                buildInfo.retention maxBuilds: 10, maxDays: 7, deleteBuildArtifacts: true
                buildInfo.env.capture = true
            }
        }
    }
}
