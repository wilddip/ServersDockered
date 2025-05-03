FROM eclipse-temurin:21-noble AS buildrfb
RUN apt-get update && apt-get -y install git && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
RUN git clone --depth=1 https://github.com/GTNewHorizons/RetroFuturaBootstrap.git /app
ADD https://mirror.gravitlauncher.com/5.6.x/patches/rfb.patch /app/rfb.patch
WORKDIR /app
RUN git apply rfb.patch
RUN ./gradlew build --no-daemon

FROM eclipse-temurin:21-noble AS setup
ARG LAUNCHER_VERSION
ARG CRUCIBLE_HASH
RUN mkdir -p /app/data
COPY ServerWrapperConfig.json /app/ServerWrapperConfig.json
ADD https://github.com/RetroForge/Crucible/releases/download/all-patches-$CRUCIBLE_HASH/Crucible-1.7.10-all-patches-$CRUCIBLE_HASH-server.jar /app/Crucible.jar
ADD https://github.com/RetroForge/Crucible/releases/download/all-patches-$CRUCIBLE_HASH/java9args.txt /app/java9args.txt
ADD https://github.com/GravitLauncher/Launcher/releases/download/$LAUNCHER_VERSION/ServerWrapper.jar /app/ServerWrapper.jar
WORKDIR /app
RUN java -jar /app/Crucible.jar
RUN java -jar /app/ServerWrapper.jar installAuthlib https://mirror.gravitlauncher.com/5.6.x/authlib/LauncherAuthlib1.jar
COPY --from=buildrfb /app/build/libs/*.jar /app/libraries//com/gtnewhorizons/retrofuturabootstrap/RetroFuturaBootstrap/1.0.10/RetroFuturaBootstrap-1.0.10.jar
COPY start.sh /app/start.sh
WORKDIR /app/data
VOLUME /app/data
EXPOSE 25565
ENTRYPOINT ["/app/start.sh"]
