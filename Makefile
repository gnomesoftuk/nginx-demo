DOCKER_NAMESPACE ?= gnomesoft
APPLICATION_NAME ?= nginx-demo
DOCKER_TAG ?= $(shell git log --format="%h" -n 1)

SOURCE_PATH=app

all:
	$(MAKE) auth build push

auth:
	echo ${DOCKER_PASS} | docker login -u ${DOCKER_NAMESPACE} --password-stdin

build:
	docker build --tag ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG} ./${SOURCE_PATH} -f Dockerfile

push:
	docker push ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG}

