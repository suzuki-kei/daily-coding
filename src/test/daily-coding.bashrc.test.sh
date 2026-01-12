#!/bin/bash
#
# daily-coding.bashrc のテスト.
#

set -eu -o errtrace
trap 'echo "Assertion failed at line ${LINENO}: ${BASH_COMMAND}"' ERR

declare -r REPOSITORY_PATH="$(cd "$(dirname "$0")/../.." && pwd)"
declare -r TEST_DATA_DIR="${REPOSITORY_PATH}/target/workspace"

declare -r DAILY_CODING_ROOT_WORKSPACE_PATH="${TEST_DATA_DIR}"
source -- "${REPOSITORY_PATH}/src/main/daily-coding.bashrc"

function assert_equal
{
    declare -r expected="$1"
    declare -r actual="$2"

    if [[ "${expected}" != "${actual}" ]]; then
        echo "Assertion failed at line ${BASH_LINENO[0]}:"
        echo "    expected: ${expected}"
        echo "      actual: ${actual}"
    fi
}

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
        echo "==== ${name}"
        $name
    done
}

function setup
{
    rm -rf -- "${TEST_DATA_DIR}"
    mkdir -p -- "${TEST_DATA_DIR}"

    # TEST_DATA_DIR をカレントディレクトリとして各テストを実行する.
    cd -- "${TEST_DATA_DIR}"

    declare -ar file_paths=(
        "2022-12-31/quick-sort.c/README.md"
        "2022-12-31/quick-sort.c/partition-2way/Makefile"
        "2022-12-31/quick-sort.c/partition-2way/main.c"
        "2022-12-31/quick-sort.c/partition-3way/Makefile"
        "2022-12-31/quick-sort.c/partition-3way/main.c"
        "2023-01-01/binary-search.cpp/Makefile"
        "2023-01-01/binary-search.cpp/main.cpp"
        "2023-02-02/numerical-sequence.force/Makefile"
        "2023-02-02/numerical-sequence.force/main.fs"
        "2023-02-02/numerical-sequence.force/factorial.fs"
        "2023-02-02/numerical-sequence.force/fibonacci.fs"
        "2023-02-02/numerical-sequence.force/fizz-buzz.fs"
        "2025-10-10/merge-sort.scm/Makefile"
        "2025-10-10/merge-sort.scm/main.scm"
        "2025-10-10/quick-sort.c/Makefile"
        "2025-10-10/quick-sort.c/main.c"
        "2025-11-11/bit-count.c/Makefile"
        "2025-11-11/bit-count.c/main.c"
        "2025-11-11/binary-search.ruby/Makefile"
        "2025-11-11/binary-search.ruby/main.rb"
        "2025-12-12/fizz-buzz.shell/Makefile"
        "2025-12-12/fizz-buzz.shell/main.sh"
        "2025-12-12/fizz-buzz.shell/fizz-buzz.sed"
        "$(date --date '2 days ago' '+%Y-%m-%d')/cat.brainfuck/Makefile"
        "$(date --date '2 days ago' '+%Y-%m-%d')/cat.brainfuck/cat.b"
        "$(date --date '1 days ago' '+%Y-%m-%d')/cat.brainfuck/Makefile"
        "$(date --date '1 days ago' '+%Y-%m-%d')/cat.brainfuck/cat.b"
        "$(date --date '0 days ago' '+%Y-%m-%d')/cat.brainfuck/Makefile"
        "$(date --date '0 days ago' '+%Y-%m-%d')/cat.brainfuck/cat.b"
    )

    for file_path in "${file_paths[@]}"
    do
        mkdir -p -- "$(dirname -- "${file_path}")"
        touch -- "${file_path}"
    done
}

function test._daily-coding.escape_regexp
{
    assert_equal '' \
                 "$(_daily-coding.escape_regexp '')"
    assert_equal 'abcde' \
                 "$(_daily-coding.escape_regexp 'abcde')"
    assert_equal 'ab\*de' \
                 "$(_daily-coding.escape_regexp 'ab*de')"
    assert_equal '\,\[\*\^\$\(\)\+\?\{\|' \
                 "$(_daily-coding.escape_regexp ',[*^$()+?{|')"
}

function test._daily-coding.root_path
{
    assert_equal "${REPOSITORY_PATH}" \
                 "$(_daily-coding.root_path)"
}

function test._daily-coding.root_workspace_path
{
    assert_equal "${TEST_DATA_DIR}" \
                 "$(_daily-coding.root_workspace_path)"
}

function test._daily-coding.to_workspace_path
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    # root_workspace_path 外のパス
    assert_equal '' \
                 "$(_daily-coding.to_workspace_path '/out-of-workspace-root')"

    # root_workspace_path 内の存在しないパス
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/README.md")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-2way")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-2way/Makefile")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-2way/main.c")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-3way")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-3way/Makefile")"
    assert_equal "${root_workspace_path}/no-such-workspace" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/no-such-workspace/partition-3way/main.c")"

    # root_workspace_path 内の存在するパス
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/README.md")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-2way")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-2way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-2way/main.c")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-3way")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-3way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31" \
                 "$(_daily-coding.to_workspace_path "${root_workspace_path}/2022-12-31/partition-3way/main.c")"
}

function test._daily-coding.to_workspace_name
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    # root_workspace_path 外のパス
    assert_equal '' \
                 "$(_daily-coding.to_workspace_name '/out-of-workspace-root')"

    # root_workspace_path 内の存在しないパス
    assert_equal 'no-such-workspace' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/no-such-workspace")"

    # root_workspace_path 内の存在するパス
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/README.md")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-2way")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-2way/Makefile")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-2way/main.c")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-3way")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-3way/Makefile")"
    assert_equal '2022-12-31' \
                 "$(_daily-coding.to_workspace_name "${root_workspace_path}/2022-12-31/partition-3way/main.c")"
}

function test._daily-coding.to_collection_path
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    # root_workspace_path 外のパス
    assert_equal '' \
                 "$(_daily-coding.to_collection_path '/out-of-workspace-root')"

    # root_workspace_path 内の collection ではないパス
    assert_equal '' \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}")"
    assert_equal '' \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31")"

    # 存在する workspace 内の存在しない collection 以下のパス
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/README.md")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way/main.c")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31/no-such-collection" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way/main.c")"

    # 存在する collection 以下のパス
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/README.md")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way/main.c")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way/Makefile")"
    assert_equal "${root_workspace_path}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.to_collection_path "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way/main.c")"
}

function test._daily-coding.to_collection_name
{
    declare -r root_workspace_path="$(_daily-coding.root_workspace_path)"

    # root_workspace_path 外のパス
    assert_equal '' \
                 "$(_daily-coding.to_collection_name '/out-of-workspace-root')"

    # root_workspace_path 内の collection ではないパス
    assert_equal '' \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}")"
    assert_equal '' \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31")"

    # 存在する workspace 内の存在しない collection 以下のパス
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/README.md")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way/Makefile")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-2way/main.c")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way/Makefile")"
    assert_equal "no-such-collection" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/no-such-collection/partition-3way/main.c")"

    # 存在する collection 以下のパス
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/README.md")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way/Makefile")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-2way/main.c")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way/Makefile")"
    assert_equal "quick-sort.c" \
                 "$(_daily-coding.to_collection_name "${root_workspace_path}/2022-12-31/quick-sort.c/partition-3way/main.c")"
}

function test._daily-coding.locate_file
{
    rm -rf -- "${TEST_DATA_DIR}"
    mkdir -p -- "${TEST_DATA_DIR}"
    cd -- "${TEST_DATA_DIR}"

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

    for file in "${files[@]}"
    do
        mkdir -p -- "$(dirname -- "${file}")"
        touch -- "${file}"
    done

    # 空文字列は無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_file '' 0)"

    # コレクション内のファイル以外のパスは無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_file '2022-01-10' 0)"
    assert_equal '' \
                 "$(_daily-coding.locate_file '2022-01-10/aaa' 0)"
    assert_equal '' \
                 "$(_daily-coding.locate_file '/out-of-workspace' 0)"

    # 日付が連続する場合.
    assert_equal '2022-01-08/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt" -2)"
    assert_equal '2022-01-09/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt" -1)"
    assert_equal '2022-01-10/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  0)"
    assert_equal '2022-01-11/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  1)"
    assert_equal '2022-01-12/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-01-10/aaa/file.txt"  2)"

    # 日付が連続しない場合.
    assert_equal '2022-02-07/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt" -2)"
    assert_equal '2022-02-09/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt" -1)"
    assert_equal '2022-02-10/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  0)"
    assert_equal '2022-02-11/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  1)"
    assert_equal '2022-02-13/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-02-10/aaa/file.txt"  2)"

    # 全ての作業ディレクトリに同一のファイルが存在しない場合.
    assert_equal '2022-03-06/aaa/file-1.txt' \
                 "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt" -2)"
    assert_equal '2022-03-08/aaa/file-1.txt' \
                 "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt" -1)"
    assert_equal '2022-03-10/aaa/file-1.txt' \
                 "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  0)"
    assert_equal '2022-03-12/aaa/file-1.txt' \
                 "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  1)"
    assert_equal '2022-03-14/aaa/file-1.txt' \
                 "$(_daily-coding.locate_file "2022-03-10/aaa/file-1.txt"  2)"

    # 全ての作業ディレクトリに同一のディレクトリが存在しない場合.
    assert_equal '2022-04-06/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt" -2)"
    assert_equal '2022-04-08/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt" -1)"
    assert_equal '2022-04-10/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  0)"
    assert_equal '2022-04-12/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  1)"
    assert_equal '2022-04-14/aaa/file.txt' \
                 "$(_daily-coding.locate_file "2022-04-10/aaa/file.txt"  2)"
}

function test._daily-coding.locate_collection
{
    rm -rf -- "${TEST_DATA_DIR}"
    mkdir -p -- "${TEST_DATA_DIR}"
    cd -- "${TEST_DATA_DIR}"

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

    for date_path in "${date_paths[@]}"
    do
        mkdir -p -- "${date_path}"
    done

    # 空文字列は無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_collection '' 0)"

    # ワークスペース内のコレクション以外のパスは無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_collection '2022-01-10' 0)"
    assert_equal '' \
                 "$(_daily-coding.locate_collection '/out-of-collection' 0)"

    # 日付が連続する場合.
    assert_equal '2023-01-08/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme' -2)"
    assert_equal '2023-01-09/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme' -1)"
    assert_equal '2023-01-10/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  0)"
    assert_equal '2023-01-11/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  1)"
    assert_equal '2023-01-12/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-01-10/aaa.scheme'  2)"

    # 日付が連続しない場合.
    assert_equal '2023-02-05/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme' -2)"
    assert_equal '2023-02-08/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme' -1)"
    assert_equal '2023-02-10/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  0)"
    assert_equal '2023-02-12/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  1)"
    assert_equal '2023-02-15/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-02-10/aaa.scheme'  2)"

   # 当日のディレクトリが存在しない場合.
   assert_equal '2023-03-07/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme' -2)"
   assert_equal '2023-03-09/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme' -1)"
   assert_equal '2023-03-10/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  0)"
   assert_equal '2023-03-11/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  1)"
   assert_equal '2023-03-13/aaa.scheme' \
                 "$(_daily-coding.locate_collection '2023-03-10/aaa.scheme'  2)"

   # n 番目のディレクトリが存在しない場合.
   assert_equal '' \
                "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme' -2)"
   assert_equal '' \
                "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme' -1)"
   assert_equal '2023-01-01/aaa.scheme' \
                "$(_daily-coding.locate_collection '2023-01-01/aaa.scheme'  0)"
   assert_equal '2023-12-31/aaa.scheme' \
                "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  0)"
   assert_equal '' \
                "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  1)"
   assert_equal '' \
                "$(_daily-coding.locate_collection '2023-12-31/aaa.scheme'  2)"
}

function test._daily-coding.locate_workspace
{
    rm -rf -- "${TEST_DATA_DIR}"
    mkdir -p -- "${TEST_DATA_DIR}"
    cd -- "${TEST_DATA_DIR}"

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

    for date_path in "${date_paths[@]}"
    do
        mkdir -p -- "${date_path}"
    done

    # 空文字列は無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '' 0)"

    # ワークスペース外のパスは無効値.
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '/out-of-workspace' 0)"

    # 日付が連続する場合.
    assert_equal '2023-01-08' \
                 "$(_daily-coding.locate_workspace '2023-01-10' -2)"
    assert_equal '2023-01-09' \
                 "$(_daily-coding.locate_workspace '2023-01-10' -1)"
    assert_equal '2023-01-10' \
                 "$(_daily-coding.locate_workspace '2023-01-10'  0)"
    assert_equal '2023-01-11' \
                 "$(_daily-coding.locate_workspace '2023-01-10'  1)"
    assert_equal '2023-01-12' \
                 "$(_daily-coding.locate_workspace '2023-01-10'  2)"

    # 日付が連続しない場合.
    assert_equal '2023-02-05' \
                 "$(_daily-coding.locate_workspace '2023-02-10' -2)"
    assert_equal '2023-02-08' \
                 "$(_daily-coding.locate_workspace '2023-02-10' -1)"
    assert_equal '2023-02-10' \
                 "$(_daily-coding.locate_workspace '2023-02-10'  0)"
    assert_equal '2023-02-12' \
                 "$(_daily-coding.locate_workspace '2023-02-10'  1)"
    assert_equal '2023-02-15' \
                 "$(_daily-coding.locate_workspace '2023-02-10'  2)"

    # 当日のディレクトリが存在しない場合.
    assert_equal '2023-03-07' \
                 "$(_daily-coding.locate_workspace '2023-03-10' -2)"
    assert_equal '2023-03-09' \
                 "$(_daily-coding.locate_workspace '2023-03-10' -1)"
    assert_equal '2023-03-10' \
                 "$(_daily-coding.locate_workspace '2023-03-10'  0)"
    assert_equal '2023-03-11' \
                 "$(_daily-coding.locate_workspace '2023-03-10'  1)"
    assert_equal '2023-03-13' \
                 "$(_daily-coding.locate_workspace '2023-03-10'  2)"

    # n 番目のディレクトリが存在しない場合.
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '2023-01-01' -2)"
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '2023-01-01' -1)"
    assert_equal '2023-01-01' \
                 "$(_daily-coding.locate_workspace '2023-01-01'  0)"
    assert_equal '2023-12-31' \
                 "$(_daily-coding.locate_workspace '2023-12-31'  0)"
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '2023-12-31'  1)"
    assert_equal '' \
                 "$(_daily-coding.locate_workspace '2023-12-31'  2)"
}

function test._daily-coding.cd
{
    # ルートに移動する
    assert_equal "${REPOSITORY_PATH}" \
                 "$(_daily-coding.cd --root > /dev/null && pwd)"

    # ワークスペースを指定しない
    assert_equal "${TEST_DATA_DIR}/$(date '+%Y-%m-%d')" \
                 "$(_daily-coding.cd > /dev/null && pwd)"
    assert_equal "${TEST_DATA_DIR}/$(date '+%Y-%m-%d' --date '1 days ago')" \
                 "$(_daily-coding.cd -1 > /dev/null && pwd)"
    assert_equal "${TEST_DATA_DIR}/$(date '+%Y-%m-%d' --date '2 days ago')" \
                 "$(_daily-coding.cd -2 > /dev/null && pwd)"

    # ワークスペースを指定する
    assert_equal "${TEST_DATA_DIR}/2022-12-31" \
                 "$(_daily-coding.cd 2022-12-31 > /dev/null && pwd)"
    assert_equal "${TEST_DATA_DIR}/2023-01-01" \
                 "$(_daily-coding.cd 2023-01-01 > /dev/null && pwd)"
    assert_equal "${TEST_DATA_DIR}/2023-02-02" \
                 "$(_daily-coding.cd 2023-02-02 > /dev/null && pwd)"

    # コレクションを指定する
    assert_equal "${TEST_DATA_DIR}/2025-10-10/quick-sort.c" \
                 "$(_daily-coding.cd quick-sort.c > /dev/null && pwd)"
    assert_equal "${TEST_DATA_DIR}/2022-12-31/quick-sort.c" \
                 "$(_daily-coding.cd quick-sort.c -1 > /dev/null && pwd)"

    # 存在しないコレクションを指定する
    assert_equal 'Not found' \
                 "$(_daily-coding.cd no-such-collection 2>&1 || true)"
    assert_equal 'Not found' \
                 "$(_daily-coding.cd no-such-collection -1 2>&1 || true)"
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
    # 正常系: エラーにならないことだけを確認する.
    _daily-coding.help > /dev/null
}

function test._daily-coding.ls
{
    # 正常系: エラーにならないことだけを確認する.
    _daily-coding.ls > /dev/null
    _daily-coding.ls -v > /dev/null
    _daily-coding.ls -vv > /dev/null
    _daily-coding.ls --collection > /dev/null
    _daily-coding.ls --language > /dev/null

    # 異常系
    assert_equal 'Invalid option: [--no-such-option]' \
                 "$(_daily-coding.ls --no-such-option 2>&1 || true)"
}

function test._daily-coding.stats
{
    # 正常系: エラーにならないことだけを確認する.
    _daily-coding.stats > /dev/null
    _daily-coding.stats -w > /dev/null
    _daily-coding.stats --workspace > /dev/null
    _daily-coding.stats -d > /dev/null
    _daily-coding.stats --daily > /dev/null
    _daily-coding.stats -m > /dev/null
    _daily-coding.stats --monthly > /dev/null
    _daily-coding.stats -y > /dev/null
    _daily-coding.stats --yearly > /dev/null
    _daily-coding.stats -l > /dev/null
    _daily-coding.stats --language > /dev/null

    # 異常系
    assert_equal 'Invalid option: [--no-such-option]' \
                 "$(_daily-coding.stats --no-such-option 2>&1 || true)"
}

main

