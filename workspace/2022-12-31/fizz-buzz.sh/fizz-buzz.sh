#!/bin/bash

seq 100 | sed -r '3~3s/.*/Fizz/; 5~5s/.*/Buzz/; 15~15s/.*/FizzBuzz/' | xargs -n 10 | column -t

