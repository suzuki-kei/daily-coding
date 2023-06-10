#!/bin/bash

set -eu

seq 100 | sed -f fizz-buzz.sed | xargs -n 10 | column -t

