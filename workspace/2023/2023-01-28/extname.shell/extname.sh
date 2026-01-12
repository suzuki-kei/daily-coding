#!/bin/bash

function extname
{
    declare -r name="$(basename "$1")"

    if [[ "${name}" =~ \.[^.]*$ ]]; then
        echo "${BASH_REMATCH[0]}"
    else
        echo "${name}"
    fi
}

