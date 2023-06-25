#!/bin/bash

set -eu

function main
{
demonstration <<EOS
aaa
    bbb
ccc
EOS

demonstration <<EOS
    aaa
        bbb
    ccc
EOS

demonstration <<EOS
        aaa
            bbb
        ccc
EOS
}

function strip_heredoc
{
    declare -r text="$(cat)"
    declare -r prefix="$(echo "${text}" | sed -r 's/^( *).*$/\1/' | sort | head -1)"
    echo "${text}" | sed "s/^${prefix}//"
}

function demonstration
{
    declare -r text="$(cat)"

    echo '============================================================'
    echo "$text"
    echo '------------------------------------------------------------'
    echo "$text" | strip_heredoc
    echo '============================================================'
    echo
}

main "$@"

