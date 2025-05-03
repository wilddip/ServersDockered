#!/bin/bash

if ! [ -d libraries ]; then
    ln -s /app/libraries libraries
fi

if ! [ -d versions ]; then
    ln -s /app/versions versions
fi

if ! [ -d cache ]; then
    ln -s /app/cache cache
fi

if ! [ -f ServerWrapperConfig.json ]; then
    ln -s /app/ServerWrapperConfig.json ServerWrapperConfig.json
fi

if ! [ -f javaargs.txt ]; then
    echo "-Xmx2G" > javaargs.txt
fi

exec java @javaargs.txt -cp /app/ServerWrapper.jar pro.gravit.launcher.server.ServerWrapper
