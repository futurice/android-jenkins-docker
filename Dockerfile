# Jenkins comes with JDK8
FROM jenkins

# Set desired Android Linux SDK version's zip file name 
ENV ANDROID_SDK_ZIP sdk-tools-linux-3859397.zip
ENV ANDROID_SDK_ZIP_URL https://dl.google.com/android/repository/$ANDROID_SDK_ZIP
ENV ANDROID_HOME /opt/android-sdk-linux

ENV GRADLE_ZIP gradle-3.0-bin.zip
ENV GRADLE_ZIP_URL https://services.gradle.org/distributions/$GRADLE_ZIP

ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:/opt/gradle-3.0/bin

USER root

# Init dependencies for the setup process
RUN dpkg --add-architecture i386
RUN apt-get update && \
	apt-get install software-properties-common python-software-properties unzip -y

# Install gradle
ADD $GRADLE_ZIP_URL /opt/
RUN unzip /opt/$GRADLE_ZIP -d /opt/ && \
	rm /opt/$GRADLE_ZIP


# Install Android SDK
ADD $ANDROID_SDK_ZIP_URL /opt/
RUN unzip -q /opt/$ANDROID_SDK_ZIP -d $ANDROID_HOME && \
	rm /opt/$ANDROID_SDK_ZIP

# Install required build-tools
RUN	echo y | sdkmanager platform-tools \  
	"build-tools;25.0.0" \ 
	"platforms;android-25" \
	"extras;android;m2repository" \
	"extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" \
	"extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"  && \
	chown -R jenkins $ANDROID_HOME

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
USER jenkins

# List desired Jenkins plugins here
RUN /usr/local/bin/install-plugins.sh git gradle
