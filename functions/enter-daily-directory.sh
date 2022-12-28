#!/bin/bash
#
# 前提:
#     このファイルは以下のように source で読み込まれることを想定している.
#
#         # in .bashrc
#         source enter-daily-directory.sh
#
# 説明:
#     日別のディレクトリに移動する.
#     移動先が当日のディレクトリの場合に限り, 存在しないディレクトリを作成する.
#
# 使用例:
#     # 当日のディレクトリに移動する.
#     daily-coding.enter-daily-directory
#
#     # 1 日前のディレクトリに移動する.
#     daily-coding.enter-daily-directory -1
#

function daily-coding.enter-daily-directory
{
    declare -r n_days="${1:-0}"
    declare -r target_date="$(date --date "${n_days} days" '+%Y-%m-%d')"

    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r source_dir="${root_dir}/src"
    declare -r target_dir="${source_dir}/${target_date}"

    if [[ ${n_days} -eq 0 ]]; then
        mkdir -p "${target_dir}"
    fi
    cd "${target_dir}"
}

