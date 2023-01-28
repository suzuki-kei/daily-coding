#!/bin/bash

function _daily-coding.ls
{
    if [[ ! $# -le 1 ]]; then
        echo "Invalid options: [$@]" >&2
        return 1
    fi

    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    case "${1:-}" in
        '')
            _daily-coding.ls_by_depth 1
            ;;
        -v)
            _daily-coding.ls_by_depth 2
            ;;
        -vv)
            _daily-coding.ls_by_depth 3
            ;;
        --collection)
            _daily-coding.ls_by_column 'collection'
            return 0
            ;;
        --language | --lang)
            _daily-coding.ls_by_column 'language'
            return 0
            ;;
        --extension | --ext)
            _daily-coding.ls_by_column 'extension'
            return 0
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

function _daily-coding.ls_by_depth
{
    declare -r depth="$1"
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    find "${root_workspace_path}" -mindepth ${depth} -maxdepth ${depth} -printf '%P\n' | sort
}

function _daily-coding.ls_by_column
{
    declare -r target="$1"

    _daily-coding.generate_jsonl | jq -sr "
        [group_by(.${target}) | .[] | [.[0].${target}, ([.[].workspace] | max)]]
            | sort_by(.[1]) | .[] | @tsv
    " | column -t
}

