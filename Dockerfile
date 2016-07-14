FROM debian:latest

RUN apt-get update && \
    apt-get install -y wget git sudo nodejs screen curl redir python python-pip make g++ lib32z1 zip unzip openjdk-7-jre-headless libc6-i386 lib32stdc++6 && \
    apt-get clean && \
    apt-get autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
RUN export PATH="$PATH:$JAVA_HOME"
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools

RUN mkdir -m 0750 /.android
ADD files/insecure_shared_adbkey /.android/adbkey
ADD files/insecure_shared_adbkey.pub /.android/adbkey.pub
ADD files/start.sh /start.sh

EXPOSE 5555
EXPOSE 4723

RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz" | tar -zx -C /opt && \
echo y | android update sdk --no-ui --all --filter platform-tools,build-tools-24.0.0,tools --force


RUN echo y | android update sdk --no-ui --filter android-22 --all

RUN echo y | android update sdk --no-ui --filter android-23 --all

RUN echo y | android update sdk --no-ui --filter sys-img-armeabi-v7a-android-22 --all

#ENV node_version v4.4.7
#RUN wget -qO- -P /home/appium https://nodejs.org/dist/${node_version}/node-${node_version}.tar.gz | tar -zx -C /#home/appium && \
#    cd /home/appium/node-${node_version}/ && ./configure --prefix=/home/appium/apps && make && make install && \
#rm -rf /home/appium/node-${node_version} /tmp/*

RUN mkdir /home/work
RUN cd /home/work
RUN wget http://www.eu.apache.org/dist//ant/binaries/apache-ant-1.9.7-bin.tar.gz

RUN tar -xvzf apache-ant-1.9.7-bin.tar.gz
RUN rm apache-ant-1.9.7-bin.tar.gz
RUN export ANT_HOME="$HOME/work/apache-ant-1.9.7"
RUN export PATH="$PATH:$ANT_HOME/bin"

RUN ant -f fetch.xml -Ddest=system

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs

RUN npm install -g grunt grunt-cli

RUN git clone --branch v1.4.16 git://github.com/appium/appium.git

RUN cd appium
RUN ./reset.sh -android --verbose

RUN pip install robotframework
RUN pip install robotframework-appiumlibrary

RUN chmod +x /start.sh
CMD /start.sh
