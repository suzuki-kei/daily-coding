#!/bin/bash

set -eu

declare -r NAME="$1"
declare -r ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "${ROOT_DIR}/${NAME}"/src/{main,lib,test}

cabal init \
    --non-interactive           \
    --minimal                   \
    --no-comments               \
    --libandexe                 \
    --tests                     \
    --application-dir=src/main  \
    --source-dir=src/lib        \
    --test-dir=src/test         \
    --version=0.0.0             \
    "${NAME}"

