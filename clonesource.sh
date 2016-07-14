#!/bin/bash
echo 'Cloning Instapp repo...'
git clone https://github.com/IoTitude/Instapp.git  Instapp
cd Instapp

git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
# sed -i "/BASE_URL/c\  'BASE_URL': 'http://localhost:9100',/" www/js/services.js

npm install
export ANDROID_HOME=/usr/local/android-sdk-linux
PATH=$PATH:$ANDROID_HOME
ionic resources android
ionic platform add android
ionic state reset -- plugins
echo "Project ready."
