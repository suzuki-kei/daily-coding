from trivial_comment import *


def main():
    text = read_text_file("data/a.py")
    replaced = TrivialCommentRemover().remove(text)

    print("=" * 60)
    print(text)
    print("=" * 60)
    print(replaced)
    print("=" * 60)


def read_text_file(file_path: str) -> str:
    with open(file_path, "r") as file:
        return file.read()


if __name__ == "__main__":
    main()

