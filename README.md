# daily-coding

## セットアップ手順

### bash function を登録する

.bashrc に以下を追加します.

    source /PATH-TO-REPOSITORY-DIR/src/bashrc/daily-coding.bashrc

## daily-coding 自体の開発に関する操作手順

    # テストを実行する.
    make test

    # 作業ファイルを削除する.
    make clean

## daily-coding による操作方法

    # daily-coding の使い方を表示する.
    daily-coding help

    # 今日の作業ディレクトリに移動する.
    daily-coding cd

    # 昨日の作業ディレクトリに移動する.
    daily-coding cd -1

    # 各作業ディレクトリに含まれるコレクションを表示する.
    daily-coding ls

    # 直近の同じ実装ファイルと比較する.
    daily-coding diff FILE

    # 各作業ディレクトリに含まれるソースコードの行数を表示する.
    daily-coding stats
    daily-coding stats -v
    daily-coding stats -vv

    # 空メッセージで git commit する.
    daily-coding commit

