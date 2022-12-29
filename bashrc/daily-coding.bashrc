#!/bin/bash

shopt -s extglob

function daily-coding
{
    case "${1:-}" in
        -l | --list | list)
            _daily-coding.list
            ;;
        --diff | diff)
            if [[ "$2" = '' ]]; then
                echo 'Invalid option: target file is required.' >&2
                _daily-coding.help
                return
            fi
            _daily-coding.diff "$2" "${3:--1}"
            ;;
        "" | -+([0-9]))
            _daily-coding.enter-daily-directory "$1"
            ;;
        +([0-9]) | ++([0-9]))
            # 正の数を指定してこの分岐に入ると, 後続処理で必ず失敗する.
            # 当日の作業ディレクトリ以外は自動生成しないので,
            # 未来の作業ディレクトリに移動しようと cd するところで失敗する.
            # 無効なオプションとして "Invalid option" を出力されるより,
            # 後続処理の cd で失敗した方が状況を理解しやすいという理由で分岐している.
            _daily-coding.enter-daily-directory "$1"
            ;;
        -h | --help | help)
            _daily-coding.help
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            _daily-coding.help
            ;;
    esac
}

function _daily-coding.help
{
    declare -r name="${FUNCNAME[1]}"

    cat <<EOS | sed -r 's/^ {8}//'
        NAME
            ${name}

        SYNOPSIS
            ${name} [-N]
            ${name} [--diff FILE N|diff FILE N]
            ${name} [-h|--help|help]
            ${name} [-l|--list|list]

        EXAMPLES
            # ${name} の使い方を表示する.
            ${name} -h

            # 今日の作業ディレクトリに移動する.
            ${name}

            # 昨日の作業ディレクトリに移動する.
            ${name} -1

            # 各作業ディレクトリの直下に存在するファイルを表示する.
            ${name} -l

            # 直近の同じ実装ファイルと比較する.
            ${name} --diff FILE

        OPTIONS
            -N
                N 日前の作業ディレクトリに移動します (デフォルトは N=0).
                N=0 の場合に限り, ディレクトリが存在しなければ作成します.

            --diff FILE N | diff FILE N
                FILE を直近の実装ファイルと比較します.

                別日の作業ディレクトリから FILE と同一のファイルを探し,
                N 個前後のファイルと vimdiff によって比較します (デフォルトは N=-1).

            -h | --help | help
                このヘルプを表示します.

            -l | --list | list
                各作業ディレクトリの直下に存在するファイルを表示します.
EOS
}

function _daily-coding.list
{
    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r source_dir="${root_dir}/src"

    find "${source_dir}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
}

function _daily-coding.enter-daily-directory
{
    declare -r n_days="${1:-0}"
    declare -r target_date="$(date --date "${n_days} days" '+%Y-%m-%d')"

    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r source_dir="${root_dir}/src"
    declare -r target_dir="${source_dir}/${target_date}"

    if [[ ${n_days} -eq 0 ]]; then
        mkdir -p "${target_dir}"
    fi
    cd "${target_dir}" && pwd
}

function _daily-coding.diff
{
    declare -r file_name="$(basename "$1")"
    declare -r name_dir="$(cd "$(dirname "$1")" && basename "$(pwd)")"
    declare -r date_dir="$(cd "$(dirname "$1")/.." && basename "$(pwd)")"

    declare -r nth=$2

    vimdiff "$1" "$(
        ls -1 "$(dirname "$1")"/../../*/"${name_dir}/${file_name}" |
            sort $(test $nth -ge 0 && echo '-r') |
            sed -n "1,/${date_dir}/p" |
            head -n -$((nth < 0 ? -nth : nth)) |
            tail -1
    )"
}

