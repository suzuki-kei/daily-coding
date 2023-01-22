#!/bin/bash

shopt -s extglob

function daily-coding
{
    case "${1:-}" in
        cd | commit | diff | diff2 | help | ls | random | stats)
            declare -r name="$1"
            shift 1
            _daily-coding.$name "$@"
            ;;
        --help | -h)
            shift 1
            _daily-coding.help "$@"
            ;;
        *)
            _daily-coding.cd "$@"
            ;;
    esac
}

function _daily-coding.cd
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    # cd --root
    if [[ "${1:-}" = '--root' ]]; then
        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        cd "${repository_path}" && pwd
        return 0
    fi

    # cd [N]
    if [[ "${1:-}" =~ ^$ ]] || [[ "${1:-}" =~ ^([+-]?[0-9]+)$ ]]; then
        # n が正の数である場合は最後の cd で失敗するが意図通り.
        # 無効なオプションとして "Invalid option" と表示されるよりも,
        # cd に失敗した時のエラーメッセージの方が状況を理解しやすいため.
        declare -r n="${BASH_REMATCH[1]:-0}"

        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        declare -r base_workspace_name="$(date '+%Y-%m-%d')"
        declare -r base_workspace_path="${repository_path}/workspace/${base_workspace_name}"

        declare -r target_workspace_path="$(
            _daily-coding.locate_workspace "${base_workspace_path}" ${n}
        )"
        if [[ "${target_workspace_path}" = '' ]]; then
            echo 'Not found' >&2
            return 1
        fi

        if [[ ${n} -eq 0 ]]; then
            mkdir -p "${target_workspace_path}"
        fi
        cd "${target_workspace_path}" && pwd
        return 0
    fi

    # cd DATE
    if [[ "${1:-}" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
        declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
        declare -r workspace_name="${BASH_REMATCH[1]}"
        declare -r workspace_path="${repository_path}/workspace/${workspace_name}"

        if [[ "${workspace_name}" = "$(date '+%Y-%m-%d')" ]]; then
            mkdir -p "${workspace_path}"
        fi
        cd "${workspace_path}" && pwd
        return 0
    fi

    echo "Invalid options: [$@]" >&2
    return 1
}

function _daily-coding.extname
{
    declare -r name="$(basename "$1")"

    if [[ "$name" =~ \.[^.]*$ ]]; then
        echo "${BASH_REMATCH[0]}"
    else
        echo "$name"
    fi
}

function _daily-coding.locate_workspace
{
    declare -r root_workspace_path="$(dirname "$1")"
    declare -r base_workspace_path="$1"
    declare -r base_workspace_name="$(basename "$1")"
    declare -r n=$2

    declare -r target_workspace_path="$(
        cat <(ls -1d "${root_workspace_path}"/*) \
            <(echo "${root_workspace_path}/${base_workspace_name}") |
            sort -u |
            ([[ $n -ge 0 ]] && cat || tac) |
            sed -n "/${base_workspace_name}/,$ p" |
            sed -n "$((n < 0 ? -n+1 : n+1)) p"
    )"

    if [[ "${target_workspace_path}" = '' ]]; then
        echo ''
    else
        echo "$(realpath "${target_workspace_path}" --relative-to "$(pwd)")"
    fi
}

function _daily-coding.commit
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
    declare -r root_workspace_path="${repository_path}/workspace"

    if [[ ! "$(pwd)" = "${root_workspace_path}"/*/* ]]; then
        echo "Not in collection directory." >&2
        return 1
    fi

    declare -r collection_path="$(realpath "$(pwd)" --relative-to "${root_workspace_path}")"
    declare -r collection_name="$(echo "${collection_path}" | cut -d/ -f2)"

    case "${1:-}" in
        '')
            git commit -m "${collection_name}"
            ;;
        --amend)
            git commit -m "${collection_name}" --amend
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

function _daily-coding.diff
{
    if [[ ! $# -le 2 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r base_file_path="${1:-}"
    declare -r n="${2:--1}"

    if [[ "${base_file_path}" == '' ]]; then
        echo 'Invalid option: FILE is required.' >&2
        return 1
    fi
    if [[ ! -f "${base_file_path}" ]]; then
        echo "Invalid option: file [${base_file_path}] not found." >&2
        return 1
    fi

    declare -r target_file_path="$(_daily-coding.locate_file "${base_file_path}" "${n}")"
    if [[ "${target_file_path}" = '' ]]; then
        echo 'same file is not found in other working directory.' >&2
        return 1
    fi
    vimdiff "${base_file_path}" "${target_file_path}"
}

function _daily-coding.diff2
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r n=${1:--1}
    declare -r base_collection_path="$(_daily-coding.to_collection_path "$(pwd)")"

    if [[ "${base_collection_path}" == '' ]]; then
        echo 'Not in collection directory.' >&2
        return 1
    fi

    declare -r target_collection_path="$(_daily-coding.locate_collection "${base_collection_path}" ${n})"

    if [[ "${target_collection_path}" == '' ]]; then
        echo 'target collection is not found.' >&2
        return 1
    fi

    diff -q \
        "$(realpath "${base_collection_path}" --relative-to "$(pwd)")" \
        "$(realpath "${target_collection_path}" --relative-to "$(pwd)")"
}

function _daily-coding.locate_file
{
    declare -r root_workspace_path="$(cd "$(dirname "$1")"/../.. && pwd)"
    declare -r base_workspace_name="$(cd "$(dirname "$1")"/.. && basename "$(pwd)")"
    declare -r base_collection_name="$(cd "$(dirname "$1")" && basename "$(pwd)")"
    declare -r base_file_name="$(basename "$1")"

    declare -r n=$2
    declare -r target_file_path="$(
        ls -1 "${root_workspace_path}"/*/"${base_collection_name}/${base_file_name}" |
            ([[ $n -ge 0 ]] && cat || tac) |
            sed -n "/${base_workspace_name}/,$ p" |
            sed -n "$((n < 0 ? -n+1 : n+1)) p"
    )"

    if [[ ! -f "${target_file_path}" ]]; then
        echo ''
    else
        echo "$(realpath "${target_file_path}" --relative-to "$(pwd)")"
    fi
}

function _daily-coding.locate_collection
{
    declare -r root_workspace_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)/workspace"
    declare -r base_collection_path="$(_daily-coding.to_collection_path "$1")"
    declare -r base_collection_name="$(_daily-coding.to_collection_name "$1")"
    declare -r base_workspace_name="$(_daily-coding.to_workspace_name "$1")"

    declare -r n=$2
    declare -r target_collection_path="$(
        ls -1d "${root_workspace_path}"/*/"${base_collection_name}" |
            ([[ $n -ge 0 ]] && cat || tac) |
            sed -n "/${base_workspace_name}\/${base_collection_name}/,$ p" |
            sed -n "$((n < 0 ? -n+1 : n+1)) p"
    )"

    if [[ ! -d "${target_collection_path}" ]]; then
        echo ''
    else
        echo "$(realpath "${target_collection_path}" --relative-to "$(pwd)")"
    fi
}

function _daily-coding.help
{
    if [[ ! $# -le 0 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r name="${FUNCNAME[1]}"

    cat <<EOS | sed -r 's/^ {8}//'
        NAME
            ${name}

        DESCRIPTION
            ${name} は日々のコーディング練習を支援する機能を提供します.

            日々作成するソースコードは以下のディレクトリ構成に従って保存します.

                <repository_path>/workspace/<workspace_name>/<collection_name>/

        WORDS
            ワークスペース
                <repository_path>/workspace/<workspace_name> のことです.

            コレクション
                <repository_path>/workspace/<workspace_name>/<collection_name>/ のことです.
                コレクションはワークスペース内をさらに分けるために作成します.

        SYNOPSIS
            ${name} --root
            ${name} cd --root
                リポジトリのルートディレクトリに移動します.

            ${name} [N]
            ${name} cd [N]
                今日を基準に N 個前後のワークスペースに移動します (デフォルトは N=0).
                N=0 の場合に限り, ディレクトリが存在しなければ作成します.

            ${name} commit [--amend]
                コレクションの名前で git commit します.
                カレントディレクトリがコレクションのディレクトリではない場合はエラーになります.

            ${name} diff FILE [N]
                別のワークスペースにあるファイルと比較します.

                別日のワークスペースから FILE と同一のファイルを探し,
                N 個前後のファイルと vimdiff によって比較します (デフォルトは N=-1).

            ${name} diff2 [N]
                別のワークスペースにあるコレクションと比較します.

                別日のワークスペースからカレントディレクトリと同一のコレクションを探し,
                N 個前後のコレクションと diff -q によって比較します (デフォルトは N=-1).

            ${name} help|--help|-h
                このコマンドの使い方を表示します.

            ${name} ls [-v|-vv]
                ワークスペースの一覧を表示します.
                -v を指定するとワークスペースの 1 階層下,
                -vv を指定するとワークスペースの 2 階層下を表示します.

            ${name} ls --collection
                コレクションの一覧を表示します.

            ${name} ls --language|--lang
                言語の一覧を表示します.

            ${name} ls --extension|--ext
                拡張子の一覧を表示します.

            ${name} random [N]
                過去に作成したコレクションからランダムに N 個表示します (デフォルトは N=1).
                現在のワークスペースに存在するコレクションは除外されます.
                カレントディレクトリがワークスペース外の場合は, 今日のワークスペースが基準となります.

            ${name} stats
            ${name} stats -v|--workspace
            ${name} stats -vv|--language|--lang
            ${name} stats -vvv|--extension|--ext
            ${name} stats -vvvv|--collection
            ${name} stats -vvvvv|--file
            ${name} stats -vvvvvv|--workspace-collection
                ソースコードの統計情報を表示します.
                オプションを指定しない場合, ワークスペースごとのコード行数を高速に表示します.
                オプションを指定する場合, 異なる軸で集計したソースコードの統計情報を表示します.

        EXAMPLES
            # ${name} の使い方を表示します.
            ${name} help

            # 今日のワークスペースに移動します.
            ${name} cd

            # 今日を基準に 1 個前のワークスペースに移動します.
            ${name} cd -1

            # ワークスペースの一覧を表示します.
            ${name} ls
            ${name} ls -v
            ${name} ls -vv

            # コレクションの一覧を表示します.
            ${name} ls -vvv

            # 別のワークスペースにあるファイルと比較します.
            ${name} diff FILE

            # 各ワークスペースに含まれるソースコードの行数を表示します.
            ${name} stats
            ${name} stats -v
            ${name} stats -vv
            ${name} stats -vvv
            ${name} stats -vvvv

            # 空メッセージで git commit します.
            ${name} commit
EOS
}

function _daily-coding.ls
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
    declare -r root_workspace_path="${repository_path}/workspace"

    case "${1:-}" in
        '')
            find "${root_workspace_path}" -mindepth 1 -maxdepth 1 -printf '%P\n' | sort
            ;;
        -v)
            find "${root_workspace_path}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
            ;;
        -vv)
            find "${root_workspace_path}" -mindepth 3 -maxdepth 3 -printf '%P\n' | sort
            ;;
        --collection)
            _daily-coding.stats.generate_jsonl | jq -sr '.[].collection' | sort -u
            return 0
            ;;
        --language | --lang)
            _daily-coding.stats.generate_jsonl | jq -sr '.[].language' | sort -u
            return 0
            ;;
        --extension | --ext)
            _daily-coding.stats.generate_jsonl | jq -sr '.[].extension' | sort -u
            return 0
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

function _daily-coding.random
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r n=${1:-1}
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"
    declare current_workspace_name="$(_daily-coding.to_workspace_name "$(pwd)")"
    declare current_workspace_path="$(_daily-coding.to_workspace_path "$(pwd)")"

    if [[ "${current_workspace_path}" == '' ]]; then
        declare current_workspace_name="$(date '+%Y-%m-%d')"
        declare current_workspace_path="${repository_path}/workspace/${current_workspace_name}"
    fi

    sort \
        <(find "${root_workspace_path}" -mindepth 2 -maxdepth 2 -type d -printf '%P\n' | cut -d/ -f2 | sort -u) \
        <(find "${current_workspace_path}" -mindepth 1 -maxdepth 1 -type d -printf '%P\n') \
        <(find "${current_workspace_path}" -mindepth 1 -maxdepth 1 -type d -printf '%P\n') \
        | uniq -u | shuf | head -${n}
}

function _daily-coding.stats
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    case "${1:-}" in
        '')
            # カレントシェルの作業ディレクトリを変更したくないのでサブシェルで実行する.
            (
                declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
                declare -r root_workspace_path="${repository_path}/workspace"

                cd "${root_workspace_path}"

                for path in *
                do
                    declare lines=$(find "${path}" -type f | xargs cat | wc -l)
                    echo "${path} ${lines} lines"
                done
            ) | column -t -R 2 -o ' '
            ;;
        -v | --workspace)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'workspace' '.workspace'
            ;;
        -vv | --language | --lang)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'language' '.language'
            ;;
        -vvv | --extension | --ext)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'extension' '.extension'
            ;;
        -vvvv | --collection)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'collection' '.collection'
            ;;
        -vvvvv | --file)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'file' '.file'
            ;;
        -vvvvvv | --workspace-collection)
            declare -r jsonl="$(_daily-coding.stats.generate_jsonl)"
            _daily-coding.stats.report "${jsonl}" 'workspace/collection' '.workspace + "/" + .collection'
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

function _daily-coding.stats.generate_jsonl
{
    declare -r repository_path="$(cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)"
    declare -r root_workspace_path="${repository_path}/workspace"

    (
        cd "${root_workspace_path}"

        while read lines path
        do
            path="${path#./}"
            declare workspace="${path%%/*}"
            path="${path#*/}"
            declare collection="${path%%/*}"
            declare language="${collection##*.}"
            path="${path#*/}"
            declare file="${path}"
            declare extension="$(_daily-coding.extname "${path}")"

            echo "{\"workspace\": \"${workspace}\", \"collection\": \"${collection}\", \"language\": \"${language}\", \"file\": \"${file}\", \"extension\": \"${extension}\", \"lines\": ${lines}}"
        done < <(find . -type f | sort | xargs wc -l | sed -r '/^ *[0-9]+ total$/d')
    )
}

function _daily-coding.stats.report
{
    declare -r jsonl="$1"
    declare -r group_key_name="$2"
    declare -r group_key_value="$3"

    declare -r jq_query="$(cat <<EOS
        (
            [
                "${group_key_name}",
                "workspaces",
                "collections",
                "languages",
                "files",
                "extensions",
                "lines"
            ]
        ),
        (
            map({
                "group_key"            : (${group_key_value}),
                "workspace_collection" : (.workspace + "/" + .collection)
                } + .)
            | group_by(.group_key)
            | map({
                "group_key"   : .[0].group_key,
                "workspaces"  : ([.[].workspace]            | unique | length),
                "collections" : ([.[].workspace_collection] | unique | length),
                "languages"   : ([.[].language]             | unique | length),
                "files"       : ([.[].file]                          | length),
                "extensions"  : ([.[].extension]            | unique | length),
                "lines"       : ([.[].lines]                         | add)})
            | sort_by(.group_key)
            | map([.[]])
            | .[]
        )
        ,
        (
            map({
                "group_key"            : "<entire>",
                "workspace_collection" : (.workspace + "/" + .collection)
                } + .)
            | group_by(.group_key)
            | map({
                "group_key"   : .[0].group_key,
                "workspaces"  : ([.[].workspace]            | unique | length),
                "collections" : ([.[].workspace_collection] | unique | length),
                "languages"   : ([.[].language]             | unique | length),
                "files"       : ([.[].file]                          | length),
                "extensions"  : ([.[].extension]            | unique | length),
                "lines"       : ([.[].lines]                         | add)})
            | sort_by(.group_key)
            | map([.[]])
            | .[]
        )
        | @tsv
EOS
)"

    echo "${jsonl}" \
        | jq -sr "${jq_query}" \
        | column -t -R 2,3,4,5,6,7
    echo
}

function _daily-coding.root_path
{
    (cd "$(dirname "${BASH_SOURCE}")"/../.. && pwd)
}

function _daily-coding.root_workspace_path
{
    echo "$(_daily-coding.root_path)/workspace"
}

function _daily-coding.to_workspace_path
{
    declare -r path="${1:-$(pwd)}"
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    if [[ "$(realpath "${path}" --relative-to "${root_workspace_path}")" != ../* ]]; then
        echo "${root_workspace_path}/$(echo "${path#${root_workspace_path}/}" | cut -d/ -f1)"
    else
        echo ''
    fi
}

function _daily-coding.to_workspace_name
{
    declare -r workspace_path="$(_daily-coding.to_workspace_path "${1:-$(pwd)}")"
    echo "${workspace_path##*/}"
}

function _daily-coding.to_collection_path
{
    declare -r path="${1:-$(pwd)}"
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"
    declare -r relative_path="$(realpath "${root_workspace_path}" --relative-to "${path}")"

    if [[ "${relative_path}" =~ ^..(/..)+$ ]]; then
        declare -r workspace_collection_name="$(
            realpath "${path}" --relative-base "${root_workspace_path}" | cut -d/ -f1,2)"
        echo "${root_workspace_path}/${workspace_collection_name}"
    else
        echo ''
    fi
}

function _daily-coding.to_collection_name
{
    declare -r collection_path="$(_daily-coding.to_collection_path "${1:-$(pwd)}")"
    echo "${collection_path##*/}"
}

