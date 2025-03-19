#!/bin/bash

set -e

# Variables
CONTAINER_NAME="postbuild_container"
BASE_IMAGE="dvlo_base:latest"
FINAL_IMAGE="dvlo:latest"

# Building base image
echo "Building base image '$BASE_IMAGE'..."
docker build -f $(dirname "$0")/Dockerfile \
    -t ${BASE_IMAGE} \
    $(dirname "$0")/..

cleanup() {
  echo "Interrupt received. Stopping and removing container '${CONTAINER_NAME}'..."
  docker kill "${CONTAINER_NAME}" >/dev/null 2>&1 || true
  docker rm "${CONTAINER_NAME}" >/dev/null 2>&1 || true
  exit 1
}

trap cleanup SIGINT SIGTERM

# Run the container and execute the post-build script
echo "Starting container '$CONTAINER_NAME' from image '$BASE_IMAGE'..."
docker run --gpus all --name "$CONTAINER_NAME" "$BASE_IMAGE" sh -c "docker/post-build.sh"

# Commit the container changes to a final image
echo "Committing changes to final image '$FINAL_IMAGE'..."
docker commit "$CONTAINER_NAME" "$FINAL_IMAGE"

# Optionally remove the container after commit
echo "Removing container '$CONTAINER_NAME'..."
docker rm "$CONTAINER_NAME"

echo "Done! Final image '$FINAL_IMAGE' created."
