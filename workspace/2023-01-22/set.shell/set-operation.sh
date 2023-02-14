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

echo "set1 = $(printf '%d ' $(set1))"
echo "set2 = $(printf '%d ' $(set2))"

# 和集合 (union)
echo "union(set1, set2) = $(sort -u <(set1) <(set2) | tr '\n' ' ')"

# 差集合 (difference)
echo "difference(set1, set2) = $(sort <(set1) <(set2) <(set2) | uniq -u | tr '\n' ' ')"

# 共通部分 (intersection)
echo "intersection(set1, set2) = $(sort <(set1) <(set2) | uniq -d | tr '\n' ' ')"

