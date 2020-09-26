FROM rust:1.46.0-slim-buster

WORKDIR /sources

RUN apt-get update && \
    apt-get install -y \
        libssl-dev \
        pkg-config \
        cmake \
        zlib1g-dev \
        git \
        && \
    rustup target add x86_64-pc-windows-msvc && \
    rustup target add x86_64-apple-darwin && \
    rustup install nightly && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    cargo install cargo-outdated && \
    cargo install cargo-tarpaulin
