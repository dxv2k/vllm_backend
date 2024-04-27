#!/bin/bash

# Set the version number
VERSION="24.03"

# Set the Docker image
IMAGE="nvcr.io/nvidia/tritonserver:$VERSION-vllm-python-py3"
TRITON_HTTP_PORT=8012

# Run the Docker command
docker run --gpus all -it --net=host --rm \
    -p 8001:8001 \
    -p $TRITON_HTTP_PORT:$TRITON_HTTP_PORT \
    --shm-size=1G --ulimit memlock=-1 --ulimit stack=67108864 \
    -v "$PWD:/work" -w /work "$IMAGE" tritonserver --model-store ./samples/model_repository  \
    --http-port $TRITON_HTTP_PORT
