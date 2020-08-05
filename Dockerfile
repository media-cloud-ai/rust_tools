FROM rust:1.45.1-slim-stretch

WORKDIR /sources

RUN apt-get update && apt-get install -y libssl-dev pkg-config cmake zlib1g-dev && \
	rustup component add rustfmt && \
	rustup component add clippy && \
	cargo install cargo-outdated && \
	cargo install cargo-tarpaulin
