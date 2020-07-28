FROM tomcat

MAINTAINER snehal

COPY /artifacts/libs-snapshot-local/*.jar /usr/local/tomcat/webapps/

WORKDIR /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
