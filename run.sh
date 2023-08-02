#! /bin/bash

docker container run --rm -d \
    -v $(cd ../ && pwd):$(cd ../ && pwd) \
    -v ${HOME}/.ssh:${HOME}/.ssh \
    test
