#!/bin/bash

if ! [ -d libraries ]; then
    ln -s /app/libraries libraries
fi

if ! [ -d minecraft_server.1.12.2.jar ]; then
    ln -s /app/minecraft_server.1.12.2.jar minecraft_server.1.12.2.jar
fi

if ! [ -f ServerWrapperConfig.json ]; then
    ln -s /app/ServerWrapperConfig.json ServerWrapperConfig.json
fi

if ! [ -f javaargs.txt ]; then
    echo "" > javaargs.txt
fi

exec java @javaargs.txt -Dcrucible.skipLibraryVerification=true -Dlauncher.noJAnsi=true -cp /app/ServerWrapper.jar:/app/server.jar pro.gravit.launcher.server.ServerWrapper
