#!/bin/bash

shopt -s extglob

source "$(dirname "${BASH_SOURCE}")/_daily-coding._common"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.cd"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.commit"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.diff"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.diff2"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.help"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.ls"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.random"
source "$(dirname "${BASH_SOURCE}")/_daily-coding.stats"

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

