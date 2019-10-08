FROM rust:1.37.0-slim-stretch

RUN apt-get update && apt-get install -y libssl-dev pkg-config cmake zlib1g-dev && \
	rustup component add rustfmt && \
	rustup component add clippy && \
	cargo install cargo-tarpaulin
