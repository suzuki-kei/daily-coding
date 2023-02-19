#!/bin/bash

set -eu

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
    cat | tr '\n' ' '
}

echo "set1 = $(set1 | to_line)"
echo "set2 = $(set2 | to_line)"

# 和集合 (union)
echo "union(set1, set2) = $(sort -u <(set1) <(set2) | to_line)"

# 差集合 (difference)
echo "difference(set1, set2) = $(sort <(set1) <(set2) <(set2) | uniq -u | to_line)"

# 共通部分 (intersection)
echo "intersection(set1, set2) = $(sort <(set1) <(set2) | uniq -d | to_line)"

