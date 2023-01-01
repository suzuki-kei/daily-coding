#!/bin/bash

shopt -s extglob

function daily-coding
{
    case "${1:-}" in
        cd)
            shift 1
            _daily-coding.cd "$@"
            ;;
        commit)
            _daily-coding.commit "${2:-}"
            ;;
        diff)
            _daily-coding.diff "${2:-}" "${3:-}"
            ;;
        help | --help | -h)
            _daily-coding.help
            ;;
        ls | list)
            _daily-coding.ls
            ;;
        stats)
            _daily-coding.stats "${2:-}"
            ;;
        *)
            _daily-coding.cd "$@"
            ;;
    esac
}

function _daily-coding.cd
{
    declare -r options="$(_daily-coding.cd.optparse "$@")"

    if [[ "${options}" == '--root' ]]; then
        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        cd "${repository_path}" && pwd
        return 0
    fi

    if [[ "${options}" =~ ^n=(.*)\ collection_name=(.*)$ ]]; then
        # n が正の数である場合は最後の cd で失敗するが意図通り.
        # 無効なオプションとして "Invalid option" と表示されるよりも,
        # cd に失敗した時のエラーメッセージの方が状況を理解しやすいため.
        declare -r n="${BASH_REMATCH[1]}"
        declare -r date_name="$(date --date "${n} days" '+%Y-%m-%d')"
        declare -r collection_name="${BASH_REMATCH[2]}"

        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        declare -r workspace_path="${repository_path}/workspace"

        if [[ "${collection_name}" = '' ]]; then
            declare -r target_path="${workspace_path}/${date_name}"
        else
            declare -r target_path="${workspace_path}/${date_name}/${collection_name}"
        fi

        if [[ ${n} -eq 0 ]]; then
            mkdir -p "${target_path}"
        fi
        cd "${target_path}" && pwd
        return 0
    fi

    if [[ "${options}" =~ ^date_name=(.*)\ collection_name=(.*)$ ]]; then
        declare -r date_name="${BASH_REMATCH[1]}"
        declare -r collection_name="${BASH_REMATCH[2]}"

        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        declare -r workspace_path="${repository_path}/workspace"

        if [[ "${collection_name}" = '' ]]; then
            declare -r target_path="${workspace_path}/${date_name}"
        else
            declare -r target_path="${workspace_path}/${date_name}/${collection_name}"
        fi

        if [[ "${date_name}" = "$(date '+%Y-%m-%d')" ]]; then
            mkdir -p "${target_path}"
        fi
        cd "${target_path}" && pwd
        return 0
    fi

    return 1
}

function _daily-coding.cd.optparse
{
    # cd --root
    if [[ "$@" = '--root' ]]
    then
        echo '--root'
        return 0
    fi

    # cd DATE [collection_name]
    if [[ "$@" =~ ^([1-9][0-9]{3}-[1-9][0-9]-[1-9][0-9])\ +([^-][^ ]*)$ ]] ||
       [[ "$@" =~ ^([1-9][0-9]{3}-[1-9][0-9]-[1-9][0-9])$ ]]
    then
        declare -r date_name="${BASH_REMATCH[1]}"
        declare -r collection_name="${BASH_REMATCH[2]:-}"
        echo "date_name=${date_name} collection_name=${collection_name}"
        return 0
    fi

    # cd [N] [collection_name]
    if [[ "$@" =~ ^([+-]?[0-9]+)\ +([^-][^ ]*)$ ]] ||
       [[ "$@" =~ ^([+-]?[0-9]+)$ ]] ||
       [[ "$@" =~ ^()+([^-][^ ]*)$ ]] ||
       [[ "$@" =~ ^$ ]]
    then
        declare -r n="${BASH_REMATCH[1]:-0}"
        declare -r date_name="$(date --date "${n} days" '+%Y-%m-%d')"
        declare -r collection_name="${BASH_REMATCH[2]:-}"
        echo "n=${n} collection_name=${collection_name}"
        return 0
    fi

    echo "Invalid options: [$@]" >&2
    return 1
}

function _daily-coding.commit
{
    case "${1:-}" in
        '')
            git commit --allow-empty-message --m ''
            ;;
        --amend)
            git commit --allow-empty-message --m '' --amend
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

function _daily-coding.diff
{
    declare -r file="${1:-}"
    declare -r offset="${2:--1}"

    if [[ "${file}" == '' ]]; then
        echo 'Invalid option: FILE is required.' >&2
        return 1
    fi
    if [[ ! -f "${file}" ]]; then
        echo "Invalid option: file [${file}] not found." >&2
        return 1
    fi

    declare -r target_file_path="$(_daily-coding._locate-file "${file}" "${offset}")"
    if [[ "${target_file_path}" = '' ]]; then
        echo 'same file is not found in other working directory.' >&2
        return 1
    fi
    vimdiff "${file}" "${target_file_path}"
}

function _daily-coding._locate-file
{
    declare -r workspace_path="$(cd "$(dirname "$1")"/../.. && pwd)"
    declare -r date_name="$(cd "$(dirname "$1")"/.. && basename "$(pwd)")"
    declare -r collection_name="$(cd "$(dirname "$1")" && basename "$(pwd)")"
    declare -r file_name="$(basename "$1")"

    declare -r nth=$2
    declare -r target_file_path="$(
        ls -1 "${workspace_path}"/*/"${collection_name}/${file_name}" |
            ([[ $nth -ge 0 ]] && cat || tac) |
            sed -n "/${date_name}/,$ p" |
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

        DESCRIPTION
            ${name} は日々のコーディング練習を支援する機能を提供します.

            日々作成するソースコードは以下のディレクトリ構成に従って保存します.

                <repository_path>/workspace/<date_name>/<collection_name>/

        WORDS
            ワークスペース
                <repository_path>/workspace/ のことです.
                日々作成するソースコードを保存する場所のルートディレクトリです.

            作業ディレクトリ
                <repository_path>/workspace/<date_name>/ のことです.

            コレクション
                <repository_path>/workspace/<date_name>/<collection_name>/ のことです.
                コレクションは日別の作業ディレクトリ内をさらに分けるために作成します.

        SYNOPSIS
            ${name} --root
            ${name} cd --root
                リポジトリのルートディレクトリに移動します.

            ${name} [N]
            ${name} cd [N]
                N 日前後の作業ディレクトリに移動します (デフォルトは N=0).
                N=0 の場合に限り, ディレクトリが存在しなければ作成します.

            ${name} commit [--amend]
                空メッセージで git commit します.

            ${name} diff FILE [N]
                FILE を直近の実装ファイルと比較します.

                別日の作業ディレクトリから FILE と同一のファイルを探し,
                N 個前後のファイルと vimdiff によって比較します (デフォルトは N=-1).

            ${name} help|--help|-h
                このコマンドの使い方を表示します.

            ${name} ls|list
                各作業ディレクトリに含まれるコレクションを表示します.

            ${name} stats [-v|-vv]
                各作業ディレクトリに含まれるソースコードの行数を表示します.
                -v を指定すると作業ディレクトリの 1 階層下のディレクトリごと,
                -vv を指定すると作業ディレクトリの 2 階層下のディレクトリごとに表示します.

        EXAMPLES
            # ${name} の使い方を表示します.
            ${name} help

            # 今日の作業ディレクトリに移動します.
            ${name} cd

            # 昨日の作業ディレクトリに移動します.
            ${name} cd -1

            # 各作業ディレクトリに含まれるコレクションを表示します.
            ${name} ls

            # 直近の同じ実装ファイルと比較します.
            ${name} diff FILE

            # 各作業ディレクトリに含まれるソースコードの行数を表示します.
            ${name} stats
            ${name} stats -v
            ${name} stats -vv

            # 空メッセージで git commit します.
            ${name} commit
EOS
}

function _daily-coding.ls
{
    declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
    declare -r workspace_path="${repository_path}/workspace"

    find "${workspace_path}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
}

function _daily-coding.stats
{
    declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
    declare -r workspace_path="${repository_path}/workspace"

    case "${1:-}" in
        '')
            declare -r glob='*'
            ;;
        -v)
            declare -r glob='*/*'
            ;;
        -vv)
            declare -r glob='*/*/*'
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac

    # カレントシェルの作業ディレクトリを変更したくないのでサブシェルで実行する.
    (
        cd "${workspace_path}"

        for path in ${glob}
        do
            declare lines=$(find "${path}" -type f | xargs cat | wc -l)
            echo "${path} ${lines} lines"
        done
    )
}

