FROM openjdk:11 as build

WORKDIR /workspace/app

COPY . /workspace/app

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test -i --stacktrace

FROM openjdk:11.0-slim

COPY --from=build /workspace/app/build/libs/*-SNAPSHOT.jar app.jar

RUN /bin/sh -c 'touch /app.jar'

ENTRYPOINT ["java","-jar","/app.jar"]
