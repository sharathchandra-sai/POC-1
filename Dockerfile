FROM openjdk:11
COPY target/project-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
