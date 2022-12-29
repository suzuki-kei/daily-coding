#!/bin/bash
#
# .bashrc に追加するコードを生成する.
#

set -eu

declare -r ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cat <<EOS | sed -r 's/^ {4}//'
    function _setup-daily-coding-functions
    {
        declare -r root_dir='${ROOT_DIR}'
        declare -r functions_dir="\${root_dir}/functions"

        for file in \$(find "\${functions_dir}" -type f -name '*.sh')
        do
            source "\${file}"
        done
    }
    _setup-daily-coding-functions
EOS

