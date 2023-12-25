#!/bin/bash
PROJECT_PATH="C:\Users\admin\OneDrive\Desktop\GenCore"
CONTAINER_NAME="gencore-container"
IMAGE_NAME="gencore-app"
VOLUME_NAME="gencore-volume"

echo "[**Checking if Docker is running...**]"
docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[**Docker is not running. Please start Docker and try again.**]"
    exit 1
fi

echo "[**Checking if the container already exists...**]"
if docker ps -a | grep -q $CONTAINER_NAME; then
    echo "[**Found existing container. Attempting to start...**]"
    docker start $CONTAINER_NAME
    exit 0
fi

echo "[**Building Docker Image...**]"
docker build -t $IMAGE_NAME $PROJECT_PATH

echo "[**Running Docker Container with Persistent Volume...**]"
docker run -d --name $CONTAINER_NAME -v $VOLUME_NAME:/data -v $PROJECT_PATH:/GenCore $IMAGE_NAME

echo "[**Done.**]"