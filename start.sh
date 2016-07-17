#!/bin/bash


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

adb start-server
screen -dm emulator -avd android -noaudio -no-window -gpu off -verbose -engine classic
cd /home/work/appium
screen -dm node .


