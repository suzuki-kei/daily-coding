"""
    テキストを表示する機能を提供する.
"""
import abc
import random
import shutil
import subprocess
import typing


class Printer(abc.ABC):
    """
        テキストを表示する機能の抽象クラス.
    """

    @abc.abstractmethod
    def print(self, text: str) -> bool:
        """
            テキストを表示する.

            Arguments
            =========
            text: str
                表示するテキスト.

            Returns
            =======
            bool
                テキストの表示に成功した場合に True.
                外部コマンドが存在しないなど, テキストの出力に失敗した場合は False.
        """


class NullPrinter(Printer):
    """
        何も出力しない Printer.
        (Null Device パターン)
    """

    def print(self, text: str) -> bool:
        return True


class PythonFunctionPrinter(Printer):
    """
        Python 関数を用いる Printer の抽象クラス.

        コンストラクタで指定された関数を用いて Printer.print() を実装する.
    """

    def __init__(self, function: typing.Callable[[str], bool]):
        """
            指定された関数で初期化する.

            Arguments
            =========
            function: typing.Callable[[str], bool]
                テキストの出力に使用する関数.
        """
        self.function = function

    def print(self, text: str) -> bool:
        return self.function(text) != False


class PrintFunctionPrinter(PythonFunctionPrinter):
    """
        print() 関数を用いる Printer.
    """

    def __init__(self):
        super().__init__(print)


class ShellCommandPrinter(Printer):
    """
        シェルコマンドを用いる Printer の抽象クラス.

        コンストラクタで指定されたシェルコマンドを用いて Printer.print() を実装する.
    """

    def __init__(self, command: str):
        """
            指定されたシェルコマンドで初期化する.

            Arguments
            =========
            command: str
                テキストの出力に使用するシェルコマンド.
        """
        self.command = command

    def print(self, text: str) -> bool:
        if not shutil.which(self.command):
            return False

        subprocess.run([self.command, text])
        return True


class FigletCommandPrinter(ShellCommandPrinter):
    """
        figlet を用いる Printer.
    """

    def __init__(self):
        super().__init__("figlet")


class CowsayCommandPrinter(ShellCommandPrinter):
    """
        cowsay を用いる Printer.
    """

    def __init__(self):
        super().__init__("cowsay")


class PrinterChain(Printer):
    """
        複数の Printer を保持し, 表示に成功するまで順番に Printer.print() を呼び出す.
        (Chain of Responsibility パターン)
    """

    def __init__(self, printers: list[Printer]):
        self.printers = printers.copy()

    def print(self, text: str) -> bool:
        for printer in self.printers:
            if printer.print(text):
                return True
        return False


def default_printer_chain():
    printers = [
        CowsayCommandPrinter(),
        FigletCommandPrinter(),
        PrintFunctionPrinter(),
    ]
    random.shuffle(printers)
    printers.append(NullPrinter())
    return PrinterChain(printers)

