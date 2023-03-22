#!/bin/bash

set -eu

size=$((1 << 5))
check=$(seq 1 $size | shuf | head -1)

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

