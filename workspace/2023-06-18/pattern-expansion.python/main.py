import re
import typing


def main():
    for string in expand_pattern("file-[1-3]-[A,B,C].txt"):
        print(string)


def expand_pattern(string: str) -> typing.Generator[str, None, None]:
    if match := re.search(r"\[(\d+)-(\d+)\]", string):
        min = int(match[1])
        max = int(match[2])
        for n in range(min, max + 1):
            yield from expand_pattern(f"{string[:match.start()]}{n}{string[match.end():]}")
        return

    if match := re.search(r"\[(\w+(:?,\w+)*)\]", string):
        for s in match[1].split(","):
            yield from expand_pattern(f"{string[:match.start()]}{s}{string[match.end():]}")
        return

    yield string


if __name__ == "__main__":
    main()

