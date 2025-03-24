#!/usr/bin/env bash

set -euo pipefail

VER=devel
IMAGE=immcantation/lab:${VER}
NAME=immcantation_lab_${VER}
PORT=7778

DIR=$(realpath $(dirname $0))

# user is magus
docker run \
   --rm \
   --workdir /home/magus/notebooks \
   --name ${NAME} \
   -d \
   -p ${PORT}:8787 \
   -e PASSWORD=password \
   ${IMAGE}

>&2 echo ${NAME} listening on port ${PORT}

exit 0
