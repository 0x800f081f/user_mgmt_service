########################################
# Stage 1: Build
########################################
FROM alpine:3 AS build
RUN apk update && apk add openjdk25 gradle

WORKDIR /app

# Copy Gradle wrapper & build config first to leverage Docker layer caching
COPY gradlew ./
COPY gradle ./
COPY build.gradle settings.gradle ./

# Make wrapper executable and pre-fetch dependencies (cached unless build files change)
RUN gradle --no-daemon dependencies

# Copy application sources and build the executable jar
COPY src ./src

RUN gradle clean bootJar \
    && cp "$(find build/libs -maxdepth 1 -type f -name '*.jar' ! -name '*-plain.jar')" app.jar

########################################
# Stage 2: Runtime
########################################
FROM alpine:3 AS runtime
RUN apk update && apk add openjdk25-jre

ARG APP_USER=spring
ARG APP_UID=10001
ARG APP_HOME=/app

ENV APP_HOME=${APP_HOME}

# Create a dedicated, unprivileged system user/group to run the application
RUN addgroup --system --gid "${APP_UID}" "${APP_USER}" \
    && adduser --system --u "${APP_UID}" -s /usr/sbin/nologin "${APP_USER}"

WORKDIR ${APP_HOME}

COPY --from=build --chown=${APP_UID}:${APP_UID} /app/app.jar ./app.jar

USER ${APP_UID}

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
