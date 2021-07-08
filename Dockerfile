FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD


COPY pom.xml /build/
COPY src /build/src/

WORKDIR /build/
RUN mvn package

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/techbrewers-transactionDetails-1.0.jar /app/

ENV PORT 8082

EXPOSE 8082

ENTRYPOINT ["java", "-jar", "techbrewers-transactionDetails-1.0.jar"]
