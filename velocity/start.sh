#!/bin/bash

if ! [ -f ServerWrapperConfig.json ]; then
    ln -s /app/ServerWrapperConfig.json ServerWrapperConfig.json
fi

if ! [ -f javaargs.txt ]; then
    echo "" > javaargs.txt
fi

exec java @javaargs.txt -cp /app/ServerWrapper.jar:/app/velocity.jar pro.gravit.launcher.server.ServerWrapper
