#! /bin/bash

 docker image build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg USER=$(id -un) \
    --build-arg GROUP=$(id -gn) \
    -t test \
    .