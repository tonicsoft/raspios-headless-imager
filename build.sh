#!/bin/bash
docker run --rm --privileged \
  -v /dev:/dev \
  -v "${PWD}":/build \
  mkaczanowski/packer-builder-arm build -var-file=vars.hcl raspios-lite-armhf.pkr.hcl

sudo chown ${USER}:${USER} ./*.img