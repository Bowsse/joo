#!/bin/bash

adb start-server
echo | android create avd --force -n android -t android-22 --abi armeabi-v7a
screen -dm emulator64-arm -avd android -noaudio -no-window -gpu off -verbose -qemu
cd /home/work
git clone https://github.com/IoTitude/Instapp.git  Instapp
cd Instapp
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
npm install
ionic resources android
ionic platform add android
ionic state reset -- plugins
ionic build android


sleep 30
adb devices
