FROM gitpod/workspace-full:latest

ENV ANDROID_HOME=/home/gitpod/sdk/android \
    FLUTTER_HOME=/home/gitpod/sdk/flutter

ARG ANDROID_SDK_NAME=sdk-tools-linux-4333796.zip
ARG FLUTTER_SDK_NAME=flutter_linux_v1.12.13+hotfix.5-stable.tar.xz

USER root

RUN apt-get update && \
    apt-get -y install xz-utils && \
    apt-get -y upgrade && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/*;

USER gitpod

# Get android SDK
RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget https://dl.google.com/android/repository/${ANDROID_SDK_NAME} && \
    unzip ${ANDROID_SDK_NAME} && \
    rm -f ${ANDROID_SDK_NAME}

# Get flutter SDK
RUN cd ~/sdk && \
    wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/${FLUTTER_SDK_NAME} &&\
    tar -xvf ${FLUTTER_SDK_NAME} && \
    rm -f ${FLUTTER_SDK_NAME}
