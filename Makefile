DOCKER_NAMESPACE ?= gnomesoft
APPLICATION_NAME ?= nginx-demo
DOCKER_TAG ?= $(shell git log --format="%h" -n 1)

SOURCE_PATH=app

all:
	$(MAKE) auth build test push

auth:
	echo ${DOCKER_PASS} | docker login -u ${DOCKER_NAMESPACE} --password-stdin

build:
	docker build --tag ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG} ./${SOURCE_PATH} -f Dockerfile

test:
	docker run --rm -d -p 8080:8080 ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG}
	bash ./test_container.sh ${APPLICATION_NAME}
	docker stop $$(docker ps -q --filter "label=name=${APPLICATION_NAME}")

push:
	docker push ${DOCKER_NAMESPACE}/${APPLICATION_NAME}:${DOCKER_TAG}

