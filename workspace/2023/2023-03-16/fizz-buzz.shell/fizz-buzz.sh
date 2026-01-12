#!/bin/bash

set -eu

seq 100 | sed '3~3s/.*/Fizz/; 5~5s/.*/Buzz/; 15~15s/.*/FizzBuzz/' | xargs -n 10 | column -t

