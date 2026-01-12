#!/bin/bash

set -eu

function main
{
    demonstration < <(echo -n '')
    demonstration < <(echo -n 'a')
    demonstration < <(echo -n '    a')

    demonstration < <(echo '')
    demonstration < <(echo 'a')
    demonstration < <(echo '    a')

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
    IFS= read -rd '' text < <(cat) || true
    declare -r prefix="$(echo -n "${text}" | sed -r -e '/^$/d' -e 's/^( *).*$/\1/' | sort | head -1)"
    echo -n "${text}" | sed "s/^${prefix}//"
}

function demonstration
{
    echo '============================================================'
    {
        declare -r file='a.txt'
        cat > "${file}"
        cat "${file}"
        echo '--------------------------------------------------------'
        strip_heredoc <"${file}"
        echo '--------------------------------------------------------'
    } | sed 's/^/    /'

    echo "============================================================"
    echo
}

main

