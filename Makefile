DOCKER_REGISTRY?=
DOCKER_IMG_NAME?=ftvsubtil/rust
ifneq ($(DOCKER_REGISTRY), ) 
	DOCKER_IMG_NAME := /${DOCKER_IMG_NAME}
endif
VERSION="1.39.0-slim-stretch"

docker-build:
	@docker build -t ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION} .

docker-clean:
	@docker rmi ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION}

docker-push-registry:
	@docker push ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION}

test:
	@echo "FMT VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION} cargo fmt --version
	@echo
	@echo "CLIPPY VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION} cargo clippy --version
	@echo
	@echo "TARPAULIN VERSION"
	@docker run --rm ${DOCKER_REGISTRY}${DOCKER_IMG_NAME}:${VERSION} cargo tarpaulin --version
