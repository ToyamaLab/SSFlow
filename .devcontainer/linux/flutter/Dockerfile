# ref: https://zenn.dev/nagakuta/articles/bea80b17f315bd069a90

FROM ubuntu:20.04

LABEL maintainer="Taichi Kurihara <kuri@db.ics.keio.ac.jp>"

WORKDIR /workspace

ARG DART_VERSION=2.14.4
RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y --no-install-recommends tzdata && \
    apt-get update && \
    apt-get install -y --no-install-recommends bash ca-certificates clang cmake curl file git libglu1-mesa libgtk-3-dev ninja-build pkg-config unzip xz-utils zip && \
    curl https://storage.googleapis.com/dart-archive/channels/stable/release/$DART_VERSION/sdk/dartsdk-linux-x64-release.zip -o /tmp/dart-sdk.zip && \
    unzip /tmp/dart-sdk.zip -d /usr/lib && rm /tmp/dart-sdk.zip

ENV PATH=/usr/lib/dart-sdk/bin:$PATH
ENV FVM_ROOT=/root/.pub-cache
ENV PATH $FVM_ROOT/bin:$PATH
ARG FLUTTER_VERSION=2.5.2

RUN dart pub global activate fvm && \
    fvm doctor && \
    fvm install $FLUTTER_VERSION && \
    fvm global $FLUTTER_VERSION && \
    fvm flutter config --enable-web --enable-linux-desktop --enable-macos-desktop --enable-windows-desktop --enable-android --enable-ios --enable-fuchsia && \
    fvm flutter precache

RUN apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*