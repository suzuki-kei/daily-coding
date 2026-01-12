import inspect


def parameterized(tuples: list[tuple]) -> callable:

    def decorator(method: callable) -> None:
        f_locals = inspect.currentframe().f_back.f_locals
        f_locals |= make_wrapper_map(method, tuples)

    def make_wrapper_map(method: callable, tuples: list[tuple]):
        return {
            wrapper.__name__: wrapper
            for wrapper in make_wrappers(method, tuples)
        }

    def make_wrappers(method: callable, tuples: list[tuple]):
        return [
            make_wrapper(method, tuple, index)
            for index, tuple in enumerate(tuples)
        ]

    def make_wrapper(method: callable, tuple: tuple, index: int):
        wrapper = lambda self: method(self, *tuple)
        wrapper.__name__ = f"{method.__name__}_{index + 1}"
        return wrapper

    return decorator

