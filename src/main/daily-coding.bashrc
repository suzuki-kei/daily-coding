#!/bin/bash

shopt -s extglob

source "$(dirname "${BASH_SOURCE}")/_daily-coding._common"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.cd"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.commit"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.diff"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.help"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.ls"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.random"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.stats"

function daily-coding
{
    case "${1:-}" in
        cd | commit | diff | help | ls | random | stats)
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

function _daily-coding._bash_complete
{
    declare -r word="${COMP_WORDS[${COMP_CWORD}]}"

    case "${COMP_WORDS[1]}" in
        cd)
            if [[ ${COMP_CWORD} -le 2 ]]; then
                COMPREPLY=($(compgen -W '--root' -- "${word}"))
            fi
            ;;
        commit)
            if [[ ! "${COMP_WORDS[2]}" == '--amend' ]]; then
                COMPREPLY=($(compgen -W '--amend' -- "${word}"))
            fi
            ;;
        diff)
            if [[ ${COMP_CWORD} -le 2 ]]; then
                COMPREPLY=($(compgen -W "$(ls)" -- "${word}"))
            fi
            ;;
        help)
            # no-operation
            ;;
        ls)
            if [[ ${COMP_CWORD} -le 2 ]]; then
                COMPREPLY=($(compgen -W '-v -vv --collection --language --lang --extension --ext' -- "${word}"))
            fi
            ;;
        random)
            # no-operation
            ;;
        stats)
            if [[ ${COMP_CWORD} -le 2 ]]; then
                COMPREPLY=($(compgen -W '-v --workspace -vv --language --lang -vvv --extension --ext -vvvv --collection -vvvvv --file -vvvvvv --workspace-collection' -- "${word}"))
            fi
            ;;
        *)
            COMPREPLY=($(compgen -W 'cd commit diff help ls random stats' -- "${word}"))
            ;;
    esac
}
complete -F _daily-coding._bash_complete daily-coding

