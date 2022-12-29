#!/bin/bash
#
# 前提:
#     このファイルは以下のように source で読み込まれることを想定している.
#
#         # in .bashrc
#         source list.sh
#
# 説明:
#     日別ディレクトリの直下にあるファイルを一覧表示する.
#
# 使用例:
#     daily-coding.list
#

function daily-coding.list
{
    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r source_dir="${root_dir}/src"

    find "${source_dir}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
}

