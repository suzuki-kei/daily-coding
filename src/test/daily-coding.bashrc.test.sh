#!/bin/bash
#
# daily-coding.bashrc.sh のテスト.
#

set -eu -o errtrace
trap 'echo "Assertion failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

declare -r REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
declare -r TEST_DATA_DIR="${REPOSITORY_PATH}/target/workspace"

source "${REPOSITORY_PATH}/src/bashrc/daily-coding.bashrc"

function test._daily-coding.cd.optparse
{
    test "$(_daily-coding.cd.optparse)" = 'n=0'
    test "$(_daily-coding.cd.optparse 1)" = 'n=1'
    test "$(_daily-coding.cd.optparse -1)" = 'n=-1'
    test "$(_daily-coding.cd.optparse 2022-12-30)" = 'date_name=2022-12-30'
    test "$(_daily-coding.cd.optparse --root)" = '--root'
    test "$(_daily-coding.cd.optparse --root aaa 2>&1 || true)" = 'Invalid options: [--root aaa]'
}

function test._daily-coding._locate-file
{
    rm -rf "${TEST_DATA_DIR}"
    mkdir -p "${TEST_DATA_DIR}"
    cd "${TEST_DATA_DIR}"

    declare -ar files=(
        # 日付が連続する場合.
        '2022-01-08/aaa/file.txt'
        '2022-01-09/aaa/file.txt'
        '2022-01-10/aaa/file.txt'
        '2022-01-11/aaa/file.txt'
        '2022-01-12/aaa/file.txt'

        # 日付が連続しない場合.
        '2022-02-07/aaa/file.txt'
        '2022-02-09/aaa/file.txt'
        '2022-02-10/aaa/file.txt'
        '2022-02-11/aaa/file.txt'
        '2022-02-13/aaa/file.txt'

        # 全ての作業ディレクトリに同一のファイルが存在しない場合.
        '2022-03-06/aaa/file-1.txt'
        '2022-03-07/aaa/file-2.txt'
        '2022-03-08/aaa/file-1.txt'
        '2022-03-09/aaa/file-2.txt'
        '2022-03-10/aaa/file-1.txt'
        '2022-03-11/aaa/file-2.txt'
        '2022-03-12/aaa/file-1.txt'
        '2022-03-13/aaa/file-2.txt'
        '2022-03-14/aaa/file-1.txt'

        # 全ての作業ディレクトリに同一のディレクトリが存在しない場合.
        '2022-04-06/aaa/file.txt'
        '2022-04-07/bbb/file.txt'
        '2022-04-08/aaa/file.txt'
        '2022-04-09/bbb/file.txt'
        '2022-04-10/aaa/file.txt'
        '2022-04-11/bbb/file.txt'
        '2022-04-12/aaa/file.txt'
        '2022-04-13/bbb/file.txt'
        '2022-04-14/aaa/file.txt'
    )

    for file in "${files[@]}"; do
        mkdir -p "$(dirname "${file}")"
        touch "${file}"
    done

    # 日付が連続する場合.
    test "$(_daily-coding._locate-file "2022-01-10/aaa/file.txt" -2)" = '2022-01-08/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-01-10/aaa/file.txt" -1)" = '2022-01-09/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-01-10/aaa/file.txt"  0)" = '2022-01-10/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-01-10/aaa/file.txt"  1)" = '2022-01-11/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-01-10/aaa/file.txt"  2)" = '2022-01-12/aaa/file.txt'

    # 日付が連続しない場合.
    test "$(_daily-coding._locate-file "2022-02-10/aaa/file.txt" -2)" = '2022-02-07/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-02-10/aaa/file.txt" -1)" = '2022-02-09/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-02-10/aaa/file.txt"  0)" = '2022-02-10/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-02-10/aaa/file.txt"  1)" = '2022-02-11/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-02-10/aaa/file.txt"  2)" = '2022-02-13/aaa/file.txt'

    # 全ての作業ディレクトリに同一のファイルが存在しない場合.
    test "$(_daily-coding._locate-file "2022-03-10/aaa/file-1.txt" -2)" = '2022-03-06/aaa/file-1.txt'
    test "$(_daily-coding._locate-file "2022-03-10/aaa/file-1.txt" -1)" = '2022-03-08/aaa/file-1.txt'
    test "$(_daily-coding._locate-file "2022-03-10/aaa/file-1.txt"  0)" = '2022-03-10/aaa/file-1.txt'
    test "$(_daily-coding._locate-file "2022-03-10/aaa/file-1.txt"  1)" = '2022-03-12/aaa/file-1.txt'
    test "$(_daily-coding._locate-file "2022-03-10/aaa/file-1.txt"  2)" = '2022-03-14/aaa/file-1.txt'

    # 全ての作業ディレクトリに同一のディレクトリが存在しない場合.
    test "$(_daily-coding._locate-file "2022-04-10/aaa/file.txt" -2)" = '2022-04-06/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-04-10/aaa/file.txt" -1)" = '2022-04-08/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-04-10/aaa/file.txt"  0)" = '2022-04-10/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-04-10/aaa/file.txt"  1)" = '2022-04-12/aaa/file.txt'
    test "$(_daily-coding._locate-file "2022-04-10/aaa/file.txt"  2)" = '2022-04-14/aaa/file.txt'
}

test._daily-coding.cd.optparse
test._daily-coding._locate-file

