#!/bin/bash

shopt -s extglob

function daily-coding
{
    case "${1:-}" in
        "" | -+([0-9]))
            _daily-coding.cd "$1"
            ;;
        +([0-9]) | ++([0-9]))
            # 正の数を指定してこの分岐に入ると, 後続処理で必ず失敗する.
            # 当日の作業ディレクトリ以外は自動生成しないので,
            # 未来の作業ディレクトリに移動しようと cd するところで失敗する.
            # 無効なオプションとして "Invalid option" を出力されるより,
            # 後続処理の cd で失敗した方が状況を理解しやすいという理由で分岐している.
            _daily-coding.cd "$1"
            ;;
        cd | --cd)
            _daily-coding.cd "${2:-0}"
            ;;
        commit)
            _daily-coding.commit "${2:-}"
            ;;
        diff | --diff)
            if [[ "$2" = '' ]]; then
                echo 'Invalid option: FILE is required.' >&2
                _daily-coding.help
                return 1
            fi
            _daily-coding.diff "$2" "${3:--1}"
            ;;
        help | --help | -h)
            _daily-coding.help
            ;;
        ls | list | --ls | --list | -l)
            _daily-coding.ls
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            _daily-coding.help
            ;;
    esac
}

function _daily-coding.cd
{
    declare -r n_days="${1:-0}"
    declare -r target_date="$(date --date "${n_days} days" '+%Y-%m-%d')"

    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r workspace_dir="${root_dir}/workspace"
    declare -r target_dir="${workspace_dir}/${target_date}"

    if [[ ${n_days} -eq 0 ]]; then
        mkdir -p "${target_dir}"
    fi
    cd "${target_dir}" && pwd
}

function _daily-coding.commit
{
    case "$1" in
        '')
            git commit --allow-empty-message --m ''
            ;;
        --amend)
            git commit --allow-empty-message --m '' --amend
            ;;
        *)
            echo "Invalid option: $1" >&2
            return 1
            ;;
    esac
}

function _daily-coding.diff
{
    if [[ ! -f "$1" ]]; then
        echo "file not found: $1" >&2
        return 1
    fi

    declare -r target_file_path="$(_daily-coding._locate-file "$1" "$2")"
    if [[ "${target_file_path}" = '' ]]; then
        echo 'same file is not found in other working directory.' >&2
        return 1
    fi
    vimdiff "$1" "${target_file_path}"
}

function _daily-coding._locate-file
{
    declare -r file_name="$(basename "$1")"
    declare -r name_dir="$(cd "$(dirname "$1")" && basename "$(pwd)")"
    declare -r date_dir="$(cd "$(dirname "$1")/.." && basename "$(pwd)")"

    declare -r nth=$2
    declare -r target_file_path="$(
        ls -1 "$(cd "$(dirname "$1")"/../.. && pwd)"/*/"${name_dir}/${file_name}" |
            ([[ $nth -ge 0 ]] && cat || tac) |
            sed -n "/${date_dir}/,$ p" |
            sed -n "$((nth < 0 ? -nth+1 : nth+1)) p"
    )"

    if [[ ! -f "${target_file_path}" ]]; then
        echo ''
    else
        echo "$(realpath "${target_file_path}" --relative-to "$(pwd)")"
    fi
}

function _daily-coding.help
{
    declare -r name="${FUNCNAME[1]}"

    cat <<EOS | sed -r 's/^ {8}//'
        NAME
            ${name}

        SYNOPSIS
            ${name} [N]
            ${name} cd [N]|--cd [N]
                N 日前後の作業ディレクトリに移動します (デフォルトは N=0).
                N=0 の場合に限り, ディレクトリが存在しなければ作成します.

            ${name} commit [--amend]
                空メッセージで git commit します.

            ${name} diff FILE [N]|--diff FILE [N]
                FILE を直近の実装ファイルと比較します.

                別日の作業ディレクトリから FILE と同一のファイルを探し,
                N 個前後のファイルと vimdiff によって比較します (デフォルトは N=-1).

            ${name} help|--help|-h
                このヘルプを表示します.

            ${name} ls|list|--ls|--list|-l
                各作業ディレクトリの直下に存在するファイルを表示します.

        EXAMPLES
            # ${name} の使い方を表示する.
            ${name} help

            # 今日の作業ディレクトリに移動する.
            ${name} cd

            # 昨日の作業ディレクトリに移動する.
            ${name} cd -1

            # 各作業ディレクトリの直下に存在するファイルを表示する.
            ${name} ls

            # 直近の同じ実装ファイルと比較する.
            ${name} diff FILE

            # 空メッセージで git commit する.
            ${name} commit
EOS
}

function _daily-coding.ls
{
    declare -r root_dir="$(cd "$(dirname "${BASH_SOURCE:-0}")"/.. && pwd)"
    declare -r workspace_dir="${root_dir}/workspace"

    find "${workspace_dir}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
}

