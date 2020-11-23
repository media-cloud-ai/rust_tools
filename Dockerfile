FROM rust:1.48.0-slim-buster

ARG RUST_VERSION=1.48.0
# Mac OS X SDK version for OS X Cross
ARG MACOSX_SDK_VERSION=10.11

RUN apt-get update && \
    apt-get install -y \
        clang \
        cmake \
        curl \
        gcc-mingw-w64 \
        git \
        libssl-dev \
        libxml2-dev \
        pkg-config \
        zlib1g-dev

RUN cd /usr/local/ \
    && git clone --depth 1 https://github.com/tpoechtrager/osxcross \
    && cd osxcross \
    && curl -L -o "./tarballs/MacOSX$MACOSX_SDK_VERSION.sdk.tar.xz" \
        "https://s3.amazonaws.com/andrew-osx-sdks/MacOSX$MACOSX_SDK_VERSION.sdk.tar.xz" \
    && env UNATTENDED=yes OSX_VERSION_MIN=10.7 ./build.sh \
    && rm -rf *~ taballs *.tar.xz \
    && rm -rf /tmp/*

ENV PATH $PATH:/usr/local/osxcross/target/bin

WORKDIR /sources

RUN rustup target add x86_64-pc-windows-gnu && \
    rustup target add x86_64-pc-windows-msvc && \
    rustup target add x86_64-apple-darwin && \
    rustup install nightly && \
    rustup install $RUST_VERSION-x86_64-apple-darwin && \
    rustup install $RUST_VERSION-x86_64-pc-windows-msvc && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    cargo install cargo-outdated && \
    cargo install cargo-tarpaulin
