#!/bin/bash
CONTAINER_NAME=$1

TEST_PROTO=http
TEST_HOST=localhost
TEST_PORT=8080

CID=''
START=$SECONDS
while [ "${CID}" = "" -a ${SECONDS} -le 30 ]; do
    CID=$(docker ps -q --filter "label=name=${CONTAINER_NAME}" --filter 'status=running')
    echo "Waiting for $CONTAINER_NAME container to start... $((SECONDS - $START))s"
    sleep 1
done

curl -o - -I --retry 5 --retry-delay 1 ${TEST_PROTO}://${TEST_HOST}:${TEST_PORT}

if [ $? -gt 0 ]; then
    echo "Failed to connect to $CONTAINER_NAME container"
    exit 1
fi