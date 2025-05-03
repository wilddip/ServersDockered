FROM eclipse-temurin:21-noble AS buildfoundation
RUN apt-get update && apt-get -y install git && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
RUN git clone --depth=1 https://github.com/kappa-maintainer/Foundation.git /app
ADD https://mirror.gravitlauncher.com/5.6.x/patches/CleanroomFoundation.patch /app/CleanroomFoundation.patch
WORKDIR /app
RUN git apply CleanroomFoundation.patch
RUN ./gradlew build --no-daemon

FROM eclipse-temurin:21-noble AS setup
ARG LAUNCHER_VERSION
ARG CLEANROOM_VERSION
RUN mkdir -p /app/data
COPY ServerWrapperConfig.json /app/ServerWrapperConfig.json
ADD https://github.com/CleanroomMC/Cleanroom/releases/download/$CLEANROOM_VERSION/cleanroom-$CLEANROOM_VERSION-installer.jar /app/installer.jar
ADD https://github.com/GravitLauncher/Launcher/releases/download/$LAUNCHER_VERSION/ServerWrapper.jar /app/ServerWrapper.jar
WORKDIR /app
RUN java -jar /app/installer.jar --installServer
RUN mv /app/cleanroom-$CLEANROOM_VERSION.jar /app/server.jar
RUN java -jar /app/ServerWrapper.jar installAuthlib https://mirror.gravitlauncher.com/5.6.x/authlib/LauncherAuthlib1.jar
COPY --from=buildfoundation /app/build/libs/*.jar /app/libraries/top/outlands/foundation/0.14.11/foundation-0.14.11.jar
COPY start.sh /app/start.sh
WORKDIR /app/data
VOLUME /app/data
EXPOSE 25565
ENTRYPOINT ["/app/start.sh"]
