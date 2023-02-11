import printing
import speaking


def main():
    text = "Hello"
    printer = printing.default_printer_chain()
    speaker = speaking.default_speaker_chain()
    printer.print(text)
    speaker.speak(text)


if __name__ == "__main__":
    main()

