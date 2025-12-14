#!/bin/bash

shopt -s extglob

source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.common"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.bash_complete"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.cd"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.commit"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.diff"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.help"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.ls"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.mkcd"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.push"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.random"
source "$(dirname "${BASH_SOURCE[0]}")/_daily-coding.sub-command.stats"

function daily-coding
{
    case "${1:-}" in
        cd | commit | diff | help | ls | mkcd | push | random | stats)
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

