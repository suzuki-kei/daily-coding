# daily-coding

## セットアップ手順

### bash function を登録する

.bashrc に以下を追加します.

    source /PATH-TO-REPOSITORY-DIR/bashrc/daily-coding.bashrc

## 各種手順

### daily-coding による操作

    # daily-coding の使い方を表示する.
    daily-coding help

    # 今日の作業ディレクトリに移動する.
    daily-coding cd

    # 昨日の作業ディレクトリに移動する.
    daily-coding cd -1

    # 各作業ディレクトリの直下に存在するファイルを表示する.
    daily-coding ls

    # 直近の同じ実装ファイルと比較する.
    daily-coding diff FILE

### 空メッセージで git commit する

    bash scripts/git-commit-with-empty-message.sh
    bash scripts/git-commit-with-empty-message.sh --amend

