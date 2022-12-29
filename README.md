# daily-coding

## セットアップ手順

### bash function を登録する

.bashrc に以下を追加します.

    # in .bashrc
    source /PATH-TO-REPOSITORY-DIR/functions/enter-daily-directory.sh
    source /PATH-TO-REPOSITORY-DIR/functions/list.sh

.bashrc に追加するコードは以下のスクリプトで生成できます.

    bash scripts/generate-bashrc-snippet.sh

## 各種手順

### 日別のディレクトリに移動する

    # 当日のディレクトリに移動する.
    daily-coding.enter-daily-directory

    # 1 日前のディレクトリに移動する.
    daily-coding.enter-daily-directory -1

    # 日別ディレクトリの直下にあるファイルを一覧表示する.
    daily-coding.list

### 空メッセージで git commit する

    bash scripts/git-commit-with-empty-message.sh
    bash scripts/git-commit-with-empty-message.sh --amend

