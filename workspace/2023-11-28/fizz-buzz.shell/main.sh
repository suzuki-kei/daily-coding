#!/usr/bin/env bash

set -eu -o pipefail

seq 100 | sed -f fizz-buzz.sed | xargs -n 10 | column -t

