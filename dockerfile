FROM java:8-jdk-alpine

MAINTAINER snehal

COPY /artifacts/libs-snapshot-local/*.jar /usr/app/

WORKDIR /usr/app

EXPOSE 8080

CMD ["java", "-jar", "*.jar"]
