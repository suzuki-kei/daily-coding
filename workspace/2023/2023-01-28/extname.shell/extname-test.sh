#!/bin/bash

declare -r ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${ROOT_DIR}/extname.sh"

set -eu -o errtrace
trap 'echo "Assertion failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

function test.extname
{
    test '.md' = "$(extname 'README.md')"
    test '.md' = "$(extname '/tmp/files/README.md')"
    test '.back' = "$(extname 'README.md.back')"
    test '.back' = "$(extname '/tmp/files/README.md.back')"

    test '.bashrc' = "$(extname '.bashrc')"
    test '.bashrc' = "$(extname '/tmp/files/.bashrc')"
    test '.back' = "$(extname '.bashrc.back')"
    test '.back' = "$(extname '/tmp/files/.bashrc.back')"

    test 'Makefile' = "$(extname 'Makefile')"
    test 'Makefile' = "$(extname '/tmp/files/Makefile')"
    test '.back' = "$(extname 'Makefile.back')"
    test '.back' = "$(extname '/tmp/files/Makefile.back')"
}

test.extname

