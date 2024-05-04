#!/bin/bash

# Set the version number
VERSION="24.03"

# Set the Docker image
IMAGE="nvcr.io/nvidia/tritonserver:$VERSION-vllm-python-py3"
TRITON_GRPC_PORT=8001
TRITON_HTTP_PORT=8012

# Run the Docker command
docker run --gpus all -it --net=host --rm \
    -p $TRITON_GRPC_PORT:$TRITON_GRPC_PORT \
    -p $TRITON_HTTP_PORT:$TRITON_HTTP_PORT \
    --shm-size=1G --ulimit memlock=-1 --ulimit stack=67108864 \
    -v "$HOME/.cache/huggingface/:/root/.cache/huggingface/" -v "$PWD:/work" \
    -w /work "$IMAGE" tritonserver --model-store ./phi_workspace/ \
    --http-port $TRITON_HTTP_PORT \
    --grpc-port $TRITON_GRPC_PORT