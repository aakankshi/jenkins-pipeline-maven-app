FROM java:8-jdk-alpine

MAINTAINER snehal

COPY my-app-1.0-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app

EXPOSE 8080

CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
