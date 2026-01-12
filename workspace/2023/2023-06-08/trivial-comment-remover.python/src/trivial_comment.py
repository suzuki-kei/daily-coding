import re
import textwrap
import typing


_TRIVIAL_COMMENTS = tuple(filter(None, textwrap.dedent("""
    # インポート
    # 関数を定義
    # x に 1 を代入
    # 直接実行された場合に "__main__" になる
""").splitlines()))


def _pattern_from_comments(comments: typing.Iterable[str]) -> tuple[re.Pattern]:
    escaped_comments = [f"\n?[ \t]*{re.escape(comment)}$" for comment in comments]
    return re.compile("|".join(escaped_comments), re.MULTILINE)


class TrivialCommentRemover(object):
    """
        自明なコメントを削除する機能を提供します.
    """

    def __init__(self, trivial_comments: typing.Iterable[str] = _TRIVIAL_COMMENTS):
        """
            削除対象のコメントを指定してインスタンスを初期化します.

            Arguments
            ---------
            trivial_comments: typing.Iterable[str]
                削除対象のコメント.
        """
        self._pattern = _pattern_from_comments(trivial_comments)

    def remove(self, code: str) -> str:
        return self._pattern.sub("", code)

