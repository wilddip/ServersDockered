FROM eclipse-temurin:21-noble AS build
ARG VELOCITY_HASH
RUN apt-get update && apt-get -y install git && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
RUN git clone https://github.com/PaperMC/Velocity.git /app
ADD https://mirror.gravitlauncher.com/5.6.x/patches/Velocity.patch /app/Velocity.patch
WORKDIR /app
RUN git config --global user.email "docker@example.com" && git config --global user.name "Docker Buildscript"
RUN git checkout $VELOCITY_HASH
RUN git am -3 Velocity.patch
RUN ./gradlew assemble --no-daemon

FROM eclipse-temurin:21-noble AS setup
ARG LAUNCHER_VERSION
RUN mkdir -p /app/data
COPY ServerWrapperConfig.json /app/ServerWrapperConfig.json
ADD https://github.com/GravitLauncher/Launcher/releases/download/$LAUNCHER_VERSION/ServerWrapper.jar /app/ServerWrapper.jar
WORKDIR /app
COPY --from=build /app/proxy/build/libs/*-all.jar /app/velocity.jar
COPY start.sh /app/start.sh
WORKDIR /app/data
VOLUME /app/data
EXPOSE 25565
ENTRYPOINT ["/app/start.sh"]
