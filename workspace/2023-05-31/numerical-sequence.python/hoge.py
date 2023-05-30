import abc


class ApiBase(abc.ABC):
    """
    """


class JsonApiBase(ApiBase):
    """
    """


class HogeApi(object):

    def execute(self, params):
        ...

    def getBody(self, params):
        ...


def main():
    print("OK")


if __name__ == "__main__":
    main()

