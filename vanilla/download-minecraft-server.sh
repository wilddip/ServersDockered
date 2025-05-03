#!/bin/bash
set -e

curl https://launchermeta.mojang.com/mc/game/version_manifest.json > version_manifest.json
VERSION_URL=$(cat version_manifest.json | jq -r ".versions.[] | select(.id == \"$1\").url" )
curl $VERSION_URL > version.json
SERVER_URL=$(cat version.json | jq -r ".downloads.server.url" )
curl $SERVER_URL > server.jar
