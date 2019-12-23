FROM gitpod/workspace-full:latest

USER root
RUN apt-get update && \
    apt-get -y install xz-utils openjdk-8-jdk && \
    apt-get -y upgrade

USER gitpod

# Get android SDK
ENV ANDROID_HOME=/home/gitpod/sdk/android
ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
ARG ANDROID_SDK_NAME=sdk-tools-linux-4333796.zip

RUN mkdir -p ~/.android ${ANDROID_HOME} && \
    touch ~/.android/repositories.cfg
    cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/${ANDROID_SDK_NAME} && \
    unzip -q ${ANDROID_SDK_NAME} && \
    rm -f ${ANDROID_SDK_NAME} && \
    y | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses

# Get flutter SDK
ENV FLUTTER_HOME=/home/gitpod/sdk/flutter
ENV PATH=${PATH}:${FLUTTER_HOME}/bin
ARG FLUTTER_SDK_NAME=flutter_linux_v1.12.13+hotfix.5-stable.tar.xz

RUN cd ~/sdk && \
    wget -q https://storage.googleapis.com/flutter_infra/releases/stable/linux/${FLUTTER_SDK_NAME} &&\
    tar -xf ${FLUTTER_SDK_NAME} && \
    rm -f ${FLUTTER_SDK_NAME}

USER root
RUN apt-get -y purge openjdk-8-jdk && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/*;
