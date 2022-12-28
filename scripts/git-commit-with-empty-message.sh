#!/bin/bash
#
# 空メッセージで git commit する.
#
# 使用例:
#     bash git-commit-with-empty-message.sh
#     bash git-commit-with-empty-message.sh --amend
#

set -eu

git commit --allow-empty-message --m '' "$@"

