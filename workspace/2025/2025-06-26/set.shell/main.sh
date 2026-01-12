#!/usr/bin/env bash

set -eu -o pipefail

function main
{
    echo "set1 = $(set1 | to_line)"
    echo "set2 = $(set2 | to_line)"
    echo "union(set1, set2) = $(sort -u <(set1) <(set2) | to_line)"
    echo "union(set2, set1) = $(sort -u <(set2) <(set1) | to_line)"
    echo "difference(set1, set2) = $(sort <(set1) <(set2) <(set2) | uniq -u | to_line)"
    echo "difference(set2, set1) = $(sort <(set2) <(set1) <(set1) | uniq -u | to_line)"
    echo "intersection(set1, set2) = $(sort <(set1) <(set2) | uniq -d | to_line)"
    echo "intersection(set2, set1) = $(sort <(set2) <(set1) | uniq -d | to_line)"
}

function set1
{
    seq 10 16
}

function set2
{
    seq 14 20
}

function to_line
{
    tr '\n' ' '
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi

