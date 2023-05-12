#!/bin/bash
#
# daily-coding.bashrc.sh のテスト.
#

set -eu -o errtrace
trap 'echo "Assertion failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

declare -r REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
declare -r TEST_DATA_DIR="${REPOSITORY_PATH}/target/workspace"

declare -r DAILY_CODING_ROOT_WORKSPACE_PATH="${TEST_DATA_DIR}"
source "${REPOSITORY_PATH}/src/main/daily-coding.bashrc"

function main
{
    declare -ar tests=(
        test._daily-coding.escape_regexp
        test._daily-coding.root_path
        test._daily-coding.root_workspace_path
        test._daily-coding.to_workspace_path
        test._daily-coding.to_workspace_name
        test._daily-coding.to_collection_path
        test._daily-coding.to_collection_name
        test._daily-coding.locate_file
        test._daily-coding.locate_collection
        test._daily-coding.locate_workspace
        test._daily-coding.cd
        test._daily-coding.commit
        test._daily-coding.diff
        test._daily-coding.help
        test._daily-coding.ls
        test._daily-coding.stats
    )

    for name in ${tests[@]}
    do
        setup
        echo $name
        $name
    done
}

function setup
{
    rm -rf "${TEST_DATA_DIR}"
    mkdir -p "${TEST_DATA_DIR}"

    # カレントディレクトリを TEST_DATA_DIR として各テストを実行する.
    cd "${TEST_DATA_DIR}"

    declare -ar directories=(
        2022-12-31
        2023-01-01
        2023-01-01/aaa
        2023-01-01/aaa/bbb
        2023-02-02
        2023-02-02/aaa
        2023-02-02/aaa/bbb
        $(date '+%Y-%m-%d')
        $(date '+%Y-%m-%d' --date '1 days ago')
        $(date '+%Y-%m-%d' --date '2 days ago')
    )

    mkdir -p "${directories[@]}"
}

function test._daily-coding.escape_regexp
{
    test "$(_daily-coding.escape_regexp '')" == ''
    test "$(_daily-coding.escape_regexp 'abcde')" == 'abcde'
    test "$(_daily-coding.escape_regexp 'ab*de')" == 'ab\*de'
    test "$(_daily-coding.escape_regexp ',[*^$()+?{|')" == '\,\[\*\^\$\(\)\+\?\{\|'
}

function test._daily-coding.root_path
{
    test "$(_daily-coding.root_path)" == "${REPOSITORY_PATH}"
}

function test._daily-coding.root_workspace_path
{
    test "$(_daily-coding.root_workspace_path)" == "${TEST_DATA_DIR}"
}

function test._daily-coding.to_workspace_path
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    test "${root_workspace_path}/no-such-workspace" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace")"

    test "${root_workspace_path}/2023-01-01" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-01-01/aaa")"
    test "${root_workspace_path}/2023-01-01" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-01-01/aaa/bbb")"

    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02")"
    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02/aaa")"
    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02/aaa/bbb")"

    test "${root_workspace_path}/2023-01-01" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-01-01")"
    test "${root_workspace_path}/2023-01-01" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-01-01/aaa")"
    test "${root_workspace_path}/2023-01-01" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-01-01/aaa/bbb")"

    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02")"
    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02/aaa")"
    test "${root_workspace_path}/2023-02-02" \
        = "$(_daily-coding.to_workspace_path "${root_workspace_path}/2023-02-02/aaa/bbb")"
}

function test._daily-coding.to_workspace_name
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    test "no-such-workspace" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/no-such-workspace")"

    test "2023-01-01" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-01-01")"
    test "2023-01-01" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-01-01/aaa")"
    test "2023-01-01" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-01-01/aaa/bbb")"

    test "2023-02-02" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-02-02")"
    test "2023-02-02" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-02-02/aaa")"
    test "2023-02-02" \
        = "$(_daily-coding.to_workspace_name "${root_workspace_path}/2023-02-02/aaa/bbb")"
}

function test._daily-coding.to_collection_path
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    test "${root_workspace_path}/1999-01-01/no-such-collection" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/1999-01-01/no-such-collection")"
    test "${root_workspace_path}/2023-01-01/no-such-collection" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-01-01/no-such-collection")"

    test "${root_workspace_path}/2023-01-01/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-01-01/aaa")"
    test "${root_workspace_path}/2023-01-01/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-01-01/aaa/bbb")"
    test "${root_workspace_path}/2023-01-01/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-01-01/aaa/bbb/ccc")"

    test "${root_workspace_path}/2023-02-02/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-02-02/aaa")"
    test "${root_workspace_path}/2023-02-02/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-02-02/aaa/bbb")"
    test "${root_workspace_path}/2023-02-02/aaa" \
        = "$(_daily-coding.to_collection_path "${root_workspace_path}/2023-02-02/aaa/bbb/ccc")"
}

function test._daily-coding.to_collection_name
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    test 'no-such-collection' \
        = "$(_daily-coding.to_collection_name "${root_workspace_path}/1999-01-01/no-such-collection")"
    test 'no-such-collection' \
        = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-01-01/no-such-collection")"

    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-01-01/aaa")"
    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-01-01/aaa/bbb")"
    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-01-01/aaa/bbb/ccc")"

    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-02-02/aaa")"
    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-02-02/aaa/bbb")"
    test 'aaa' = "$(_daily-coding.to_collection_name "${root_workspace_path}/2023-02-02/aaa/bbb/ccc")"
}

function test._daily-coding.locate_file
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
    test "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt" -2)" = '2022-01-08/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt" -1)" = '2022-01-09/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  0)" = '2022-01-10/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  1)" = '2022-01-11/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  2)" = '2022-01-12/aaa/file.txt'

    # 日付が連続しない場合.
    test "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt" -2)" = '2022-02-07/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt" -1)" = '2022-02-09/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  0)" = '2022-02-10/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  1)" = '2022-02-11/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  2)" = '2022-02-13/aaa/file.txt'

    # 全ての作業ディレクトリに同一のファイルが存在しない場合.
    test "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt" -2)" = '2022-03-06/aaa/file-1.txt'
    test "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt" -1)" = '2022-03-08/aaa/file-1.txt'
    test "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  0)" = '2022-03-10/aaa/file-1.txt'
    test "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  1)" = '2022-03-12/aaa/file-1.txt'
    test "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  2)" = '2022-03-14/aaa/file-1.txt'

    # 全ての作業ディレクトリに同一のディレクトリが存在しない場合.
    test "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt" -2)" = '2022-04-06/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt" -1)" = '2022-04-08/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  0)" = '2022-04-10/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  1)" = '2022-04-12/aaa/file.txt'
    test "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  2)" = '2022-04-14/aaa/file.txt'
}

function test._daily-coding.locate_collection
{
    rm -rf "${TEST_DATA_DIR}"
    mkdir -p "${TEST_DATA_DIR}"
    cd "${TEST_DATA_DIR}"

    declare -ar date_paths=(
        # 日付が連続する場合.
        '2023-01-08/aaa.scheme'
        '2023-01-09/aaa.scheme'
        '2023-01-10/aaa.scheme'
        '2023-01-11/aaa.scheme'
        '2023-01-12/aaa.scheme'

        # 日付が連続しない場合.
        '2023-02-05/aaa.scheme'
        '2023-02-08/aaa.scheme'
        '2023-02-10/aaa.scheme'
        '2023-02-12/aaa.scheme'
        '2023-02-15/aaa.scheme'

        # 当日のディレクトリが存在しない場合.
        '2023-03-07/aaa.scheme'
        '2023-03-09/aaa.scheme'
        '2023-03-11/aaa.scheme'
        '2023-03-13/aaa.scheme'
    )

    for date_path in "${date_paths[@]}"; do
        mkdir -p "${date_path}"
    done

    # 日付が連続する場合.
    test "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme' -2)" = '2023-01-08/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme' -1)" = '2023-01-09/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  0)" = '2023-01-10/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  1)" = '2023-01-11/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  2)" = '2023-01-12/aaa.scheme'

    # 日付が連続しない場合.
    test "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme' -2)" = '2023-02-05/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme' -1)" = '2023-02-08/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  0)" = '2023-02-10/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  1)" = '2023-02-12/aaa.scheme'
    test "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  2)" = '2023-02-15/aaa.scheme'

# TODO ディレクトリが存在しない場合に対応する.
#
#    # 当日のディレクトリが存在しない場合.
#    _daily-coding.locate_collection '2023-03-10/aaa.scheme' -2
#    test "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme' -2)" = '2023-03-07/aaa.scheme'
#    test "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme' -1)" = '2023-03-09/aaa.scheme'
#    test "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  0)" = '2023-03-10/aaa.scheme'
#    test "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  1)" = '2023-03-11/aaa.scheme'
#    test "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  2)" = '2023-03-13/aaa.scheme'
#
#    # n 番目のディレクトリが存在しない場合.
#    test ! "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme' -2)"
#    test ! "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme' -1)"
#    test   "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme'  0)" = '2023-01-01/aaa.scheme'
#    test   "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  0)" = '2023-12-31/aaa.scheme'
#    test ! "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  1)"
#    test ! "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  2)"
}

function test._daily-coding.locate_workspace
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
    test "$(_daily-coding.locate_workspace '2023-01-10' -2)" = '2023-01-08'
    test "$(_daily-coding.locate_workspace '2023-01-10' -1)" = '2023-01-09'
    test "$(_daily-coding.locate_workspace '2023-01-10'  0)" = '2023-01-10'
    test "$(_daily-coding.locate_workspace '2023-01-10'  1)" = '2023-01-11'
    test "$(_daily-coding.locate_workspace '2023-01-10'  2)" = '2023-01-12'

    # 日付が連続しない場合.
    test "$(_daily-coding.locate_workspace '2023-02-10' -2)" = '2023-02-05'
    test "$(_daily-coding.locate_workspace '2023-02-10' -1)" = '2023-02-08'
    test "$(_daily-coding.locate_workspace '2023-02-10'  0)" = '2023-02-10'
    test "$(_daily-coding.locate_workspace '2023-02-10'  1)" = '2023-02-12'
    test "$(_daily-coding.locate_workspace '2023-02-10'  2)" = '2023-02-15'

    # 当日のディレクトリが存在しない場合.
    test "$(_daily-coding.locate_workspace '2023-03-10' -2)" = '2023-03-07'
    test "$(_daily-coding.locate_workspace '2023-03-10' -1)" = '2023-03-09'
    test "$(_daily-coding.locate_workspace '2023-03-10'  0)" = '2023-03-10'
    test "$(_daily-coding.locate_workspace '2023-03-10'  1)" = '2023-03-11'
    test "$(_daily-coding.locate_workspace '2023-03-10'  2)" = '2023-03-13'

    # n 番目のディレクトリが存在しない場合.
    test ! "$(_daily-coding.locate_workspace '2023-01-01' -2)"
    test ! "$(_daily-coding.locate_workspace '2023-01-01' -1)"
    test   "$(_daily-coding.locate_workspace '2023-01-01'  0)" = '2023-01-01'
    test   "$(_daily-coding.locate_workspace '2023-12-31'  0)" = '2023-12-31'
    test ! "$(_daily-coding.locate_workspace '2023-12-31'  1)"
    test ! "$(_daily-coding.locate_workspace '2023-12-31'  2)"
}

function test._daily-coding.cd
{
    test "$(_daily-coding.cd --root > /dev/null && pwd)" = \
         "${REPOSITORY_PATH}"

    test "$(_daily-coding.cd > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/$(date '+%Y-%m-%d')"

    test "$(_daily-coding.cd -1 > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/$(date '+%Y-%m-%d' --date '1 days ago')"

    test "$(_daily-coding.cd -2 > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/$(date '+%Y-%m-%d' --date '2 days ago')"

    test "$(_daily-coding.cd 2022-12-31 > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/2022-12-31"

    test "$(_daily-coding.cd 2023-01-01 > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/2023-01-01"

    test "$(_daily-coding.cd aaa > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/2023-02-02/aaa"

    test "$(_daily-coding.cd aaa -1 > /dev/null && pwd)" = \
         "${TEST_DATA_DIR}/2023-01-01/aaa"

    # TODO コレクションが見つからない場合のテストを行う.
    #  * _daily-coding.cd aaa -2
    #  * _daily-coding.cd no-such-collection
}

function test._daily-coding.commit
{
    # TODO
    :
}

function test._daily-coding.diff
{
    # TODO
    :
}

function test._daily-coding.help
{
    test "$(_daily-coding.help)" != ''
}

function test._daily-coding.ls
{
    rm -rf "${TEST_DATA_DIR}"
    mkdir -p "${TEST_DATA_DIR}"
    cd "${TEST_DATA_DIR}"

    declare -ar files=(
        2020-01-01/aaa.c/main.c
        2020-01-01/bbb.scheme/main.scm
        2020-02-02/ccc.forth/main.fs
        2020-02-02/ddd.ruby/main.rb
        2020-02-02/eee.haskell/main.hs
        2020-03-03/fff.shell/main.sh
    )

    for file in ${files[@]}
    do
        mkdir -p "$(dirname "${file}")"
        touch "${file}"
    done

    test "$(_daily-coding.ls)" != ''
    test "$(_daily-coding.ls -v)" != ''
    test "$(_daily-coding.ls -vv)" != ''
    test "$(_daily-coding.ls -vvv 2>&1 || true)" = 'Invalid option: [-vvv]'
    test "$(_daily-coding.ls --collection)" != ''
    test "$(_daily-coding.ls --language)" != ''
    test "$(_daily-coding.ls --lang)" != ''
    test "$(_daily-coding.ls --extension)" != ''
    test "$(_daily-coding.ls --ext)" != ''
    test "$(_daily-coding.ls --no-such-option 2>&1 || true)" = 'Invalid option: [--no-such-option]'
}

function test._daily-coding.stats
{
    test "$(_daily-coding.stats)" != ''

    test "$(_daily-coding.stats -v)" != ''
    test "$(_daily-coding.stats --workspace)" != ''

    test "$(_daily-coding.stats -vv)" != ''
    test "$(_daily-coding.stats --language)" != ''
    test "$(_daily-coding.stats --lang)" != ''

    test "$(_daily-coding.stats -vvv)" != ''
    test "$(_daily-coding.stats --extension)" != ''
    test "$(_daily-coding.stats --ext)" != ''

    test "$(_daily-coding.stats -vvvv)" != ''
    test "$(_daily-coding.stats --collection)" != ''

    test "$(_daily-coding.stats -vvvvv)" != ''
    test "$(_daily-coding.stats --file)" != ''

    test "$(_daily-coding.stats -vvvvvv)" != ''
    test "$(_daily-coding.stats --workspace-collection)" != ''
}

main

