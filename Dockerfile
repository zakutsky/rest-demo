FROM adoptopenjdk/maven-openjdk11 as builder
WORKDIR /opt/app
COPY .mvn/ .mvn
COPY pom.xml ./
COPY ./src ./src
RUN mvn clean install

FROM bellsoft/liberica-runtime-container:jdk-all-11-cds-slim-musl
WORKDIR /opt/app
COPY --from=builder /opt/app/target/*.jar /opt/app/*.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/app/*.jar"]