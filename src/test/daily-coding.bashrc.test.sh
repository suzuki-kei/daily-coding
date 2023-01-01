#!/bin/bash
#
# daily-coding.bashrc.sh のテスト.
#

set -eu -o errtrace
trap 'echo "Assertion failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

declare -r REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
declare -r TEST_DATA_DIR="${REPOSITORY_PATH}/target/workspace"

source "${REPOSITORY_PATH}/src/bashrc/daily-coding.bashrc"

function test._daily-coding.locate-date_path
{
    rm -rf "${TEST_DATA_DIR}"
    mkdir -p "${TEST_DATA_DIR}"
    cd "${TEST_DATA_DIR}"

    declare -ar date_paths=(
        # 日付が連続する場合.
        '2023-01-08'
        '2023-01-09'
        '2023-01-10'
        '2023-01-11'
        '2023-01-12'

        # 日付が連続しない場合.
        '2023-02-05'
        '2023-02-08'
        '2023-02-10'
        '2023-02-12'
        '2023-02-15'

        # 当日のディレクトリが存在しない場合.
        '2023-03-07'
        '2023-03-09'
        '2023-03-11'
        '2023-03-13'
    )

    for date_path in "${date_paths[@]}"; do
        mkdir -p "${date_path}"
    done

    # 日付が連続する場合.
    test "$(_daily-coding.locate-date_path '2023-01-10' -2)" = '2023-01-08'
    test "$(_daily-coding.locate-date_path '2023-01-10' -1)" = '2023-01-09'
    test "$(_daily-coding.locate-date_path '2023-01-10'  0)" = '2023-01-10'
    test "$(_daily-coding.locate-date_path '2023-01-10'  1)" = '2023-01-11'
    test "$(_daily-coding.locate-date_path '2023-01-10'  2)" = '2023-01-12'

    # 日付が連続しない場合.
    test "$(_daily-coding.locate-date_path '2023-02-10' -2)" = '2023-02-05'
    test "$(_daily-coding.locate-date_path '2023-02-10' -1)" = '2023-02-08'
    test "$(_daily-coding.locate-date_path '2023-02-10'  0)" = '2023-02-10'
    test "$(_daily-coding.locate-date_path '2023-02-10'  1)" = '2023-02-12'
    test "$(_daily-coding.locate-date_path '2023-02-10'  2)" = '2023-02-15'

    # 当日のディレクトリが存在しない場合.
    test "$(_daily-coding.locate-date_path '2023-03-10' -2)" = '2023-03-07'
    test "$(_daily-coding.locate-date_path '2023-03-10' -1)" = '2023-03-09'
    test "$(_daily-coding.locate-date_path '2023-03-10'  0)" = '2023-03-10'
    test "$(_daily-coding.locate-date_path '2023-03-10'  1)" = '2023-03-11'
    test "$(_daily-coding.locate-date_path '2023-03-10'  2)" = '2023-03-13'

    # n 番目のディレクトリが存在しない場合.
    test ! "$(_daily-coding.locate-date_path '2023-01-01' -2)"
    test ! "$(_daily-coding.locate-date_path '2023-01-01' -1)"
    test   "$(_daily-coding.locate-date_path '2023-01-01'  0)" = '2023-01-01'
    test   "$(_daily-coding.locate-date_path '2023-12-31'  0)" = '2023-12-31'
    test ! "$(_daily-coding.locate-date_path '2023-12-31'  1)"
    test ! "$(_daily-coding.locate-date_path '2023-12-31'  2)"
}

function test._daily-coding.locate-file
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
    test "$(_daily-coding.locate-file "2022-01-10/aaa/file.txt" -2)" = '2022-01-08/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-01-10/aaa/file.txt" -1)" = '2022-01-09/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-01-10/aaa/file.txt"  0)" = '2022-01-10/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-01-10/aaa/file.txt"  1)" = '2022-01-11/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-01-10/aaa/file.txt"  2)" = '2022-01-12/aaa/file.txt'

    # 日付が連続しない場合.
    test "$(_daily-coding.locate-file "2022-02-10/aaa/file.txt" -2)" = '2022-02-07/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-02-10/aaa/file.txt" -1)" = '2022-02-09/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-02-10/aaa/file.txt"  0)" = '2022-02-10/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-02-10/aaa/file.txt"  1)" = '2022-02-11/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-02-10/aaa/file.txt"  2)" = '2022-02-13/aaa/file.txt'

    # 全ての作業ディレクトリに同一のファイルが存在しない場合.
    test "$(_daily-coding.locate-file "2022-03-10/aaa/file-1.txt" -2)" = '2022-03-06/aaa/file-1.txt'
    test "$(_daily-coding.locate-file "2022-03-10/aaa/file-1.txt" -1)" = '2022-03-08/aaa/file-1.txt'
    test "$(_daily-coding.locate-file "2022-03-10/aaa/file-1.txt"  0)" = '2022-03-10/aaa/file-1.txt'
    test "$(_daily-coding.locate-file "2022-03-10/aaa/file-1.txt"  1)" = '2022-03-12/aaa/file-1.txt'
    test "$(_daily-coding.locate-file "2022-03-10/aaa/file-1.txt"  2)" = '2022-03-14/aaa/file-1.txt'

    # 全ての作業ディレクトリに同一のディレクトリが存在しない場合.
    test "$(_daily-coding.locate-file "2022-04-10/aaa/file.txt" -2)" = '2022-04-06/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-04-10/aaa/file.txt" -1)" = '2022-04-08/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-04-10/aaa/file.txt"  0)" = '2022-04-10/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-04-10/aaa/file.txt"  1)" = '2022-04-12/aaa/file.txt'
    test "$(_daily-coding.locate-file "2022-04-10/aaa/file.txt"  2)" = '2022-04-14/aaa/file.txt'
}

test._daily-coding.locate-file
test._daily-coding.locate-date_path

