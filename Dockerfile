####
# This Dockerfile is used to package the yak-server application
#
# Build the image with:
#
# ./gradlew buildDocker
#
###

FROM openjdk:17-alpine AS jre-build
WORKDIR /app

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} build/app.jar

# find JDK dependencies dynamically from jar
RUN jdeps \
# dont worry about missing modules
--ignore-missing-deps \
# suppress any warnings printed to console
-q \
# java release version targeting
--multi-release 17 \
# output the dependencies at end of run
--print-module-deps \
# pipe the result of running jdeps on the app jar to file
build/app.jar > jre-deps.info
# new since last time!
RUN jlink --verbose \
--compress 2 \
--strip-java-debug-attributes \
--no-header-files \
--no-man-pages \
--output jre \
--add-modules $(cat jre-deps.info)

# take a smaller runtime image for the final output
FROM alpine:latest
WORKDIR /deployment

# copy the custom JRE produced from jlink
COPY --from=jre-build /app/jre jre

# copy the app
COPY --from=jre-build /app/build/app.jar app.jar

EXPOSE 8080

# run the app on startup
ENTRYPOINT jre/bin/java -jar app.jar