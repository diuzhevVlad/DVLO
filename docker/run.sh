#!/bin/bash

CONTAINER_NAME="dvlo_container"
FINAL_IMAGE="dvlo:latest"
DATA_DIR="/home/vladislav/Documents/SemanticKITTI"

docker run \
  -it \
  --rm \
  --net=host \
  --ipc=host \
  --pid=host \
  --gpus all \
  --name ${CONTAINER_NAME} \
  -e=DISPLAY \
  -v ${DATA_DIR}:/data/SemanticKITTI \
  -v $(dirname "$0")/../experiment:/dvlo_workspace/DVLO/experiment \
  ${FINAL_IMAGE} \
  bash
