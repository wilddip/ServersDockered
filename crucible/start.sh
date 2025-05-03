#!/bin/bash

if ! [ -d libraries ]; then
    ln -s /app/libraries libraries
fi

if ! [ -f ServerWrapperConfig.json ]; then
    ln -s /app/ServerWrapperConfig.json ServerWrapperConfig.json
fi

source /app/common-start.sh

if ! [ -f javaargs.txt ]; then
    echo "" > javaargs.txt
fi

exec java @/app/java9args.txt @javaargs.txt -Dcrucible.skipLibraryVerification=true -Dlauncher.noJAnsi=true -cp /app/ServerWrapper.jar:/app/Crucible.jar pro.gravit.launcher.server.ServerWrapper
