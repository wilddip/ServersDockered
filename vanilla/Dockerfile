FROM eclipse-temurin:21-noble AS downloadserver
ARG MINECRAFT_VERSION
RUN apt-get update && apt-get -y install curl jq && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
WORKDIR /app
COPY download-minecraft-server.sh /app/download-minecraft-server.sh
RUN /app/download-minecraft-server.sh $MINECRAFT_VERSION

FROM eclipse-temurin:21-noble AS setup
ARG LAUNCHER_VERSION
ARG AUTHLIB_VERSION
RUN mkdir -p /app/data
COPY ServerWrapperConfig.json /app/ServerWrapperConfig.json
COPY --from=downloadserver /app/server.jar /app/server.jar
ADD https://github.com/GravitLauncher/Launcher/releases/download/$LAUNCHER_VERSION/ServerWrapper.jar /app/ServerWrapper.jar
WORKDIR /app
RUN java -jar /app/server.jar nogui
RUN java -jar /app/ServerWrapper.jar installAuthlib https://mirror.gravitlauncher.com/5.6.x/authlib/LauncherAuthlib$AUTHLIB_VERSION.jar
COPY start.sh /app/start.sh
WORKDIR /app/data
VOLUME /app/data
EXPOSE 25565
ENTRYPOINT ["/app/start.sh"]
