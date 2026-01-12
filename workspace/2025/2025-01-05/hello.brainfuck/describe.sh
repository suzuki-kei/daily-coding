#!/usr/bin/env bash

set -eu -o posix -o pipefail

for file in *.b
do
    echo "==== ${file} ($(cat "${file}" | grep -vE '^#' | grep -vE '^$' | wc -c) chars)"
    cat "${file}" | grep -vE '^#' | grep -vE '^$'
    echo
done

