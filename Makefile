DOCKER_REGISTRY?=
DOCKER_IMG_NAME_RUST?=mediacloudai/rust-tools
DOCKER_IMG_NAME_CLANG?=mediacloudai/clang-tools
ifneq ($(DOCKER_REGISTRY), )
	DOCKER_IMG_NAME := /${DOCKER_IMG_NAME}
endif
VERSION_RUST="1.39.0-slim-stretch"
VERSION_CLANG="10.0.0"

docker-build-rs:
	@docker build -t ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} -f Dockerfile.rust .

docker-clean-rs:
	@docker rmi ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST}

docker-push-registry-rs:
	@docker push ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST}

docker-build-clang:
	@docker build -t ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_CLANG}:${VERSION_CLANG} -f Dockerfile.clang .

docker-clean-clang:
	@docker rmi ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_CLANG}:${VERSION_CLANG}

docker-push-registry-clang:
	@docker push ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_CLANG}:${VERSION_CLANG}

test-rs:
	@echo "FMT VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} cargo fmt --version
	@echo
	@echo "CLIPPY VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} cargo clippy --version
	@echo
	@echo "TARPAULIN VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} cargo tarpaulin --version

test-clang:
	@echo "LLVM-PROFDATA VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} llvm-profdata merge --version
	@echo "LLVM-COV VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} llvm-cov --version
	@echo
	@echo "CLANG-FORMAT VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} clang-format --version
	@echo
	@echo "CLANG-TIDY VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME_RUST}:${VERSION_RUST} clang-tidy --version
