#!/bin/bash

set -eu

declare -r size=$((1 << 5))
declare -r check=$(seq 1 $size | shuf | head -1)

echo "size=$size, check=$check"

for y in $(seq $size)
do
    for x in $(seq $size)
    do
        if [[ $((x & y)) = $check ]]
        then
            echo -n '＊'
        else
            echo -n '　'
        fi
    done

    echo
done

