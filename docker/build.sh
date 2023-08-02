#! /bin/bash

name=dev

DOCKER_BUILDKIT=1 docker build --pull -t $name \
   --build-arg USER_ID=$(id -u) \
   --build-arg GROUP_ID=$(id -g) \
   --build-arg USER=$(id -un) \
   --build-arg GROUP=$(id -gn) \
   .