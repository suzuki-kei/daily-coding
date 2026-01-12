"""
    テキストを読み上げる機能を提供する.
"""
import abc
import random
import shutil
import subprocess
import typing


class Speaker(abc.ABC):
    """
        テキストを読み上げる機能の抽象クラス.
    """

    @abc.abstractmethod
    def speak(self, text: str) -> bool:
        """
            テキストを読み上げる.

            Arguments
            =========
            text: str
                読み上げるテキスト.

            Returns
            =======
            bool
                テキストの読み上げに成功した場合に True.
                外部コマンドが存在しないなど, テキストの読み上げに失敗した場合は False.
        """


class NullSpeaker(Speaker):
    """
        何も読み上げない Speaker.
        (Null Device パターン)
    """

    def speak(self, text: str) -> bool:
        return True


class ShellCommandSpeaker(Speaker):
    """
        シェルコマンドを用いる Speaker の抽象クラス.

        コンストラクタで指定されたシェルコマンドを用いて Speaker.speak() を実装する.
    """

    def __init__(self, command: str):
        """
            指定された関数で初期化する.

            Arguments
            =========
            command: str
                テキストの読み上げに使用するシェルコマンド.
        """
        self.command = command

    def speak(self, text: str) -> bool:
        if not shutil.which(self.command):
            return False

        subprocess.run([self.command, text])
        return True


class SayCommandSpeaker(ShellCommandSpeaker):
    """
        say コマンドを用いる Speaker.
    """

    def __init__(self):
        super().__init__("say")


class SpeakerChain(Speaker):
    """
        複数の Speaker を保持し, 読み上げに成功するまで順番に Speaker.speak() を呼び出す.
        (Chain of Responsibility パターン)
    """

    def __init__(self, speakers: list[Speaker]):
        self.speakers = speakers.copy()

    def speak(self, text: str) -> bool:
        for speaker in self.speakers:
            if speaker.speak(text):
                return True
        return False


def default_speaker_chain():
    speakers = [
        SayCommandSpeaker(),
    ]
    random.shuffle(speakers)
    speakers.append(NullSpeaker())
    return SpeakerChain(speakers)

