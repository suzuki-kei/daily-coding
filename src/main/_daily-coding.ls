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
            find "${root_workspace_path}" -mindepth 1 -maxdepth 1 -printf '%P\n' | sort
            ;;
        -v)
            find "${root_workspace_path}" -mindepth 2 -maxdepth 2 -printf '%P\n' | sort
            ;;
        -vv)
            find "${root_workspace_path}" -mindepth 3 -maxdepth 3 -printf '%P\n' | sort
            ;;
        --collection)
            _daily-coding.generate_jsonl | jq -sr '.[].collection' | sort -u
            return 0
            ;;
        --language | --lang)
            _daily-coding.generate_jsonl | jq -sr '.[].language' | sort -u
            return 0
            ;;
        --extension | --ext)
            _daily-coding.generate_jsonl | jq -sr '.[].extension' | sort -u
            return 0
            ;;
        *)
            echo "Invalid option: [$1]" >&2
            return 1
            ;;
    esac
}

