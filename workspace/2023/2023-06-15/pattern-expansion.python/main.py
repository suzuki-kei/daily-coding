import re
import typing


def expand_pattern(template: str) -> typing.Generator[str, None, None]:
    """
        文字列中の "[1-3]" や "[A,B,C]" などのパターンを展開する.

        パターンを展開して得られる文字列の全ての組み合わせ順番に生成する.

        Arguments
        ---------
        template: str
            "[1-3]" や "[A,B,C]" などのパターンを含むテンプレート文字列.

        Yields
        ------
        str
            パターンを展開して生成した文字列.

        Examples
        --------
        >>> for text in expand_pattern("file-[1-3].txt"): print(text)
        file-1.txt
        file-2.txt
        file-3.txt
        >>> for text in expand_pattern("file-[A,C,E].txt"): print(text)
        file-A.txt
        file-C.txt
        file-E.txt
    """
    # "[1-3]" などの数値の範囲を展開する.
    if match := re.compile(r"\[(\d+)-(\d+)\]").search(template):
        min = int(match.group(1))
        max = int(match.group(2))
        for n in range(min, max + 1):
            yield from expand_pattern(f"{template[:match.start()]}{n}{template[match.end():]}")
        return

    # "[A,B,C]" などの列挙された値を展開する.
    if match := re.compile(r"\[(\w+(?:,\w+)*)\]").search(template):
        for s in match.group(1).split(","):
            yield from expand_pattern(f"{template[:match.start()]}{s}{template[match.end():]}")
        return

    yield template


def main():
    template = "file-[1-3].txt"
    print(f"==== template={template}")
    for text in expand_pattern(template):
        print(text)

    template = "file-[A,C,E].txt"
    print(f"==== template={template}")
    for text in expand_pattern(template):
        print(text)


if __name__ == "__main__":
    main()

