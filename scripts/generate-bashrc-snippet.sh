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
        declare -r file_path="\${root_dir}/functions/enter-daily-directory.sh"

        if [[ -f "\${file_path}" ]]; then
            source "\${file_path}"
        else
            echo "No such file: \${file_path}" >&2
        fi
    }
    _setup-daily-coding-functions
EOS

