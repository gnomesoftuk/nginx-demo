DOCKER_NAMESPACE ?= gnomesoft
APPLICATION_NAME ?= nginx-demo
DOCKER_TAG ?= $(shell git log --format="%h" -n 1)

build:
	docker build --tag ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG} ./nginx -f Dockerfile

push:
	docker login -u ${DOCKER_NAMESPACE} --password-stdin < ./docker_pass
	docker push ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG}