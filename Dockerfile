###########
# WebVOWL #
###########

FROM node:14-buster AS webvowl-build

WORKDIR /webvowl

COPY package.json Gruntfile.js webpack.config.js ./
COPY src ./src
COPY license.txt ./license.txt

RUN npm install --ignore-scripts
RUN npm run release

FROM maven:3.9.6-eclipse-temurin-21 AS owl2vowl-build

WORKDIR /owl2vowl

COPY owl2vowl/pom.xml ./pom.xml
COPY owl2vowl/src ./src
COPY --from=webvowl-build /webvowl/deploy ./src/main/resources/static

RUN mvn -DskipTests -Denv=war package

FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

COPY --from=owl2vowl-build /owl2vowl/target/owl2vowl.war /app/owl2vowl.war

ENV JAVA_TOOL_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.text=ALL-UNNAMED"

EXPOSE 8080

CMD ["java", "-jar", "/app/owl2vowl.war"]
